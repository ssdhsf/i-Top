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

static NSString *const InfomationCellIdentifier = @"LeaveDetail";

@interface InfomationViewController ()<UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,SubmitFileManagerDelegate>

@property (nonatomic, strong)InfomationDataSource *infomationDataSource;
@property (nonatomic, strong)UIPickerView *pickView;
@property (nonatomic, strong)NSArray *provinceArray; // 省份
@property (nonatomic, strong)NSArray *cityArray;//城市
@property (nonatomic, strong)NSMutableArray *ageArray; //年龄
@property (nonatomic, strong)NSArray *sexArray; //性别
@property (nonatomic, strong)Province *province; //选择省份
@property (nonatomic, strong)Province *city; //选择的城市

@property (nonatomic, strong)NSArray *industryArray; // 行业／1级
@property (nonatomic, strong)NSArray *industrySubArray;//行业／子级
@property (nonatomic, strong)NSString *industryString; // 选中的行业／1级
@property (nonatomic, strong)NSString *industrySubString;//选中的行业／子级

@property (nonatomic, strong)NSString *selectSex; //选择的性别
@property (nonatomic, strong)NSString *selectAge; //选择的年龄
@property (nonatomic, strong)Infomation *editorItem; //选择弹窗的itme
@property (nonatomic, strong)UITextField *inputNameTF; //选择类型
@property (nonatomic, assign)PickViewType pickViewType; //选择类型
@property (nonatomic, assign)NSInteger selectRow; //选择类型
@property (nonatomic, strong)InfomationModel *info; //选择类型

@end

@implementation InfomationViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
}

-(void)initNavigationBarItems{
    
    self.title = @"个人信息";
    [self setRightBarItemString:@"确认" action:@selector(submitInfomation)];
    self.navigationItem.rightBarButtonItem.tintColor = RGB(232, 98, 159);
}

-(void)initView{
    
    NSLog(@"%f",self.view.frame.size.height);
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
}

-(void)initData{
    
    UserModel *user = [[UserManager shareUserManager]crrentUserInfomation];
    [[UserManager shareUserManager]userInfomationWithUserType:[user.user_type integerValue]];
    [UserManager shareUserManager].userInfoSuccess = ^(id obj){
       
        _info = [[InfomationModel alloc]initWithDictionary:obj error:nil];
        self.dataArray = [[InfomationStore shearInfomationStore]configurationMenuWithUserInfo:_info userType:[_info.user_type integerValue]];
        [self setupSelectItme];
        [self steupTableView];
    };
    _sexArray = @[@"男",@"女"];
    self.ageArray = [NSMutableArray array];
    for (int i = 0; i<101; i ++) {
        
        [_ageArray addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    
    _provinceArray = [[CompanySigningStore shearCompanySigningStore]provinceArray];
    Province *province = _provinceArray[0];
    _cityArray = province.cityArray;

    _industryArray = [[[CompanySigningStore shearCompanySigningStore]industryArray] allKeys];
    NSString *industryKey = _industryArray[0];
    _industrySubArray = [[CompanySigningStore shearCompanySigningStore]industryArray][industryKey];

}

-(void)setupSelectItme{
    
    for (Infomation *info in self.dataArray) {
        
        if (![Global stringIsNullWithString:info.content] && [info.title isEqualToString:@"所在城市"]) {
            NSArray *arr = [info.content componentsSeparatedByString:@","];
            for (Province *province in _provinceArray) {
                
                if ([province.address isEqualToString:arr[0]]) {
                    _province = province;
                    self.cityArray = province.cityArray;
                }
            }
            
            if (arr.count > 1) {
               
                for (Province *city in _cityArray) {
                    
                    if ([city.address isEqualToString:arr[1]]) {
                        _city = city;
                    }
                }
            }
        }
        
        if (![Global stringIsNullWithString:info.content] && [info.title isEqualToString:@"性别"]) {
            _selectSex = [[InfomationStore shearInfomationStore]sexWithIndex:info.content] ;
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark 重新加载数据时将有数据的itme赋给已选择的temp
-(void)initPickViewWith:(Infomation*)info{
    
    if (info.pickViewType == PickViewTypeSex) {
      
         self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, 60)];
        
    } else {
         self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, 120)];
    }
   
    self.pickView.backgroundColor = [UIColor whiteColor];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    self.pickView.showsSelectionIndicator = YES;
    [self.pickView reloadAllComponents];
//    Infomation *info = self.dataArray[pickView];
    NSInteger index ;
    if (![Global stringIsNullWithString:info.content]) {
        
        switch (info.pickViewType) {
            case PickViewTypeAge:
                
                index = [self.ageArray indexOfObject:info.content];
                [self.pickView selectRow:index inComponent:0 animated:NO];
                break;
            case PickViewTypeSex:
                
                index = [[InfomationStore shearInfomationStore] indexWithSex:info.content];
                if (index > 0) {
                    
                    index = index-1;
                }
                [self.pickView selectRow:index inComponent:0 animated:NO];
                break;
            case PickViewTypeCompnySize:
                
                index = [[[CompanySigningStore shearCompanySigningStore]companySizeArray] indexOfObject:info.content];
                [self.pickView selectRow:index inComponent:0 animated:NO];
                break;
            case PickViewTypeField:
                
                index = [[[DesignerSigningStore shearDesignerSigningStore]fieldArray] indexOfObject:info.content];
                [self.pickView selectRow:index inComponent:0 animated:NO];
                break;
                
            case PickViewTypeProvince:
                
                [self positioningProvinceWithindex:info];
                break;
            case PickViewTypeIndustry:
                
                [self positioningIndustryWithindex:info];
                break;
                
            default:
                break;
        }
    }
}

#pragma mark 选择数据时将有数据的城市赋给已选择的temp
-(void)positioningProvinceWithindex:(Infomation *)info{
    
    NSArray *arr = [info.content componentsSeparatedByString:@","];
    NSInteger index = 0 ;
    NSInteger inde2 = 0 ;
    for (Province *province in self.provinceArray ) {
        
        if ([province.address isEqualToString:arr[0]]) {
            
            index = [self.provinceArray indexOfObject:province];
            self.cityArray =province.cityArray;
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

#pragma mark 选择数据时将有数据的行业赋给已选择的temp
-(void)positioningIndustryWithindex:(Infomation *)info{
    
    NSArray *arr = [info.content componentsSeparatedByString:@","];
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
        
        for (NSString *subIndustryp in self.cityArray ) {
            
            if ([subIndustryp isEqualToString:arr[1]]) {
                
                inde2 = [self.industrySubArray indexOfObject:subIndustryp];
            }
        }
        [self.pickView selectRow:inde2 inComponent:1 animated:NO];
    }
}

-(void)initInputNameTFWithPlaceholder:(NSString *)placeholder{
    
    self.inputNameTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth-160, 30)];
    self.inputNameTF.placeholder = placeholder;
    _inputNameTF.textAlignment = UITextAlignmentCenter;
    _inputNameTF.font = [UIFont systemFontOfSize:15];
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
        } else {
            
             [self showAlertViewWithItem:_editorItem];
        }
    }
}

-(void)compressionAndTransferPicturesWithArray:(NSArray *)array{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    InfomationTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.iconImage.image = [array lastObject];
}

-(void)showAlertViewWithItem:(Infomation *)info{
    
//    _pickViewType = row;
    UIView *view = [[UIView alloc] init];
    NSString *string ;
    if (info.pickViewType <= PickViewTypeEdit) {
        
        string  = [NSString stringWithFormat:@"请输入%@",_editorItem.title];
        [self initInputNameTFWithPlaceholder:string];
        view.frame = self.inputNameTF.frame;
        [view addSubview:self.inputNameTF];
    }else {
        [self initPickViewWith:info];
        view.frame = self.pickView.frame;
        [view addSubview:self.pickView];
        string  = [NSString stringWithFormat:@"请选择%@",_editorItem.title];
    }
    
    AlertView *alertView = [[AlertView alloc]initWithTitle:string
                                                   message:view
                                                   sureBtn:@"确定"
                                                 cancleBtn:@"取消"
                                              pickViewType:info.pickViewType];
    alertView.resultIndex = ^(NSInteger index ,PickViewType picViewType){
        
        if (index == 2 && picViewType == PickViewTypeIndustry | picViewType == PickViewTypeProvince | picViewType == PickViewTypeEdit) {
            
             [self updataInfomationWithUpdataItem:picViewType];
        } else {
            
            [self.tableView reloadData];
        }
    };
    [alertView showXLAlertView];
}

#pragma mark 数据源 Method numberOfComponentsInPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    Infomation *info = self.dataArray[_selectRow];
    return info.pickViewType == PickViewTypeProvince || info.pickViewType == PickViewTypeIndustry ? 2 : 1;
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
    
    Infomation *info = self.dataArray[_selectRow];
    if (component==0){
        switch (info.pickViewType) {
            case PickViewTypeAge:
                
                return self.ageArray.count;
                break;
            case PickViewTypeSex:
                
                return self.sexArray.count;
                break;
            case PickViewTypeCompnySize:
                
                return [[CompanySigningStore shearCompanySigningStore]companySizeArray].count ;
                break;
            case PickViewTypeField:
                
                return [[DesignerSigningStore shearDesignerSigningStore]fieldArray].count;
                break;
                
            case PickViewTypeProvince:
                
                return self.provinceArray.count;
                break;
            case PickViewTypeIndustry:
                
                return self.provinceArray.count;
                break;
        }
    }else{
        
        if (info.pickViewType == PickViewTypeProvince) {
            
            return _cityArray.count;//省份对应的市区
        } else {
            
            return self.industrySubArray.count;
        }
    }
    
    return 0;
}

#pragma mark delegate 显示信息的方法
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    Infomation *info = self.dataArray[_selectRow];
    if (component==0){
        switch (info.pickViewType) {
            case PickViewTypeAge:
                
                return self.ageArray[row];
                break;
            case PickViewTypeSex:
                
                return self.sexArray[row];
                break;
            case PickViewTypeCompnySize:
                
                return [[CompanySigningStore shearCompanySigningStore]companySizeArray][row] ;
                break;
            case PickViewTypeField:
                
                return [[DesignerSigningStore shearDesignerSigningStore]fieldArray][row];
                break;
                
            case PickViewTypeProvince:
                _province = self.provinceArray[row];
                return _province.address;
                break;
            case PickViewTypeIndustry:
                
                _industryString = self.industryArray[row];
                return self.industryArray[row];
                break;
        }
        
    }else{
        
        if (info.pickViewType == PickViewTypeProvince) {
            
            _city = self.cityArray[row];
            return _city.address;//省份对应的市区
        } else {
            
            _industrySubString = self.industrySubArray[row];
            return _industrySubString;
        }
    }
    
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
   
    Infomation *info = self.dataArray[_selectRow];
    if (component==0){
        switch (info.pickViewType) {
            case PickViewTypeAge:
                
                info.content = self.ageArray[row];
                break;
            case PickViewTypeSex:
                
                info.content = self.sexArray[row];
                break;
            case PickViewTypeCompnySize:
                
                info.content = [[CompanySigningStore shearCompanySigningStore]companySizeArray][row] ;
                break;
            case PickViewTypeField:
                
                info.content = [[DesignerSigningStore shearDesignerSigningStore]fieldArray][row];
                break;
                
            case PickViewTypeProvince:
                _province = self.provinceArray[row];
                self.cityArray =_province.cityArray;
                [self.pickView reloadComponent:1];
                break;
            case PickViewTypeIndustry:
                
                _industryString = self.industryArray[row];
                _industrySubArray = [[CompanySigningStore shearCompanySigningStore]industryArray][self.industryArray[row]];
                [self.pickView reloadComponent:1];
                break;
        }
    }else{
    
        if (info.pickViewType == PickViewTypeProvince) {
           
             _city = self.cityArray[row];
        } else {
            
            _industrySubString = self.industrySubArray[row];
            
        }
    }
}

-(void)updataInfomationWithUpdataItem:(PickViewType )pickViewType{
    
    Infomation *info = self.dataArray[_selectRow];
    
    switch (pickViewType) {
        case PickViewTypeProvince:
            info.content = [NSString stringWithFormat:@"%@,%@",_province.address,_city.address];
            break;
        case PickViewTypeEdit :
            info.content = [NSString stringWithFormat:@"%@",_inputNameTF.text];
            break;
        case PickViewTypeIndustry:
            info.content = [NSString stringWithFormat:@"%@,%@",_industryString,_industrySubString];
            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
}

//-(NSArray *)showItemAletViewWithItemViewType:(PickViewType )pickViewType{
//    
//    Infomation *info = self.dataArray[_selectRow];
//    
//    switch (pickViewType) {
//        case PickViewTypeProvince:
//            info.content = [NSString stringWithFormat:@"%@,%@",_province.address,_city.address];
//            break;
//        case PickViewTypeSex:
//            info.content = [NSString stringWithFormat:@"%@",_selectSex];
//            break;
//        case PickViewTypeEdit :
//            
//            info.content = [NSString stringWithFormat:@"%@",_inputNameTF.text];
//            break;
//        case PickViewTypeAge:
//            info.content = [NSString stringWithFormat:@"%@",_selectAge];
//            break;
//        default:
//            break;
//    }
//    
//    [self.tableView reloadData];
//}

-(void)submitInfomation{

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (Infomation *info in self.dataArray) {
        
        if ([Global stringIsNullWithString:info.content] && [info.title isEqualToString:@"年龄"]) {
            
            [[Global sharedSingleton]showToastInTop:self.view withMessage:@"年龄不能为空"];
            return;
        }

        switch (info.pickViewType) {
            case PickViewTypeAge :
            case PickViewTypeCompnySize :
            case PickViewTypeField :
            case PickViewTypeEdit:
            case PickViewTypeIndustry:
                if (![Global stringIsNullWithString:info.content]) {
                   
                    [dic setObject:info.content forKey:info.sendKey];
                }
              
                break;
            case PickViewTypeSex:
                
                [dic setObject:@([[InfomationStore shearInfomationStore]indexWithSex:info.content]) forKey:info.sendKey];
                break;
                
         case PickViewTypeProvince:
                [dic setObject:_province.address forKey:@"Province"];
                [dic setObject:_city.address forKey:@"City"];
                break;   
        }
    }
    
    [[SubmitFileManager sheardSubmitFileManager]compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:self andType:nil];
    [UserManager shareUserManager].submitFileSuccess = ^ (NSString *obj){
        
        [dic setObject:obj forKey:@"Head_img"];
        [[UserManager shareUserManager]updataInfoWithKeyValue:dic userType:[_info.user_type integerValue]];
        [UserManager shareUserManager].updataInfoSuccess = ^(id obj){
            
            [self AlertOperation];
        };
    };
}

-(void)AlertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改个人信息成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续修改" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self back];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
