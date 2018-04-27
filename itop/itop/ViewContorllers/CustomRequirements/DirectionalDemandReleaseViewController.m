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

@property (nonatomic, strong)UIDatePicker *datePicker;
@property (nonatomic, strong)NSDate *selectDate;

@property (nonatomic, strong)UIPickerView *pickView;
@property (nonatomic, strong)NSArray *provinceArray; // 省份
@property (nonatomic, strong)NSArray *cityArray;//城市

@property (nonatomic, strong)NSArray *industryArray; // 行业／1级
@property (nonatomic, strong)NSArray *industrySubArray;//行业／子级

@property (nonatomic, strong)Province *province; //选择省份
@property (nonatomic, strong)Province *city; //选择的城市

@property (nonatomic, strong)NSString *industry; //选择的行业／父级
@property (nonatomic, strong)NSString *subIndustry; //选择的行业／子级

@property (nonatomic, strong)NSArray *desginList; // 设计师
@property (nonatomic, strong)DesignerList *desgin;

@property (nonatomic, strong)NSArray *desginProduct; // 设计师作品
@property (nonatomic, strong)H5List *selectH5;//选择的作品
@property (nonatomic, strong)DemandEdit *selectDemandEdit; // 当前选项
@property (strong, nonatomic)CustomRequirementsDetail *customRequirementsDetail; //编辑详情

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
    [self setupTimeView];
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
        
        if (_isEdit) {
            BOOL isDesginer = NO;
            for (DesignerList *designer in self.desginList) {
               
                if ([designer.id isEqualToNumber:_customRequirementsDetail.demand.designer_user_id]) {
                    isDesginer = YES;
                    _desgin = designer;
                   [self refreshDesginProductDataWithDesginID:designer.id isFirst:YES];
                }
            }
            
            if (!isDesginer) {
                
                self.dataArray = [[DirectionalDemandReleaseStore shearDirectionalDemandReleaseStore]configurationDirectionalDemandReleaseEditWithDemandType:_demandType customRequirementsDetail:_customRequirementsDetail desginerList:nil desginerProductList:nil province:_province city:_city isEdit:YES];
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
        
        if (_isEdit && isFirst) {
          
            for (H5List *h5 in self.desginProduct) {
                
                if ([h5.id isEqualToNumber:_customRequirementsDetail.demand.demand_case_id]) {
                    
                    _selectH5 = h5;
                }
            }
            self.dataArray = [[DirectionalDemandReleaseStore shearDirectionalDemandReleaseStore]configurationDirectionalDemandReleaseEditWithDemandType:_demandType customRequirementsDetail:_customRequirementsDetail desginerList:self.desginList desginerProductList:self.desginProduct province:_province city:_city isEdit:YES];
            [self steupTableView];

        }
    };
}

-(void)initData{
    
    [super initData];
    
    _provinceArray = [[CompanySigningStore shearCompanySigningStore]provinceArray];
    Province *province = _provinceArray[0];
    _cityArray = province.cityArray;
    
    _industryArray = [[[CompanySigningStore shearCompanySigningStore]industryArray] allKeys];
    NSString *industryKey = _industryArray[0];
    _industrySubArray = [[CompanySigningStore shearCompanySigningStore]industryArray][industryKey];

    if (_isEdit) {
        [[UserManager shareUserManager]customRequirementsDetailWithDetailId:_demand_id];
        [UserManager shareUserManager].customRequirementsSuccess = ^(NSDictionary *obj){
            
            _customRequirementsDetail = [[CustomRequirementsDetail alloc]initWithDictionary:obj error:nil];
            _customRequirementsDetail.demand.descrip = obj[@"demand"][@"description"];
            
            if (_customRequirementsDetail.demand.province) { //编辑需要提取省份
              
                for (Province *province in _provinceArray) {
                    
                    if ([province.code isEqualToString:_customRequirementsDetail.demand.province]) {
                        
                        _province = province;
                    }
                }
            }
            if (_customRequirementsDetail.demand.city) { //编辑需要提取城市
                
                for (Province *city in _cityArray) {
                    
                    if ([city.code isEqualToString:_customRequirementsDetail.demand.city]) {
                        
                        _city = city;
                    }
                }
            }
             [self refreshDesginListData];
        };
    } else{
        
        self.dataArray = [[DirectionalDemandReleaseStore shearDirectionalDemandReleaseStore]configurationDirectionalDemandReleaseEditWithDemandType:_demandType customRequirementsDetail:_customRequirementsDetail desginerList:nil desginerProductList:nil province:_province city:_city isEdit:NO];
         [self refreshDesginListData];
    }
//    self.dataArray = [[DirectionalDemandReleaseStore shearDirectionalDemandReleaseStore]configurationDirectionalDemandReleaseEditWithDemandType:_demandType customRequirementsDetail:_customRequirementsDetail];
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(DirectionalDemandReleaseViewCell *cell , DemandEdit *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item];
        if (item.editType == EditTypeSelectImage || item.editType == EditTypeTextFied
            || item.editType == EditTypeTextView) {
            
            cell.selectImageBlock = ^(id sender ,DirectionalDemandReleaseViewCell *cell){
                
                NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
                _selectDemandEdit  = [self.directionalDemandReleaseDataSource itemAtIndexPath:indexPath];
                if ([sender isKindOfClass:[UIButton class]]) {
                    
//                    UIButton *button = (UIButton *)sender;
//                    if ([button.imageView.image isEqual:[UIImage imageNamed:@"ruzhu_icon_add"]]) {
                        [[SubmitFileManager sheardSubmitFileManager]popupsSelectPhotoTipsView];
//                    } else {
//
//                        [[SubmitFileManager sheardSubmitFileManager]browsePicturesWithPictureArray:nil];
//                    }

                } else {
                  
                    _selectDemandEdit.content = [NSString stringWithFormat:@"%@",(NSString *)sender];
                }
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

-(void)setupTimeView{
    
    _datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, 120)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    
    _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    _selectDate = _datePicker.date;
    [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)dateChange:(UIDatePicker *)datePicker{
   
    _selectDate = datePicker.date;
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

-(void)showAlertViewWithItem:(DemandEdit*)demandEdit {

    UIView *view = [[UIView alloc] init];
    NSString *string ;
    
    if (demandEdit.editType == EditTypeSelectItem) {  //选择自定义项
        
        [self initPickViewWith:demandEdit];
        view.frame = self.pickView.frame;
        [view addSubview:self.pickView];
        
    } else {//选择时间
        view.frame = self.datePicker.frame;
        [view addSubview:self.datePicker];
    }
    string  = [NSString stringWithFormat:@"请选择%@",demandEdit.title];
    AlertView *alertView = [[AlertView alloc]initWithTitle:string
                                                   message:view
                                                   sureBtn:@"确定"
                                                 cancleBtn:@"取消"
                                              pickViewType:0];
    alertView.resultIndex = ^(NSInteger index ,PickViewType picViewType){
    
        if ([_selectDemandEdit.title isEqualToString:INDUSTRY]) {
            
            _selectDemandEdit.content = [NSString stringWithFormat:@"%@,%@",_industry,_subIndustry];
        }
        if ([_selectDemandEdit.title isEqualToString:REGIONAL]) {
            
            _selectDemandEdit.content = [NSString stringWithFormat:@"%@,%@",_province.address,_city.address];
        }
        
        if ([_selectDemandEdit.title isEqualToString:@"截稿时间"]) {
            
            _selectDemandEdit.content = [[Global sharedSingleton]stringFromDate:_selectDate pattern:TIME_PATTERN_day];
        }
        
        if ([_selectDemandEdit.title isEqualToString:DESGINER]) {
            
           
            DemandEdit *demand = self.dataArray[0];
            if (![demand.content isEqualToString:_desgin.nickname]) {
                
                DemandEdit *demand1 = self.dataArray[1];
                demand1.content = nil;
                _selectDemandEdit.content = _desgin.nickname;
                [self refreshDesginProductDataWithDesginID:_desgin.id isFirst:NO];
            }
        }
        [self.tableView reloadData];
    };
    
    [alertView showXLAlertView];
}

-(void)initPickViewWith:(DemandEdit *)demandEdit{
    
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, 120)];
    self.pickView.backgroundColor = [UIColor whiteColor];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    self.pickView.showsSelectionIndicator = YES;
    [self.pickView reloadAllComponents];
    if (![Global stringIsNullWithString:demandEdit.content] ) {
    
        if ([demandEdit.title isEqualToString:DESGINER]) {
            NSInteger  index;
            for (DesignerList *design in self.desginList) {
                
                if ([design.nickname isEqualToString:demandEdit.content]) {
                    index = [self.desginList indexOfObject:design];
                    [self.pickView selectRow:index inComponent:0 animated:NO];
                    return;
                }
            }
           
        } else if ([demandEdit.title isEqualToString:CASE]) {
            
        }else if ([demandEdit.title isEqualToString:INDUSTRY]) {
            
            [self industrypPositioningWithIndex:demandEdit.content];
            
        } else if ([demandEdit.title isEqualToString:REGIONAL]) {
             [self positioningwithindex:demandEdit.content];
        }
    }
}

#pragma mark 选择数据时将有数据的itme赋给已选择的temp
-(void)positioningwithindex:(NSString *)info{
    
    NSArray *arr = [info componentsSeparatedByString:@","];
    NSInteger index = 0 ;
    NSInteger inde2 = 0 ;
    for (Province *province in self.provinceArray ) {
        
        if ([province.address isEqualToString:arr[0]]) {
            
            index = [self.provinceArray indexOfObject:province];
            self.cityArray = province.cityArray;
        }
    }
    [self.pickView selectRow:index inComponent:0 animated:NO];
    
    if (arr.count > 1) {
        
        for (Province *province in self.cityArray ) {
            
            if ([province.address isEqualToString:arr[1]]) {
                
                inde2 = [self.cityArray indexOfObject:province];
            }
        }
        [self.pickView selectRow:inde2 inComponent:1 animated:NO];
    }
}

-(void)industrypPositioningWithIndex:(NSString *)info{
    
    NSArray *arr = [info componentsSeparatedByString:@","];
    NSInteger index = 0 ;
    NSInteger inde2 = 0 ;
    for (NSString *industryp in self.industryArray ) {
        
        if ([industryp isEqualToString:arr[0]]) {
            
            index = [self.industryArray indexOfObject:industryp];
            self.industrySubArray = [[CompanySigningStore shearCompanySigningStore]industryArray][industryp];;
        }
    }
    [self.pickView selectRow:index inComponent:0 animated:NO];
    
    if (arr.count > 1) {
        
        for (NSString *subIndustryp in self.industrySubArray ) {
            
            if ([subIndustryp isEqualToString:arr[1]]) {
                
                inde2 = [self.industrySubArray indexOfObject:subIndustryp];
            }
        }
        [self.pickView selectRow:inde2 inComponent:1 animated:NO];
    }
}

#pragma mark 数据源 Method numberOfComponentsInPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    if ([_selectDemandEdit.title isEqualToString:REGIONAL] || [_selectDemandEdit.title isEqualToString:INDUSTRY]) {
       
        return 2;
    } else {
        
        return 1;
    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *lbl = (UILabel *)view;
    
    if (lbl == nil) {
        
        lbl = [[UILabel alloc]init];
        //在这里设置字体相关属性
        lbl.adjustsFontSizeToFitWidth = YES;
        lbl.font = [UIFont systemFontOfSize:15];
        lbl.textColor = [UIColor blackColor];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setBackgroundColor:[UIColor clearColor]];
    }
    //重新加载lbl的文字内容
    lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return lbl;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component==0){ //省
        if ([_selectDemandEdit.title isEqualToString:REGIONAL]){
            
            return self.provinceArray.count;
            
        } else if ([_selectDemandEdit.title isEqualToString:INDUSTRY]){
            return self.industryArray.count;
        } else if ([_selectDemandEdit.title isEqualToString:DESGINER]){
            return self.desginList.count;
        } else {
             return self.desginProduct.count;
        }
    }else{
        //市
        if ([_selectDemandEdit.title isEqualToString:REGIONAL]) {
            
            return _cityArray.count;
            
        } else if([_selectDemandEdit.title isEqualToString:INDUSTRY]) {
            
            return _industrySubArray.count;
        }
    }
     return nil;
}

#pragma mark delegate 显示信息的方法

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component==0){
        
        if ([_selectDemandEdit.title isEqualToString:REGIONAL]) {
            
            Province *province = self.provinceArray[row];
            _province = province;
            return province.address;
            
        } else if ([_selectDemandEdit.title isEqualToString:INDUSTRY]){
            
            _industry = self.industryArray[row];
            return self.industryArray[row];
        } else if ([_selectDemandEdit.title isEqualToString:DESGINER]){
            
            DesignerList *desgin = self.desginList[row];
//            _selectDemandEdit.content = desgin.nickname;
            _desgin = desgin;
            return desgin.nickname;
        } else {
            
            H5List *h5 = self.desginProduct[row];
            _selectDemandEdit.content = h5.title;
            _selectH5 = h5;
            return h5.title;
        }
        //选择的省份
        
    }else{
        
        if ([_selectDemandEdit.title isEqualToString:REGIONAL]) {
            
            Province *city = self.cityArray[row];
            _city = city;
            return city.address;//省份对应的市区
            
        } else if ([_selectDemandEdit.title isEqualToString:INDUSTRY]) {
            
            _subIndustry = self.industrySubArray[row];
            return self.industrySubArray[row];
        }
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component==0){
        
        if ([_selectDemandEdit.title isEqualToString:REGIONAL]) {
            _province = self.provinceArray[row];
            self.cityArray =_province.cityArray;
            [self.pickView reloadComponent:1];
            
        } else if ([_selectDemandEdit.title isEqualToString:INDUSTRY]){
            
            _industry = self.industryArray[row];
            self.industrySubArray = [[CompanySigningStore shearCompanySigningStore]industryArray][_industry];
            [self.pickView reloadComponent:1];
            
        } else if([_selectDemandEdit.title isEqualToString:DESGINER]){
            
            DesignerList *desgin = self.desginList[row];
            _desgin = desgin;
        } else {
            
            H5List *h5 = self.desginProduct[row];
            _selectH5 = h5;
            _selectDemandEdit.content = h5.title;
        }
    }else{
        
        if ([_selectDemandEdit.title isEqualToString:REGIONAL]) {
            
            _city = self.cityArray[row];
        } else {
            
            _subIndustry = self.industrySubArray[row];
        }
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
        }else if([edit.title isEqualToString:CASE]) {
            
            [parameters setObject:_selectH5.id forKey:edit.sendKey];
        }else if(![edit.title isEqualToString:PICTURE]){
            
            [parameters setObject:edit.content forKey:edit.sendKey];
        }
    }
    
    [parameters setObject:[NSNumber numberWithInteger:_demandType] forKey:@"Demand_type"];
    if (_isEdit) {
        [parameters setObject:_customRequirementsDetail.demand.id forKey:@"Id"];
    }
 
    if (_demandType == DemandTypeDirectional) {
    
        [[UserManager shareUserManager] customRequirementsParameters:parameters isUpdate:_isEdit];
        [UserManager shareUserManager] .customRequirementsSuccess = ^(id obj){
            
            [self alertOperation];
        };
    } else {
        
            if ([[SubmitFileManager sheardSubmitFileManager]getSelectedPicktures].count != 0) {
                
                [[SubmitFileManager sheardSubmitFileManager]compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:self andType:nil];
                [UserManager shareUserManager].submitFileSuccess = ^ (id obj){
                    
                    NSString *fileUrl = [NSString stringWithFormat:@"%@",obj];
                    [parameters setObject:fileUrl forKey:@"Reference_img"];
                    [[UserManager shareUserManager] customRequirementsParameters:parameters isUpdate:_isEdit];
                    [UserManager shareUserManager] .customRequirementsSuccess = ^(id obj){
                        
                        [self alertOperation];
                    };
                };
                
            } else {
                
                if (_isEdit && _customRequirementsDetail.demand.reference_img ) {
                    
                      [parameters setObject:_customRequirementsDetail.demand.reference_img forKey:@"Reference_img"];
                    
                }
                [[UserManager shareUserManager] customRequirementsParameters:parameters isUpdate:_isEdit];
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
    
    _selectDemandEdit.inamge = [array lastObject];
    [self.tableView reloadData];
}

-(void)alertOperation{
    
    NSString *string = _demandType == DemandTypeDirectional ? @"定向需求已经发布" : @"竞标需求已经发布";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续发布" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (_isEdit) {
            
            [self back];
        }
        [UIManager sharedUIManager].customRequirementsBackOffBolck(nil);
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
