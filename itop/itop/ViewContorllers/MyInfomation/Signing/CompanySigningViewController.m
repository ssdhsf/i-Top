//
//  CompanySigningViewController.m
//  itop
//
//  Created by huangli on 2018/2/23.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CompanySigningViewController.h"
#import "AlertView.h"
#import "CompanySigningStore.h"

#define TIPSMESSEGE(__CONTENT) [NSString stringWithFormat:@"请输入%@",__CONTENT]
#define TIPSMESSEGESELECT(__CONTENT) [NSString stringWithFormat:@"请选择%@",__CONTENT]
#define TIPSMESSEGEADD(__CONTENT) [NSString stringWithFormat:@"请添加%@",__CONTENT]

@interface CompanySigningViewController ()<UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,SubmitFileManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *addProveButton;
@property (weak, nonatomic) IBOutlet UIButton *permissionButton;
@property (weak, nonatomic) IBOutlet UIView *permissionView;

@property (weak, nonatomic) IBOutlet UIButton *otherPermissionButton;
@property (weak, nonatomic) IBOutlet UIView *otherPermissionView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *companyNameTF;
@property (weak, nonatomic) IBOutlet UITextField *companyAbbreviationTF;

@property (weak, nonatomic) IBOutlet UIButton *selectCompanySizeButton;
@property (weak, nonatomic) IBOutlet UIButton *selectIndustryButton;
@property (weak, nonatomic) IBOutlet UIButton *selectProvinceButton;
@property (assign, nonatomic) SignPickViewType signPickViewType;
@property (nonatomic, strong)UIPickerView *pickView;

@property (nonatomic, strong)NSArray *provinceArray; // 省份
@property (nonatomic, strong)NSArray *cityArray;//城市

@property (nonatomic, strong)NSArray *industryArray; // 行业／1级
@property (nonatomic, strong)NSArray *industrySubArray;//行业／子级

@property (nonatomic, strong)Province *province; //选择省份
@property (nonatomic, strong)Province *city; //选择的城市

@property (nonatomic, strong)NSString *industry; //选择的行业／父级
@property (nonatomic, strong)NSString *subIndustry; //选择的行业／子级
@property (nonatomic, strong)NSString *selectCompanySize; //选择的企业的大小
@property (weak, nonatomic) IBOutlet UIButton *addImageButton;
@property (strong, nonatomic) CAShapeLayer *currentShapeLayer;

@property (weak, nonatomic) IBOutlet UIButton *verificationCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *protcolbutton;
@property (weak, nonatomic) IBOutlet UIButton *agreedbutton;
@property (weak, nonatomic) IBOutlet UIView *agreedView;
@property (weak, nonatomic) IBOutlet UIButton *subMitButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *mobiliTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;

@property (strong, nonatomic) NSArray *views;

@end

@implementation CompanySigningViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initNavigationBarItems{
    
    self.title = @"企业入驻申请";
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initData{
    
    [super initData];
    _provinceArray = [[CompanySigningStore shearCompanySigningStore]provinceArray];
    Province *province = _provinceArray[0];
    _cityArray = province.cityArray;
    
    _industryArray = [[[CompanySigningStore shearCompanySigningStore]industryArray] allKeys];
    NSString *industryKey = _industryArray[0];
    _industrySubArray = [[CompanySigningStore shearCompanySigningStore]industryArray][industryKey];
}

-(void)initView{
    
    [super initView];
    
    _views = [[NSBundle mainBundle] loadNibNamed:@"CompanySigningViewController" owner:self options:nil];
    self.view = [_views firstObject];
    _scrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(_nextButton.frame)+50);
    _permissionButton.selected = !_permissionButton.selected;
    _permissionView.backgroundColor = UIColorFromRGB(0xfda5ed);
    
    _permissionView.layer.masksToBounds = YES;
    _permissionView.layer.cornerRadius = _permissionView.frame.size.height/2;
    _otherPermissionView.layer.masksToBounds = YES;
    _otherPermissionView.layer.cornerRadius = _otherPermissionView.frame.size.height/2;
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = _nextButton.frame.size.height/2;
    [_nextButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_nextButton)];
    _currentShapeLayer = [[Global sharedSingleton] buttonSublayerWithButton:_addProveButton];
    [_addProveButton.layer addSublayer:_currentShapeLayer];
    [SubmitFileManager sheardSubmitFileManager].delegate = self;
    [[SubmitFileManager sheardSubmitFileManager] addPictrueViewToViewController:_addImageButton];
    [SubmitFileManager sheardSubmitFileManager].photoView.howMany = @"1";
    [self setupViews];
}

-(void)setupViews{
    
    [_verificationCodeButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_verificationCodeButton)];
    [_subMitButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_subMitButton)];
    _verificationCodeButton.layer.masksToBounds = YES;
    _subMitButton.layer.masksToBounds = YES;
    _agreedView.layer.masksToBounds = YES;
    _verificationCodeButton.layer.cornerRadius = _verificationCodeButton.height/2;
    _subMitButton.layer.cornerRadius = _subMitButton.height/2;
    _agreedView.layer.cornerRadius = _agreedView.height/2;
    [_agreedbutton bringSubviewToFront:_agreedbutton];;
}

- (IBAction)permission:(UIButton *)sender {
    
    if (sender.tag == 1 && !_permissionButton.selected) {
        
        _permissionButton.selected = !_permissionButton.selected;
        
        if (_permissionButton.selected) {
            
            _permissionView.backgroundColor = UIColorFromRGB(0xfda5ed);
            _otherPermissionView.backgroundColor = UIColorFromRGB(0xe0e3e6);
            
        } else {
            
            _permissionView.backgroundColor = UIColorFromRGB(0xe0e3e6);
            _otherPermissionView.backgroundColor = UIColorFromRGB(0xfda5ed);
        }
        _otherPermissionButton.selected = !_permissionButton.selected;

    } else if(sender.tag == 2 && !_otherPermissionButton.selected){
        
        _otherPermissionButton.selected = !_otherPermissionButton.selected;
        if (_otherPermissionButton.selected) {
            
            _permissionView.backgroundColor = UIColorFromRGB(0xe0e3e6);
            _otherPermissionView.backgroundColor = UIColorFromRGB(0xfda5ed);
            
        } else {
            _permissionView.backgroundColor = UIColorFromRGB(0xfda5ed);
            _otherPermissionView.backgroundColor = UIColorFromRGB(0xe0e3e6);
        }
        _permissionButton.selected = !_otherPermissionButton.selected;
    }
}

- (IBAction)selectItem:(UIButton *)sender {
    
    
    [self showAlertViewWithItem:sender];
    
}

- (IBAction)addImage:(UIButton *)sender {
    
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"ruzhu_icon_add"]]) {
        [[SubmitFileManager sheardSubmitFileManager]popupsSelectPhotoTipsView];
    } else {
        
        [[SubmitFileManager sheardSubmitFileManager]browsePicturesWithPictureArray:nil];
    }
}

-(void)showAlertViewWithItem:(UIButton*)button{
    
    _signPickViewType = button.tag;
    UIView *view = [[UIView alloc] init];
    NSString *string ;

    [self initPickViewWith:button.tag];
    view.frame = self.pickView.frame;
    [view addSubview:self.pickView];
    string  = _signPickViewType == SignPickViewTypeIndustry ? @"请选择行业" :  _signPickViewType == SignPickViewTypeCompnySize ? @"请选择企业规模" : @"请选择地区";
    AlertView *alertView = [[AlertView alloc]initWithTitle:string
                                                   message:view
                                                   sureBtn:@"确定"
                                                 cancleBtn:@"取消"
                                              pickViewType:button.tag];
    alertView.resultIndex = ^(NSInteger index ,PickViewType picViewType){
    
        
        if (picViewType == SignPickViewTypeIndustry) {
            
            [_selectIndustryButton setTitle:[NSString stringWithFormat:@"%@,%@",_industry,_subIndustry] forState:UIControlStateNormal];
        } else if(picViewType == SignPickViewTypeCompnySize){
            
            [_selectCompanySizeButton setTitle:_selectCompanySize forState:UIControlStateNormal];
        }else {
            
            [_selectProvinceButton setTitle:[NSString stringWithFormat:@"%@,%@",_province.address,_city.address] forState:UIControlStateNormal];
        }
    };
    
    [alertView showXLAlertView];
}

-(void)initPickViewWith:(SignPickViewType)pickViewType{
    
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, 120)];
    self.pickView.backgroundColor = [UIColor whiteColor];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    self.pickView.showsSelectionIndicator = YES;
    [self.pickView reloadAllComponents];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (pickViewType == SignPickViewTypeIndustry) {
        
        button = _selectIndustryButton;
    } else if (pickViewType == SignPickViewTypeCompnySize){
        
        button = _selectCompanySizeButton;
    } else {
       
        button = _selectProvinceButton;
    }
    NSInteger index ;
    if (button.titleLabel.text != nil  && ![button.titleLabel.text isEqualToString:@"请选择行业"] && ![button.titleLabel.text isEqualToString:@"请选择企业规模"] && ![button.titleLabel.text isEqualToString:@"请选择地区"]) {
        
        switch (pickViewType) {
            case SignPickViewTypeIndustry:
                
                [self industrypPositioningWithIndex:button.titleLabel.text];
                break;
            case SignPickViewTypeCompnySize:
                
                index = [[[CompanySigningStore shearCompanySigningStore] companySizeArray ] indexOfObject:button.titleLabel.text];
                [self.pickView selectRow:index inComponent:0 animated:NO];
                break;
            case SignPickViewTypeProvince:
                
                [self positioningwithindex:button.titleLabel.text];
                break;
                
            default:
                break;
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
    
    return _signPickViewType == SignPickViewTypeCompnySize ? 1 : 2;
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
        if (_signPickViewType == SignPickViewTypeProvince) {
            
            return self.provinceArray.count;
            
        } else if (_signPickViewType == SignPickViewTypeCompnySize){
            return [[CompanySigningStore shearCompanySigningStore] companySizeArray ].count;
        } else{
            return self.industryArray.count;
        }
    }else{
        //市
        if (_signPickViewType == SignPickViewTypeProvince) {
            
            return _cityArray.count;
            
        } else {
            
            return self.industrySubArray.count;
        }
    }
}

#pragma mark delegate 显示信息的方法

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component==0){
        
        if (_signPickViewType == SignPickViewTypeProvince) {
            
            Province *province = self.provinceArray[row];
            _province = province;
            return province.address;
            
        } else if (_signPickViewType == SignPickViewTypeCompnySize){
            
            _selectCompanySize = [[CompanySigningStore shearCompanySigningStore]companySizeArray][row];
            return [[CompanySigningStore shearCompanySigningStore]companySizeArray][row];
            
            
        } else{
            _industry = self.industryArray[row];
            return self.industryArray[row];
        }
        //选择的省份
        
    }else{
        
         if (_signPickViewType == SignPickViewTypeProvince) {
            
             Province *city = self.cityArray[row];
             _city = city;
             return city.address;//省份对应的市区

         } else {
             
             _subIndustry = self.industrySubArray[row];
             return self.industrySubArray[row];

         }
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component==0){
        
        if (_signPickViewType == SignPickViewTypeProvince) {
            _province = self.provinceArray[row];
            self.cityArray =_province.cityArray;
            [self.pickView reloadComponent:1];
            
        } else if (_signPickViewType == SignPickViewTypeCompnySize){
            
            _selectCompanySize = [[CompanySigningStore shearCompanySigningStore]companySizeArray][row];
            
        } else{
            
            _industry = self.industryArray[row];
            self.industrySubArray = [[CompanySigningStore shearCompanySigningStore]industryArray][_industry];
            [self.pickView reloadComponent:1];

        }
        
    }else{
        
        if (_signPickViewType == SignPickViewTypeProvince) {
          
            _city = self.cityArray[row];
        } else {
            
            _subIndustry = self.industrySubArray[row];
        }
    }
}

#pragma Mark-提交获取图片url的协议方法
-(void)compressionAndTransferPicturesWithArray:(NSArray *)array{
    
    if (array.count == 0) {
        
        [_addImageButton setImage:[UIImage imageNamed:@"ruzhu_icon_add"] forState:UIControlStateNormal];
        [_addProveButton.layer addSublayer:_currentShapeLayer];

    }else {
       
        [_currentShapeLayer removeFromSuperlayer];
        [_addImageButton setImage:[array lastObject] forState:UIControlStateNormal];
    }
}

- (IBAction)submitSigin:(UIButton *)sender {
    
    if ([Global stringIsNullWithString:_companyNameTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"企业名称")];
        return;
    }
    if ([Global stringIsNullWithString:_companyAbbreviationTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"企业简称")];
        return;
    }
    
    if ([_selectIndustryButton.titleLabel.text isEqualToString:TIPSMESSEGESELECT(@"行业")]) {
        
        [self showToastWithMessage:TIPSMESSEGESELECT(@"行业")];
        return;
    }
    
    if ([_selectCompanySizeButton.titleLabel.text isEqualToString:TIPSMESSEGESELECT(@"企业规模")]) {
        
        [self showToastWithMessage:TIPSMESSEGESELECT(@"企业规模")];
        return;
    }
    
    if ([_selectProvinceButton.titleLabel.text isEqualToString:TIPSMESSEGESELECT(@"地区")]) {
        
        [self showToastWithMessage:TIPSMESSEGESELECT(@"地区")];
        return;
    }
    
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"ruzhu_icon_add"]]) {
        
        [self showToastWithMessage:TIPSMESSEGEADD(@"文件")];
        return;
    }
    self.view = [_views lastObject];
}

- (IBAction)agreedProtcol:(UIButton *)sender {
    
    _agreedbutton.selected = !_agreedbutton.selected;
    if (_agreedbutton.selected) {
        
        _agreedView.backgroundColor = UIColorFromRGB(0xfda5ed);
    } else {
        _agreedView.backgroundColor = UIColorFromRGB(0xe0e3e6);
    }
}

- (IBAction)browseProtcol:(UIButton *)sender {
    
   [UIManager protocolWithProtocolType:ProtocolTypeCompany];
}

- (IBAction)verificationCode:(UIButton *)sender {
    
    [_mobiliTF resignFirstResponder];
    [_verificationCodeTF resignFirstResponder];
    [_nameTF resignFirstResponder];

    if([Global stringIsNullWithString:_mobiliTF.text] || ![LCRegExpTool lc_checkingMobile:_mobiliTF.text]) {
        
        [self showToastWithMessage:@"请输入正确的手机号码"];
        return;
    }
    
    if([_verificationCodeButton.titleLabel.text isEqualToString:@"获取验证码"]){
        [[UserManager shareUserManager]getVerificationCodeWithPhone:_mobiliTF.text];
        [UserManager shareUserManager].verificationSuccess = ^(id obj){
            
            [[Global sharedSingleton]showToastInTop:self.view withMessage:@"验证码已发送至您手机"];
            NSLog(@"%@",obj);
            [_verificationCodeButton scheduledGCDTimer];
        };
        
    }else {
        
        [self showToastWithMessage:[NSString stringWithFormat:@"%ld后重发",[UserManager shareUserManager].timers]];
        return;
    }

//    [[UserManager shareUserManager]getVerificationCodeWithPhone:_mobiliTF.text];
//    [UserManager shareUserManager].verificationSuccess = ^(id obj){
//        
//        [[Global sharedSingleton]showToastInTop:self.view withMessage:@"验证码已发送至您手机"];
//        NSLog(@"%@",obj);
//    };
}

- (IBAction)subMit:(UIButton *)sender {
    
    if ([Global stringIsNullWithString:_nameTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"姓名")];
        return;
    }
    
    if ([Global stringIsNullWithString:_mobiliTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"手机号")];
        return;
    }
    if ([Global stringIsNullWithString:_verificationCodeTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"验证码")];
        return;
    }
    
    if (!_agreedbutton.selected) {
        
        [self showToastWithMessage:@"您还没有同意入驻协议"];
        return;
    }
    
    [[SubmitFileManager sheardSubmitFileManager]compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:self andType:nil];
    [UserManager shareUserManager].submitFileSuccess = ^ (id obj){
        
        NSString *fileUrl = [NSString stringWithFormat:@"%@",obj];
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        NSString * certificatesType = _permissionButton.selected ? @"2" : @"10";
        [parameters setObject:fileUrl forKey:@"Certificates_url"];
        [parameters setObject:_companyNameTF.text forKey:@"Enterprise_name"];
        [parameters setObject:_companyAbbreviationTF.text forKey:@"Short_name"];
        [parameters setObject:_selectCompanySize forKey:@"Scale"];
        [parameters setObject:_selectIndustryButton.titleLabel.text forKey:@"Trade"];
        [parameters setObject:_province.address forKey:@"Province"];
        [parameters setObject:_city.address forKey:@"City"];
        [parameters setObject:certificatesType forKey:@"Certificates_type"];
        [parameters setObject:_city.address forKey:@"City"];
        [parameters setObject:fileUrl forKey:@"Certificates_url"];
        [parameters setObject:_nameTF.text forKey:@"Name"];
        [parameters setObject:_mobiliTF.text forKey:@"Phone"];
        [parameters setObject:_verificationCodeTF.text forKey:@"Phone_code"];
        
        [[UserManager shareUserManager]submitSigningWithParameters:parameters signingType:SigningTypeCompany];
        [UserManager shareUserManager].signingSuccess =  ^(id obj){
            
       [UIManager signingStateWithShowViewType:ShowSigningStateViewTypeNext signingState:nil signingType:SigningTypeMarNoel];
        };
        
    };
}

-(void)back{
    
    if (self.view == [_views lastObject]) {
        
        self.view  = [_views firstObject];
    }else {
        
        [super back];
    }
}

@end
