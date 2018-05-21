//
//  EditCaseViewController.m
//  itop
//
//  Created by huangli on 2018/5/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "EditCaseViewController.h"
#import "DirectionalDemandReleaseStore.h"
#import "DirectionalDemandReleaseViewCell.h"
#import "DirectionalDemandReleaseDataSource.h"

static NSString *const EditCaseCellIdentifier = @"EditCase";

@interface EditCaseViewController ()<SubmitFileManagerDelegate>

@property (strong, nonatomic)DirectionalDemandReleaseDataSource *directionalDemandReleaseDataSource;
@property (weak, nonatomic) IBOutlet UIView *foodView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic, strong)DemandEdit *selectDemandEdit; // 当前选项
@property (nonatomic, strong)CaseDetail *caseDetail; //案例详情

@end

@implementation EditCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initNavigationBarItems{
    
    self.title = @"添加案例";
}

-(void)initData{
    
    [super initData];
    
    if (_isEdit) {
        
        [[UserManager shareUserManager]caseDetailWithCaseId:_editCase.id];
        [UserManager shareUserManager].myCaseListSuccess = ^(NSDictionary *obj){
          
            _caseDetail = [[CaseDetail alloc]initWithDictionary:obj error:nil];
            self.dataArray = [[DirectionalDemandReleaseStore shearDirectionalDemandReleaseStore]configurationCaseWitiCaseDetail:_caseDetail isEdit:_isEdit];
            
            [self steupTableView];
        };
    } else {
        
        self.dataArray = [[DirectionalDemandReleaseStore shearDirectionalDemandReleaseStore]configurationCaseWitiCaseDetail: nil isEdit:_isEdit];
    }
}

-(void)initView{
    
    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ScreenHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(kDevice_Is_iPhoneX ? -34 : 0);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self steupTableView];
    [self setupTabelFoodView];
        [SubmitFileManager sheardSubmitFileManager].delegate = self;
        [[SubmitFileManager sheardSubmitFileManager] addPictrueViewToViewController:self.view];
        [SubmitFileManager sheardSubmitFileManager].photoView.howMany = @"1";
}

-(void)setupTabelFoodView{
    
    UIView *foodView = [[UIView alloc]init];
    foodView.frame = _foodView.frame;
    [foodView addSubview:_foodView];
    self.tableView.tableFooterView = foodView;
    _submitButton.layer.cornerRadius = _submitButton.height/2;
    _submitButton.layer.masksToBounds = YES;
    [_submitButton.layer addSublayer: DEFULT_BUTTON_CAGRADIENTLAYER(_submitButton)];
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(DirectionalDemandReleaseViewCell *cell , DemandEdit *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item];
        if (item.editType == EditTypeSelectImage || item.editType == EditTypeTextFied
            || item.editType == EditTypeTextView) {
            
            cell.selectImageBlock = ^(id sender ,DirectionalDemandReleaseViewCell *cell){
                
                NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
                _selectDemandEdit  = [self.directionalDemandReleaseDataSource itemAtIndexPath:indexPath];
                _selectDemandEdit.content = [NSString stringWithFormat:@"%@",(NSString *)sender];
            };
        }
    };
    self.directionalDemandReleaseDataSource = [[DirectionalDemandReleaseDataSource alloc]initWithItems:self.dataArray cellIdentifier:EditCaseCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.directionalDemandReleaseDataSource
                        cellIdentifier:EditCaseCellIdentifier
                               nibName:@"DirectionalDemandReleaseViewCell"];
    
    self.tableView.dataSource = self.directionalDemandReleaseDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"DirectionalDemandReleaseViewCell"] forCellReuseIdentifier:EditCaseCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DemandEdit * demandEdit = [self.directionalDemandReleaseDataSource itemAtIndexPath:indexPath];
    if(demandEdit.editType == EditTypeSelectImage){
        
        return 80;
    } else if(demandEdit.editType == EditTypeTextView ){
        
        return 122;
    } else{
        
        return 60;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    _selectDemandEdit = [self.directionalDemandReleaseDataSource itemAtIndexPath:indexPath];
}

- (IBAction)submit:(UIButton *)sender {
    
    BOOL isChoice = NO;
    for (DemandEdit *edit in self.dataArray) {
        
        if ([edit.title isEqualToString:@"案例封面"] && edit.inamge == nil && !_isEdit) {
            
            [self showToastWithMessage:@"请选择封面"];
            return;
//            if (!_isEdit && edit.inamge == nil) {
//
//                [self showToastWithMessage:@"请选择封面"];
//                return;
//            }
 
        }else if([edit.title isEqualToString:@"案例链接"] || [edit.title isEqualToString:@"网盘地址"]){
            
            if (![Global stringIsNullWithString:edit.content]) {
                isChoice = YES;
            }
            
        }else if([Global stringIsNullWithString:edit.content] && ![edit.title isEqualToString:@"案例封面"]) {
            
            [self showToastWithMessage:[NSString stringWithFormat:@"请输入%@",edit.title]];
            return;
        } else {
            
        }
    }
    
    if (!isChoice) {
        
         [self showToastWithMessage:@"必须填写一个作品地址"];
        return;
    }

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    for (DemandEdit *edit in self.dataArray) {
        
        if (![edit.title isEqualToString:@"案例封面"] && ![Global stringIsNullWithString:edit.content]) {
            
            [parameters setObject:edit.content forKey:edit.sendKey];
        }
        
    }
    if (_isEdit) {
        [parameters setObject:_editCase.id forKey:@"Id"];
    }
        if ([[SubmitFileManager sheardSubmitFileManager]getSelectedPicktures].count != 0) {
            
            [[SubmitFileManager sheardSubmitFileManager]compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:self andType:nil];
            [UserManager shareUserManager].submitFileSuccess = ^ (id obj){
                
                NSString *fileUrl = [NSString stringWithFormat:@"%@",obj];
                [parameters setObject:fileUrl forKey:@"Cover_img"];
                [[UserManager shareUserManager] editCaseWithParameters:parameters isUpdate:_isEdit];
                [UserManager shareUserManager] .myCaseListSuccess = ^(id obj){
                    
                    [self alertOperation];
                };
            };
            
        } else {
            
            if (_isEdit && _editCase.cover_img ) {
                
                [parameters setObject:_caseDetail.info.cover_img forKey:@"Cover_img"];
            }
            [[UserManager shareUserManager] editCaseWithParameters:parameters isUpdate:_isEdit];
            [UserManager shareUserManager] .myCaseListSuccess = ^(id obj){
                
                [self alertOperation];
            };
        }
}

#pragma Mark-提交获取图片url的协议方法
-(void)compressionAndTransferPicturesWithArray:(NSArray *)array{
    
    for (DemandEdit *edit in self.dataArray) {
        
        if ([edit.title isEqualToString:@"案例封面"]) {
            edit.inamge = [array lastObject];
        }
    }
    [self.tableView reloadData];
}

-(void)alertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"添加案例成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续发布" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self back];
        [UIManager sharedUIManager].editCaseBackOffBolck(nil);
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
