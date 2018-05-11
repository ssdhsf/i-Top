//
//  InfomationViewController.m
//  itop
//
//  Created by huangli on 2018/2/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "InfomationViewController.h"
#import "InfomationDataSource.h"
#import "InfomationStore.h"
#import "InfomationTableViewCell.h"
#import "AlertView.h"
#import "CompanySigningStore.h"
#import "DesignerSigningStore.h"
#import "EditChannelListViewController.h"

static NSString *const InfomationCellIdentifier = @"LeaveDetail";

@interface InfomationViewController ()<UIAlertViewDelegate,SubmitFileManagerDelegate>

@property (nonatomic, strong)InfomationDataSource *infomationDataSource;
//@property (nonatomic, strong)UIPickerView *pickView;
@property (nonatomic, strong)NSArray *provinceArray; // 省份
@property (nonatomic, strong)NSArray *cityArray;//城市
@property (nonatomic, strong)NSMutableArray *ageArray; //年龄
@property (nonatomic, strong)NSArray *sexArray; //性别
@property (nonatomic, strong)NSArray *fieldArray; //擅长领域
@property (nonatomic, strong)Province *province; //选择省份
@property (nonatomic, strong)Province *city; //选择的城市

@property (nonatomic, strong)TagList *superTag; //选择行业 父级
@property (nonatomic, strong)TagList *subTag; //选择行业 子级

@property (nonatomic, strong)TagList *field; //选择擅长

@property (nonatomic, strong)NSArray *industryArray; // 行业／1级
@property (nonatomic, strong)NSArray *industrySubArray;//行业／子级

@property (nonatomic, strong)NSString *selectSex; //选择的性别
@property (nonatomic, strong)NSString *selectAge; //选择的年龄
@property (nonatomic, strong)Infomation *editorItem; //选择弹窗的itme
@property (nonatomic, strong)UITextField *inputNameTF; //选择类型
@property (nonatomic, assign)PickViewType pickViewType; //选择类型
@property (nonatomic, assign)NSInteger selectRow; //选择类型
@property (nonatomic, strong)InfomationModel *info; //选择类型
@property (nonatomic, strong)AlertView *alertView; //选择类型
@property (nonatomic, assign)BOOL isUpdataInfo; //是否修改信息

@property (nonatomic, strong)NSArray *channelList;//渠道资源

@end

@implementation InfomationViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    [self registeredkeyBoardNSNotificationCenter];
}

-(void)initNavigationBarItems{
    
    self.title = @"个人信息";
    [self setRightBarItemString:@"确认" action:@selector(submitInfomation)];
    self.navigationItem.rightBarButtonItem.tintColor = RGB(232, 98, 159);
}

-(void)initView{

    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ViewHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.top.mas_equalTo(self.view);
    }];
    [self steupTableView];
    [SubmitFileManager sheardSubmitFileManager].delegate = self;
    [[SubmitFileManager sheardSubmitFileManager] addPictrueViewToViewController:self.view];
    [SubmitFileManager sheardSubmitFileManager].photoView.howMany = @"1";
    [[SubmitFileManager sheardSubmitFileManager]emptyThePictureArray];
}

-(void)initData{
    
    _info = [[UserManager shareUserManager]crrentInfomationModel];
    if (_info == nil) {
        
        [[UserManager shareUserManager]userInfomationWithUserType:[[UserManager shareUserManager] crrentUserType]];
        [UserManager shareUserManager].userInfoSuccess = ^(id obj){
            
            _info = [[InfomationModel alloc]initWithDictionary:obj error:nil];
            [[Global sharedSingleton]
             setUserDefaultsWithKey:INFOMATION_EDIT_MODEL([[UserManager shareUserManager]crrentUserId])
             andValue:[_info toJSONString]];
            [self loadingView];
        };
    } else {
        [self loadingView];
    }
    _sexArray = @[@"男",@"女"];
    self.ageArray = [NSMutableArray array];
    for (int i = 0; i<101; i ++) {
        
        [_ageArray addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    
    _provinceArray = [[CompanySigningStore shearCompanySigningStore]provinceArray];
    Province *province = _provinceArray[0];
    _cityArray = province.cityArray;
    _isUpdataInfo = NO;
}

-(void)loadingView{
    
    switch ([[UserManager shareUserManager] crrentUserType]) {
        
        case UserTypeDefault:
            [self setupProvinceAndTag];
            break;
            
        case UserTypeDesigner:
            if ([[CompanySigningStore shearCompanySigningStore]fieldList].count == 0) {
                
                [[UserManager shareUserManager]hometagListWithType:TagTypeField];
                [UserManager shareUserManager].homeTagListSuccess = ^(id arr){
                    
                    [[CompanySigningStore shearCompanySigningStore]confitionFieldWithRequstFieldArray:arr];
                    [self setupProvinceAndTag];
                };
            } else {
                
                [self setupProvinceAndTag];
            }
            break;
        case UserTypeEnterprise:
        case UserTypeMarketing:
            if ([[CompanySigningStore shearCompanySigningStore]superTagList].count == 0) {
                
                [[UserManager shareUserManager]hometagListWithType:TagTypeTrade];
                [UserManager shareUserManager].homeTagListSuccess = ^(id arr){
                    
                    [[CompanySigningStore shearCompanySigningStore]confitionIndustryWithRequstIndustryArray:arr];
                    
                    [self setupProvinceAndTag];
                };
            } else {
                
                [self setupProvinceAndTag];
            }
            break;
            
        default:
            break;
    }
}

-(void)setupProvinceAndTag{
    
    if ([[UserManager shareUserManager] crrentUserType] == UserTypeDesigner) {
        
         _fieldArray = [[CompanySigningStore shearCompanySigningStore]fieldList];
         _field = [[CompanySigningStore shearCompanySigningStore]fieldWithTagId:[NSNumber numberWithInteger:[_info.other_info.field integerValue]]];
        
    } else if ([[UserManager shareUserManager] crrentUserType] == UserTypeEnterprise || [[UserManager shareUserManager] crrentUserType] == UserTypeMarketing ){
       
        _industryArray = [[CompanySigningStore shearCompanySigningStore]superTagList];
        TagList *tag = _industryArray[0];
        _industrySubArray = tag.subTagArray;
        
        NSString *segmentationString;
        if ([_info.other_info.trade rangeOfString:@","].location != NSNotFound) {
            segmentationString = @",";//C端提交的格式  也是最终的格式
        } else if ([_info.other_info.trade rangeOfString:@"-"].location != NSNotFound){
            segmentationString = @"-";  //B端提交的格式
        }else if ([_info.other_info.trade rangeOfString:@""].location != NSNotFound){
            segmentationString = @"、"; //A端提交的格式
        } else{
            
        }
        
        if (![Global stringIsNullWithString:segmentationString]) {
            NSArray *tagArr = [_info.other_info.trade componentsSeparatedByString:segmentationString];//行业
            _superTag = [[CompanySigningStore shearCompanySigningStore]superTagWithTagId:[NSNumber numberWithInteger:[tagArr[0] integerValue]]];
            _subTag = [[CompanySigningStore shearCompanySigningStore] subTagWithTagId:[NSNumber numberWithInteger:[tagArr[1] integerValue]] superTagId:[NSNumber numberWithInteger:[tagArr[0] integerValue]]];

        }
        
        if ([[UserManager shareUserManager] crrentUserType] == UserTypeMarketing) {
            
            _channelList = [[CompanySigningStore shearCompanySigningStore]confitionChannelListWithRequstChannelListArray:_info.channelList];
        }
    }
    if ([[UserManager shareUserManager]crrentUserType] == UserTypeDefault ||
        [[UserManager shareUserManager]crrentUserType] == UserTypeDesigner ) {
        _province = [[CompanySigningStore shearCompanySigningStore]provinceWithProvinceCode:_info.user_info.province];
        _city = [[CompanySigningStore shearCompanySigningStore] cityWithCityCode:_info.user_info.city provinceCode:_info.user_info.province];
        
    } else {
        
        _province = [[CompanySigningStore shearCompanySigningStore]provinceWithProvinceCode:_info.other_info.province];
        _city = [[CompanySigningStore shearCompanySigningStore] cityWithCityCode:_info.other_info.city provinceCode:_info.other_info.province];
    }
    
     self.dataArray = [[InfomationStore shearInfomationStore]configurationMenuWithUserInfo:_info userType:[_info.user_type integerValue]];
    [self setupSelectItme];
    [self steupTableView];
}

-(void)setupSelectItme{
    
    for (Infomation *info in self.dataArray) {
        
        if (![Global stringIsNullWithString:info.content] && [info.title isEqualToString:@"所在城市"]) {
            info.content = [NSString stringWithFormat:@"%@,%@",_province.address, _city.address];
        }
        
        if (![Global stringIsNullWithString:info.content] && [info.title isEqualToString:@"所属行业"]) {
            info.content = [NSString stringWithFormat:@"%@,%@",_superTag.name, _subTag.name];
            
        }
        
        if (![Global stringIsNullWithString:info.content] && [info.title isEqualToString:@"性别"]) {
            _selectSex = [[InfomationStore shearInfomationStore]sexWithIndex:info.content] ;
        }
        if (![Global stringIsNullWithString:info.content] && [info.title isEqualToString:@"擅长领域"]) {
            info.content = [NSString stringWithFormat:@"%@",_field.name];
        }
        
        if (_channelList.count != 0 && [info.title isEqualToString:@"渠道资源"]) {
            
            NSString *string ;
            for (ChannelList *channel in _channelList) {
                
                if (string == nil) {
                    
                    string = channel.name;
                } else {
                    string = [NSString stringWithFormat:@"%@,%@", string,channel.name];
                }
            }
            info.content = string;
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(InfomationTableViewCell *cell , Infomation *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item row:indexPath.row ];
        
    };
    self.infomationDataSource = [[InfomationDataSource alloc]initWithItems:self.dataArray cellIdentifier:InfomationCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.infomationDataSource
                        cellIdentifier:InfomationCellIdentifier
                               nibName:@"InfomationTableViewCell"];
    
    self.tableView.dataSource = self.infomationDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"InfomationTableViewCell"] forCellReuseIdentifier:InfomationCellIdentifier];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 71;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    _selectRow = indexPath.row;
    _editorItem = [_infomationDataSource itemAtIndexPath:indexPath];
    
    if (_editorItem.isEdit) {
        
        if (_editorItem.pickViewType == PickViewTypePicture) {
            
            [[SubmitFileManager sheardSubmitFileManager].photoView openMenu];
        } else  if (_editorItem.pickViewType == PickViewTypeChannel) { //编辑渠道
            
            EditChannelListViewController *editChannelVs = [[EditChannelListViewController alloc]init];
            [editChannelVs.dataArray addObjectsFromArray: _channelList];
            editChannelVs.editChannelListBlock = ^(NSArray * array){
              
                _channelList = array;
                [self setupSelectItme];
                [self steupTableView];
            };
            [UIManager pushVC:editChannelVs];
            
        } else {
            
            [self showAlertViewWithItem:_editorItem];
        }
    }
}

-(void)compressionAndTransferPicturesWithArray:(NSArray *)array{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    InfomationTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.iconImage.image = [[Global sharedSingleton]compressImage:[array lastObject]];
//    cell.iconImage.layer.cornerRadius = cell.iconImage.height/2;
}

-(void)showAlertViewWithItem:(Infomation *)info{
    
    NSString *string ;
    if (info.pickViewType <= PickViewTypeEdit) {
        
        string  = [NSString stringWithFormat:@"请输入%@",_editorItem.title];
    }else {
        string  = [NSString stringWithFormat:@"请选择%@",_editorItem.title];
    }
    
    NSArray *superArray = [NSArray array];
    NSArray *subArray = [NSArray array];
    switch (info.pickViewType) {
        case PickViewTypeEdit:
            
            superArray = nil;
            subArray = nil;
            break;
        case PickViewTypeSex:
            
            superArray = self.sexArray;
            subArray = nil;
            break;
        case PickViewTypeAge:
            
            superArray = _ageArray;
            subArray = nil;
            break;
            
        case PickViewTypeCompnySize:
            
            superArray = [[CompanySigningStore shearCompanySigningStore]companySizeArray];
            subArray = nil;
            break;
        case PickViewTypeProvince:
            
            superArray = _provinceArray;
            subArray = _cityArray;
            break;
        case PickViewTypeIndustry:
            
            superArray = _industryArray;
            subArray = _industrySubArray;
            break;
        case PickViewTypeField:
            
            superArray = _fieldArray;
            subArray = nil;
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
        
        case PickViewTypeEdit :
        case PickViewTypeSex :
        case PickViewTypeAge :
        case PickViewTypeCompnySize :
            info.content = [NSString stringWithFormat:@"%@",(NSString *)selectSuperItme];
            break;

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
        case PickViewTypeField:
            
            _field = (TagList *)selectSuperItme;
             info.content = [NSString stringWithFormat:@"%@",_field.name];
            

        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)keyBoardWillShow:(NSNotification *)notification{
    
    //获取通知对象
    NSDictionary *userInfo = [notification userInfo];
    //获取键盘对象
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //获取键盘frame
    CGRect keyboardRect = [value CGRectValue];
    //获取键盘高度
    int height = keyboardRect.size.height;

    NSLog(@"%f",ScreenHeigh/2 - 143.5/2);
    
    CGFloat alertViewY = (height-(ScreenHeigh/2 - 143.5/2))*KadapterH+20;
    if (ScreenHeigh/2 - 143.5/2  < height) {
       
        self.alertView.frame = CGRectMake(0,-alertViewY, ScreenWidth, ScreenHeigh+alertViewY+44);
    }
    
    NSLog(@"123");
}

-(void)keyBoardWillHide:(NSNotification *)notification{
    
    self.alertView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeigh);
}

-(void)submitInfomation{

    NSMutableDictionary *otherInfoDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *userInfoDic = [NSMutableDictionary dictionary];
    
    switch ([[UserManager shareUserManager] crrentUserType]) {
        
        case UserTypeDefault:
            userInfoDic = [self userInfo];
            break;
        case UserTypeDesigner:
            userInfoDic = [self userInfo];
            otherInfoDic = [self desginerOtherInfo];
            break;
        case UserTypeEnterprise:
            otherInfoDic = [self enterpriseOtherInfo];
            [userInfoDic setObject:_info.name forKey:@"Name"];
            break;
        case UserTypeMarketing:
            userInfoDic = [self userInfo];
            otherInfoDic = [self marktingOtherInfo];
            break;
        default:
            break;
    }
    
    if ([[SubmitFileManager sheardSubmitFileManager]getSelectedPicktures].count != 0) {
        [[SubmitFileManager sheardSubmitFileManager]compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:self andType:nil];
        [UserManager shareUserManager].submitFileSuccess = ^ (NSString *obj){
            
            [userInfoDic setObject:obj forKey:@"Head_img"];
            [[UserManager shareUserManager]updataInfoWithKeyValue:userInfoDic userType:UserTypeDefault];
            [UserManager shareUserManager].updataInfoSuccess = ^(id obj){
                
                if ([[UserManager shareUserManager] crrentUserType] != UserTypeDefault) {
                    [[UserManager shareUserManager]updataInfoWithKeyValue:otherInfoDic userType:[_info.user_type integerValue]];
                    [UserManager shareUserManager].updataInfoSuccess = ^(id obj){
                        [self AlertOperation];
                    };
                } else{
                    
                     [self AlertOperation];
                }
            };
        };
    }else {
        
        [userInfoDic setObject:_info.user_info.head_img forKey:@"Head_img"];
        [[UserManager shareUserManager]updataInfoWithKeyValue:userInfoDic userType:UserTypeDefault];
        [UserManager shareUserManager].updataInfoSuccess = ^(id obj){
            
            if ([[UserManager shareUserManager] crrentUserType] != UserTypeDefault) {
                
                [[UserManager shareUserManager]updataInfoWithKeyValue:otherInfoDic userType:[_info.user_type integerValue]];
                [UserManager shareUserManager].updataInfoSuccess = ^(id obj){
                    [self AlertOperation];
                };
            }else{
                
                [self AlertOperation];
            }
        };
    }
}

-(void)AlertOperation{
    
    _isUpdataInfo = YES;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改个人信息成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续修改" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self back];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(NSMutableDictionary *)enterpriseOtherInfo{
    
    NSMutableDictionary *otherInfoDic = [NSMutableDictionary dictionary];
    
    for (Infomation *info in self.dataArray) {
        
        if ([info.title isEqualToString:@"企业名称"]) {
           
            [otherInfoDic setObject:info.content forKey:info.sendKey];
        }
        if ([info.title isEqualToString:@"企业简称"]) {
            
            [otherInfoDic setObject:info.content forKey:info.sendKey];
        }
        if ([info.title isEqualToString:@"企业规模"]) {
            
            [otherInfoDic setObject:info.content forKey:info.sendKey];
        }
        if ([info.title isEqualToString:@"所属行业"] && _superTag ) {
            
            [otherInfoDic setObject:[NSString stringWithFormat:@"%@,%@",_superTag.id,_subTag.id] forKey:info.sendKey];
        }
        
        if ([info.title isEqualToString:@"所在城市"] && _province ) {
            
            [otherInfoDic setObject:_city.code forKey:@"City"];
            [otherInfoDic setObject:_province.code forKey:@"Province"];
        }
    }
    
    return otherInfoDic;
}

-(NSMutableDictionary *)desginerOtherInfo{
    
    NSMutableDictionary *otherInfoDic = [NSMutableDictionary dictionary];
    
    for (Infomation *info in self.dataArray) {
        
        if ([info.title isEqualToString:@"擅长领域"] && _field) {
            
            [otherInfoDic setObject:_field.id forKey:info.sendKey];
        }
    }
    return otherInfoDic;
}

-(NSMutableDictionary *)marktingOtherInfo{
    
    NSMutableDictionary *otherInfoDic = [NSMutableDictionary dictionary];
    
    for (Infomation *info in self.dataArray) {
        
        if ([info.title isEqualToString:@"所在城市"] && _province) {
            
            [otherInfoDic setObject:_province.code forKey:@"Province"];
            [otherInfoDic setObject:_city.code forKey:@"City"];
        }
        
        if ([info.title isEqualToString:@"渠道资源"] && _channelList.count != 0) {
            
//            NSMutableArray *channelModelArray = [NSMutableArray array];
            NSString *channelJsonStr = [NSString string];
            for (ChannelList *channel in _channelList) {
                
                if ([Global stringIsNullWithString:channelJsonStr] ) {
                    channelJsonStr = [NSString stringWithFormat:@"{name:%@,fans_count:%@,index_url:%@}",channel.name,channel.fans_count,channel.index_url];
                } else {
                    
                    channelJsonStr =  [NSString stringWithFormat:@"%@,{name:%@,fans_count:%@,index_url:%@}",channelJsonStr,channel.name,channel.fans_count,channel.index_url];
                }
                
//                NSDictionary *dic = @{@"name":channel.name,@"fans_count":channel.fans_count,@"index_url":channel.fans_count};
//                [channelModelArray addObject:dic];
            }
            NSMutableString *targerStr = [[NSMutableString alloc] initWithString:channelJsonStr ];
            [targerStr insertString:@"[" atIndex:0];
            [targerStr insertString:@"]" atIndex:targerStr.length];
            [otherInfoDic setObject:targerStr forKey:info.sendKey];
        }
        
        if ([info.title isEqualToString:@"所属行业"] && _superTag ) {
            
            [otherInfoDic setObject:[NSString stringWithFormat:@"%@,%@",_superTag.id,_subTag.id] forKey:info.sendKey];
        }
    }
    
    return otherInfoDic;
}

-(NSMutableDictionary *)userInfo{
    
     NSMutableDictionary *userInfoDic = [NSMutableDictionary dictionary];
    for (Infomation *info in self.dataArray) {
        
        if ([info.title isEqualToString:@"姓名"]) {
            
            [userInfoDic setObject:info.content forKey:info.sendKey];
        }
        if ([info.title isEqualToString:@"昵称"]) {
            
            [userInfoDic setObject:info.content forKey:info.sendKey];
        }
        if ([info.title isEqualToString:@"年龄"]) {
            
            [userInfoDic setObject:info.content forKey:info.sendKey];
        }
        if ([info.title isEqualToString:@"性别"]) {
            
            [userInfoDic setObject:@([[InfomationStore shearInfomationStore]indexWithSex:info.content]) forKey:info.sendKey];
        }
        
        if ([[UserManager shareUserManager]crrentUserType] == UserTypeDefault || [[UserManager shareUserManager]crrentUserType] == UserTypeDesigner) {
            
            if ([info.title isEqualToString:@"所在城市"] && _province) {
                
                [userInfoDic setObject:_province.code forKey:@"Province"];
                [userInfoDic setObject:_city.code forKey:@"City"];
            }
        }
       
    }
        return userInfoDic;
}

-(void)back{
    
    [super back];
    
    if (_isUpdataInfo) {
    
        [UIManager sharedUIManager].submitInfomationBackOffBolck(nil);
    }
}

@end
