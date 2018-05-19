//
//  UploadProductLinkViewController.m
//  itop
//
//  Created by huangli on 2018/5/8.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "UploadProductLinkViewController.h"
#import "DirectionalDemandReleaseStore.h"
#import "DirectionalDemandReleaseViewCell.h"
#import "DirectionalDemandReleaseDataSource.h"

static NSString *const UploadProductLinkCellIdentifier = @"UploadProductLink";

@interface UploadProductLinkViewController ()<SubmitFileManagerDelegate>

@property (strong, nonatomic)DirectionalDemandReleaseDataSource *directionalDemandReleaseDataSource;
@property (weak, nonatomic) IBOutlet UIView *foodView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic, strong)DemandEdit *selectDemandEdit; // 当前选项

@end

@implementation UploadProductLinkViewController

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
    
    self.title = @"作品上传";
}

-(void)initData{
    
    [super initData];
    self.dataArray = [[DirectionalDemandReleaseStore shearDirectionalDemandReleaseStore]configurationUploadProduct];
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
    self.directionalDemandReleaseDataSource = [[DirectionalDemandReleaseDataSource alloc]initWithItems:self.dataArray cellIdentifier:UploadProductLinkCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.directionalDemandReleaseDataSource
                        cellIdentifier:UploadProductLinkCellIdentifier
                               nibName:@"DirectionalDemandReleaseViewCell"];
    
    self.tableView.dataSource = self.directionalDemandReleaseDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"DirectionalDemandReleaseViewCell"] forCellReuseIdentifier:UploadProductLinkCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DemandEdit * demandEdit = [self.directionalDemandReleaseDataSource itemAtIndexPath:indexPath];
    if(demandEdit.editType == EditTypeSelectImage){
        
        return 140;
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

#pragma Mark-提交获取图片url的协议方法
-(void)compressionAndTransferPicturesWithArray:(NSArray *)array{
    
    for (DemandEdit *edit in self.dataArray) {
        
        if ([edit.title isEqualToString:@"作品封面"]) {
            edit.inamge = [array lastObject];
        }
    }
    [self.tableView reloadData];
}

- (IBAction)submit:(UIButton *)sender {
    
    BOOL isChoice = NO;
    for (DemandEdit *edit in self.dataArray) {
        
        if ([edit.title isEqualToString:@"作品封面"] && edit.inamge == nil) {
            
            [self showToastWithMessage:@"请选择封面"];
            return;
            
        }else if([edit.title isEqualToString:@"作品链接"] || [edit.title isEqualToString:@"网盘地址"]){
            
            if (![Global stringIsNullWithString:edit.content]) {
                isChoice = YES;
            }
            
        }else if([Global stringIsNullWithString:edit.content] && ![edit.title isEqualToString:@"作品封面"]) {
            
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
    
    [parameters setObject:_demand_id forKey:@"Demand_id"];
    [parameters setObject:_user_id forKey:@"User_id"];
    
    for (DemandEdit *edit in self.dataArray) {
        
        if (![edit.title isEqualToString:@"作品封面"] && ![Global stringIsNullWithString:edit.content]) {
            
            [parameters setObject:edit.content forKey:edit.sendKey];
        }
        
    }
    if ([[SubmitFileManager sheardSubmitFileManager]getSelectedPicktures].count != 0) {
        
        [[SubmitFileManager sheardSubmitFileManager]compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:self andType:nil];
        [UserManager shareUserManager].submitFileSuccess = ^ (id obj){
            
            NSString *fileUrl = [NSString stringWithFormat:@"%@",obj];
            [parameters setObject:fileUrl forKey:@"Cover_img"];
            [[UserManager shareUserManager] uploadfileWithParameters:parameters];
            [UserManager shareUserManager] .uploadProductSuccess = ^(id obj){

                [self alertOperation];
            };
        };
        
    } else {
        
        [[UserManager shareUserManager] uploadfileWithParameters:parameters];
        [UserManager shareUserManager] .uploadProductSuccess = ^(id obj){

            [self alertOperation];
        };
    }
}


-(void)alertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"上传作品成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续发布" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self back];
        if([UIManager sharedUIManager].uploadProductBackOffBolck){
           
            [UIManager sharedUIManager].uploadProductBackOffBolck(nil);
        }
        
        if ([UIManager sharedUIManager].customRequirementsRequestDataBackOffBolck) {
            [UIManager sharedUIManager].customRequirementsRequestDataBackOffBolck(nil);
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
