//
//  DirectionalDemandReleaseViewController.m
//  itop
//
//  Created by huangli on 2018/4/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DirectionalDemandReleaseViewController.h"
#import "DirectionalDemandReleaseStore.h"
#import "DirectionalDemandReleaseViewCell.h"
#import "DirectionalDemandReleaseDataSource.h"
#import "CompanySigningStore.h"
#import "DesignerListStore.h"
#import "H5ListStore.h"

#define REGIONAL @"地域优先"
#define INDUSTRY @"行业"
#define DESGINER @"设计师"
#define CASE @"参考案例"
#define PICTURE @"参考图片"

static NSString *const DirectionalDemandReleaseCellIdentifier = @"DirectionalDemandRelease";

@interface DirectionalDemandReleaseViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,SubmitFileManagerDelegate>

@property (strong, nonatomic)DirectionalDemandReleaseDataSource *directionalDemandReleaseDataSource;

@property (strong, nonatomic) IBOutlet UIView *foodView;
@property (weak, nonatomic) IBOutlet UIButton *agreedButton;
@property (weak, nonatomic) IBOutlet UIView *agreedView;
@property (weak, nonatomic) IBOutlet UIButton *protocolButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic, strong)NSArray *provinceArray; // 省份
@property (nonatomic, strong)NSArray *cityArray;//城市

@property (nonatomic, strong)NSArray *industryArray; // 行业／1级
@property (nonatomic, strong)NSArray *industrySubArray;//行业／子级

@property (nonatomic, strong)Province *province; //选择省份
@property (nonatomic, strong)Province *city; //选择的城市

@property (nonatomic, strong)TagList *superTag; //选择行业 父级
@property (nonatomic, strong)TagList *subTag; //选择行业 子级

@property (nonatomic, strong)NSString *industry; //选择的行业／父级
@property (nonatomic, strong)NSString *subIndustry; //选择的行业／子级

@property (nonatomic, strong)NSArray *desginList; // 设计师
@property (nonatomic, strong)DesignerList *desgin;

@property (nonatomic, strong)NSArray *desginProduct; // 设计师作品
@property (nonatomic, strong)H5List *selectH5;//选择的作品
@property (nonatomic, strong)DemandEdit *selectDemandEdit; // 当前选项
@property (strong, nonatomic)CustomRequirementsDetail *customRequirementsDetail; //编辑详情

@property (nonatomic, strong)AlertView *alertView; //弹窗
@property (nonatomic, assign)NSInteger selectRow; //选择类型

@end

@implementation DirectionalDemandReleaseViewController

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
    
    if (_demandType == DemandTypeDirectional) {
        self.title = @"定向需求";
    } else {
        
        self.title = @"竞标需求";
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
    [self setupTableFoodView];
    [self setupTabelFoodView];
    
    if (_demandType == DemandTypeBidding) {
        
        [SubmitFileManager sheardSubmitFileManager].delegate = self;
        [[SubmitFileManager sheardSubmitFileManager] addPictrueViewToViewController:self.view];
        [SubmitFileManager sheardSubmitFileManager].photoView.howMany = @"1";
    }
}

-(void)setupTabelFoodView{
    
    UIView *foodView = [[UIView alloc]init];
    foodView.frame = _foodView.frame;
    [foodView addSubview:_foodView];
    self.tableView.tableFooterView = foodView;
}

-(void)setupTableFoodView{
    
    _agreedView.layer.cornerRadius = _agreedView.height/2;
    _agreedView.layer.masksToBounds = YES;
    _submitButton.layer.cornerRadius = _submitButton.height/2;
    _submitButton.layer.masksToBounds = YES;
   [_submitButton.layer addSublayer: DEFULT_BUTTON_CAGRADIENTLAYER(_submitButton)];
}

-(void)refreshDesginListData{
    
    [[Global sharedSingleton] createProgressHUDInView:self.view withMessage:@"加载中..."];
    [[UserManager shareUserManager]designerlistWithPageIndex:1 PageCount:1000000 designerListType:DesignerListTypeHome searchKey:nil];
    [UserManager shareUserManager].designerlistSuccess = ^(NSArray * arr){
        
        self.desginList = [[DesignerListStore shearDesignerListStore] configurationMenuWithMenu:arr];
         [MBProgressHUD hideHUDForView:self.view animated:NO];
        
        if (_demandAddType == DemandAddTypeOnEdit || _demandAddType == DemandAddTypeOnProduct) {
            BOOL isDesginer = NO;
            NSNumber *userId = _demandAddType == DemandAddTypeOnEdit ?_customRequirementsDetail.demand.designer_user_id : _desginer_id;
            for (DesignerList *designer in self.desginList) {
               
            
                if ([designer.id isEqualToNumber:userId]) {
                    isDesginer = YES;
                    _desgin = designer;
                   [self refreshDesginProductDataWithDesginID:designer.id isFirst:YES];
                }
            }
            
            if (!isDesginer) {
                
                self.dataArray = [[DirectionalDemandReleaseStore shearDirectionalDemandReleaseStore]configurationDirectionalDemandReleaseEditWithDemandType:_demandType customRequirementsDetail:_customRequirementsDetail  isEdit:YES];
                [self setupSelectItme];
                [self steupTableView];
            }
        }
    };
}

-(void)refreshDesginProductDataWithDesginID:(NSNumber *)desgin_id isFirst:(BOOL)isFirst{
    
    [[Global sharedSingleton] createProgressHUDInView:self.view withMessage:@"加载中..."];
    [[UserManager shareUserManager] designerProductListWithDesigner:desgin_id PageIndex:1 PageCount:10000];
    [UserManager shareUserManager].designerProductListSuccess = ^(NSArray * obj){
        
        self.desginProduct = [[H5ListStore shearH5ListStore]configurationMenuWithMenu:obj] ;
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        
        if (isFirst) {
          
            if (_demandAddType == DemandAddTypeOnEdit || _demandAddType == DemandAddTypeOnProduct) {
                NSNumber *caseId = _demandAddType == DemandAddTypeOnEdit ?_customRequirementsDetail.demand.demand_case_id : _desginer_product_id;
                for (H5List *h5 in self.desginProduct) {
                    
                    if ([h5.id isEqualToNumber:caseId]) {
                        
                        _selectH5 = h5;
                    }
                }
                self.dataArray = [[DirectionalDemandReleaseStore shearDirectionalDemandReleaseStore]configurationDirectionalDemandReleaseEditWithDemandType:_demandType customRequirementsDetail:_customRequirementsDetail isEdit:YES];
                [self setupSelectItme];
                [self steupTableView];
            }
        }
    };
}

-(void)initData{
    
    [super initData];
    
    _provinceArray = [[CompanySigningStore shearCompanySigningStore]provinceArray];
    Province *province = _provinceArray[0];
    _cityArray = province.cityArray;
    
    if ([[CompanySigningStore shearCompanySigningStore]superTagList].count == 0) {
        
        [[UserManager shareUserManager]hometagListWithType:TagTypeTrade];
        [UserManager shareUserManager].homeTagListSuccess = ^(id arr){
            
            [[CompanySigningStore shearCompanySigningStore]confitionIndustryWithRequstIndustryArray:arr];
            _industryArray = [[CompanySigningStore shearCompanySigningStore]superTagList];
            TagList *tag = _industryArray[0];
            _industrySubArray = tag.subTagArray;

            [self setupindustry];
        };
    } else {
        _industryArray = [[CompanySigningStore shearCompanySigningStore]superTagList];
        TagList *tag = _industryArray[0];
        _industrySubArray = tag.subTagArray;
        [self setupindustry];
    }

    if (_demandAddType == DemandAddTypeOnEdit) {
        [[UserManager shareUserManager]customRequirementsDetailWithDetailId:_demand_id];
        [UserManager shareUserManager].customRequirementsSuccess = ^(NSDictionary *obj){
            
            _customRequirementsDetail = [[CustomRequirementsDetail alloc]initWithDictionary:obj error:nil];
            _customRequirementsDetail.demand.descrip = obj[@"demand"][@"description"];
            
            if (_customRequirementsDetail.demand.province) { //编辑需要提取省份
              
                _province = [[CompanySigningStore shearCompanySigningStore]provinceWithProvinceCode:_customRequirementsDetail.demand.province];
            }
            if (_customRequirementsDetail.demand.city) { //编辑需要提取城市
                
                _city = [[CompanySigningStore shearCompanySigningStore] cityWithCityCode:_customRequirementsDetail.demand.city provinceCode:_customRequirementsDetail.demand.province];
            }
            
            if (![Global stringIsNullWithString:_customRequirementsDetail.demand.trade]) {
                NSString *segmentationString;
                if ([_customRequirementsDetail.demand.trade rangeOfString:@","].location != NSNotFound) {
                    segmentationString = @",";//C端提交的格式  也是最终的格式
                } else if ([_customRequirementsDetail.demand.trade rangeOfString:@"-"].location != NSNotFound){
                    segmentationString = @"-";  //B端提交的格式
                }else if ([_customRequirementsDetail.demand.trade rangeOfString:@"、"].location != NSNotFound){
                    segmentationString = @"、"; //A端提交的格式
                } else{
                    
                }
                NSArray *tagArr = [_customRequirementsDetail.demand.trade componentsSeparatedByString:segmentationString];//行业
                _superTag = [[CompanySigningStore shearCompanySigningStore]superTagWithTagId:[NSNumber numberWithInteger:[tagArr[0] integerValue]]];
                _subTag = [[CompanySigningStore shearCompanySigningStore] subTagWithTagId:[NSNumber numberWithInteger:[tagArr[1] integerValue]] superTagId:[NSNumber numberWithInteger:[tagArr[0] integerValue]]];
            }
            
             [self refreshDesginListData];
        };
    } else{
        
        self.dataArray = [[DirectionalDemandReleaseStore shearDirectionalDemandReleaseStore]configurationDirectionalDemandReleaseEditWithDemandType:_demandType customRequirementsDetail:_customRequirementsDetail isEdit:NO];
         [self refreshDesginListData];
    }
}

-(void)setupindustry{
    
    _industryArray = [[CompanySigningStore shearCompanySigningStore]superTagList];
    TagList *tag = _industryArray[0];
    _industrySubArray = tag.subTagArray;
}

-(void)setupSelectItme{ //替换部分内容 id->title/name
    
    for (DemandEdit *info in self.dataArray) {
        
        if (![Global stringIsNullWithString:info.content] && [info.title isEqualToString:@"地域优先"]) {
            info.content = [NSString stringWithFormat:@"%@,%@",_province.address, _city.address];
        }
        
        if (![Global stringIsNullWithString:info.content] && [info.title isEqualToString:@"行业"]) {
            info.content = [NSString stringWithFormat:@"%@,%@",_superTag.name, _subTag.name];
        }
        
        if (![Global stringIsNullWithString:info.content] && [info.title isEqualToString:@"设计师"]) {
            
            for (DesignerList *desgin in self.desginList) {
                
                if (desgin.id == _desgin.id) {
                    info.content = desgin.nickname;
                }
            }
        }
        
        if (![Global stringIsNullWithString:info.content] && [info.title isEqualToString:@"参考案例"]) {
            
            for (H5List *h5 in self.desginProduct) {
                
                if (h5.id == _selectH5.id) {
                    info.content = h5.title;
                }
            }
        }
    }
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
    self.directionalDemandReleaseDataSource = [[DirectionalDemandReleaseDataSource alloc]initWithItems:self.dataArray cellIdentifier:DirectionalDemandReleaseCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.directionalDemandReleaseDataSource
                        cellIdentifier:DirectionalDemandReleaseCellIdentifier
                               nibName:@"DirectionalDemandReleaseViewCell"];
    
    self.tableView.dataSource = self.directionalDemandReleaseDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"DirectionalDemandReleaseViewCell"] forCellReuseIdentifier:DirectionalDemandReleaseCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DemandEdit * demandEdit = [self.directionalDemandReleaseDataSource itemAtIndexPath:indexPath];
    if([demandEdit.title isEqualToString:PICTURE]){
        
        return 80;
    } else if([demandEdit.title isEqualToString:@"需求"]){
        
        return 122;
    } else{
        
        return 60;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
   
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    _selectRow = indexPath.row;
    _selectDemandEdit = [self.directionalDemandReleaseDataSource itemAtIndexPath:indexPath];
    if (_selectDemandEdit.editType == EditTypeSelectItem || _selectDemandEdit.editType == EditTypeSelectTime) {
        
        if (_desginProduct.count == 0 && [_selectDemandEdit.title isEqualToString:CASE]) {
            
            BOOL isDesing =  NO;
            for (DemandEdit *demant in self.dataArray) {
                
                if ([demant.title isEqualToString:DESGINER] && ![Global stringIsNullWithString:demant.content]) {
                    
                    isDesing = YES;
                }
            }
 
            if (isDesing) {
                
                [self showToastWithMessage:@"该设计师没有作品"];
                return;
            }  else {
                
                [self showToastWithMessage:@"请选择设计师"];
                return;
            }
        }
        [self showAlertViewWithItem:_selectDemandEdit];
    }
}

-(void)showAlertViewWithItem:(DemandEdit*)info {

    NSString *string   = [NSString stringWithFormat:@"请选择%@",info.title];
    NSArray *superArray = [NSArray array];
    NSArray *subArray = [NSArray array];
    switch (info.pickViewType) {
            
        case PickViewTypeProvince:
            
            superArray = _provinceArray;
            subArray = _cityArray;
            break;
        case PickViewTypeIndustry:
            
            superArray = _industryArray;
            subArray = _industrySubArray;
            break;
        case PickViewTypeDesginer:
            superArray = _desginList;
            break;
            
        case PickViewTypeProduct:
            superArray = _desginProduct;
            break;
        default:
            break;
    }
    
    _alertView = [[AlertView alloc]initWithTitle:string
                                         message:nil
                                         sureBtn:@"确定"
                                       cancleBtn:@"取消"
                                    pickViewType:info.pickViewType
                                      superArray:superArray
                                        subArray:subArray];
    
    
    __weak typeof(self) weakSelf = self;
    _alertView.selectResult = ^( id superResult, id subResult) {
        
        [weakSelf updataInfomationWithselectSuperItme:superResult selectSubItme:subResult];
    };
    if (info.pickViewType == PickViewTypeEdit) { //赋予原来的值
        
        [_alertView setupInputNameTFWithPlaceholder:info.title content:info.content];
    } else {
        
        [_alertView setupPickViewWithContent:info.content];
    }
    [_alertView showXLAlertView];
}

-(void)updataInfomationWithselectSuperItme:(id)selectSuperItme
                             selectSubItme:(id)selectSubItme{
    
    Infomation *info = self.dataArray[_selectRow];
    
    switch (info.pickViewType) {

        case PickViewTypeProvince:
            
            _province = (Province *)selectSuperItme;
            _city = (Province *)selectSubItme;
            
            info.content = [NSString stringWithFormat:@"%@,%@",_province.address,_city.address];
            break;
        case PickViewTypeIndustry:
            _superTag = (TagList *)selectSuperItme;
            _subTag = (TagList *)selectSubItme;
            info.content = [NSString stringWithFormat:@"%@,%@",_superTag.name,_subTag.name];
            break;
          
        case PickViewTypeDate:

            _selectDemandEdit.content = [[Global sharedSingleton]stringFromDate:(NSDate *)selectSuperItme pattern:TIME_PATTERN_day];
            break;
        case PickViewTypeDesginer:
            _desgin = (DesignerList *)selectSuperItme;
            [self selectDesginer];
            break;
            
        case PickViewTypeProduct:
            
            _selectH5 = (H5List*)selectSuperItme;
            _selectDemandEdit.content = _selectH5.title;
            break;
            
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)selectDesginer{
    
    DemandEdit *demand = self.dataArray[0];
    if (![demand.content isEqualToString:_desgin.nickname]) {
        
        DemandEdit *demand1 = self.dataArray[1];
        demand1.content = nil;
        _selectDemandEdit.content = _desgin.nickname;
        [self refreshDesginProductDataWithDesginID:_desgin.id isFirst:NO];
    }
}

- (IBAction)protocol:(UIButton *)sender {

    [UIManager protocolWithProtocolType:ProtocolTypeCustomRequirements];
}

- (IBAction)submit:(UIButton *)sender {
  
    for (DemandEdit *edit in self.dataArray) {
        
        if (edit.inamge== nil && [edit.title isEqualToString:PICTURE] && edit.isMust) {
            
            [self showToastWithMessage:@"请选择图片"];
            
        } else if([Global stringIsNullWithString:edit.content] && edit.isMust) {
            
            switch (edit.editType) {
                case EditTypeTextFied:
                case EditTypeTextView:
                    [self showToastWithMessage:[NSString stringWithFormat:@"请输入%@",edit.title]];
                     return;
                    break;
                case EditTypeSelectTime:
                case EditTypeSelectItem:
                    [self showToastWithMessage:[NSString stringWithFormat:@"请选择%@",edit.title]];
                     return;
                    break;
                default:
                    break;
            }
        }
    }
    
    if (!_agreedButton.isSelected) {
        
        [self showToastWithMessage:@"必须同意i-Top定制协议"];
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    for (DemandEdit *edit in self.dataArray) {
        
        if ([edit.title isEqualToString:REGIONAL]) {
            
            if (![Global stringIsNullWithString:edit.content]) {
                [parameters setObject:_city.code forKey:@"City"];
                [parameters setObject:_province.code forKey:@"Province"];
            }
        }else if([edit.title isEqualToString:DESGINER]) {
            
            [parameters setObject:_desgin.id forKey:edit.sendKey];
        }else if([edit.title isEqualToString:INDUSTRY]) {
            
            [parameters setObject:[NSString stringWithFormat:@"%@,%@",_superTag.id,_subTag.id] forKey:edit.sendKey];
            
        }else if([edit.title isEqualToString:CASE]) {
            
            [parameters setObject:_selectH5.id forKey:edit.sendKey];
        }else if(![edit.title isEqualToString:PICTURE]){
            
            [parameters setObject:edit.content forKey:edit.sendKey];
        }
    }
    
    [parameters setObject:[NSNumber numberWithInteger:_demandType] forKey:@"Demand_type"];
    if (_demandAddType == DemandAddTypeOnEdit) {
        [parameters setObject:_customRequirementsDetail.demand.id forKey:@"Id"];
    }
 
    if (_demandType == DemandTypeDirectional) {
    
        [[UserManager shareUserManager] customRequirementsParameters:parameters demandAddType:_demandAddType];
        [UserManager shareUserManager] .customRequirementsSuccess = ^(id obj){
            
            [self alertOperation];
        };
    } else {
        
            if ([[SubmitFileManager sheardSubmitFileManager]getSelectedPicktures].count != 0) {
                
                [[SubmitFileManager sheardSubmitFileManager]compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:self andType:nil];
                [UserManager shareUserManager].submitFileSuccess = ^ (id obj){
                    
                    NSString *fileUrl = [NSString stringWithFormat:@"%@",obj];
                    [parameters setObject:fileUrl forKey:@"Reference_img"];
                    [[UserManager shareUserManager] customRequirementsParameters:parameters demandAddType:_demandAddType];
                    [UserManager shareUserManager] .customRequirementsSuccess = ^(id obj){
                        
                        [self alertOperation];
                    };
                };
                
            } else {
                
                if (_demandAddType == DemandAddTypeOnEdit && _customRequirementsDetail.demand.reference_img ) {
                    
                      [parameters setObject:_customRequirementsDetail.demand.reference_img forKey:@"Reference_img"];
                    
                }
                [[UserManager shareUserManager] customRequirementsParameters:parameters demandAddType:_demandAddType];
                [UserManager shareUserManager] .customRequirementsSuccess = ^(id obj){
                    
                    [self alertOperation];
                };
            }
    }
}

- (IBAction)agreed:(UIButton *)sender {
   
    _agreedButton.selected = !_agreedButton.selected;
    if (_agreedButton.selected) {
        
        _agreedView.backgroundColor = UIColorFromRGB(0xfda5ed);
    } else {
        _agreedView.backgroundColor = UIColorFromRGB(0xe0e3e6);
    }
}

#pragma Mark-提交获取图片url的协议方法
-(void)compressionAndTransferPicturesWithArray:(NSArray *)array{
    
    for (DemandEdit *edit in self.dataArray) {
        
        if ([edit.title isEqualToString:@"参考图片"]) {
            edit.inamge = [array lastObject];
        }
    }
//    _selectDemandEdit.inamge = [array lastObject];
    [self.tableView reloadData];
}

-(void)alertOperation{
    
    NSString *string = _demandType == DemandTypeDirectional ? @"定向需求已经发布" : @"竞标需求已经发布";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续发布" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (_demandAddType == DemandAddTypeOnEdit) {
            
            [self back];
        }
        [UIManager sharedUIManager].customRequirementsBackOffBolck(nil);
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
