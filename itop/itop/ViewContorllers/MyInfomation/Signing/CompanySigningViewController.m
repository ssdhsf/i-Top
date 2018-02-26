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

@interface CompanySigningViewController ()<UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

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
@property (nonatomic, strong)NSString *selectCompanySize; //选择的行业／子级

@end

@implementation CompanySigningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)initNavigationBarItems{
    
    self.title = @"入驻申请";
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
    _scrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(_nextButton.frame)+50);
    _permissionButton.selected = !_permissionButton.selected;
    _permissionView.backgroundColor = UIColorFromRGB(0xfda5ed);
    
    _permissionView.layer.masksToBounds = YES;
    _permissionView.layer.cornerRadius = _permissionView.frame.size.height/2;
    _otherPermissionView.layer.masksToBounds = YES;
    _otherPermissionView.layer.cornerRadius = _otherPermissionView.frame.size.height/2;
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = _nextButton.frame.size.height/2;
    [_nextButton.layer addSublayer:[UIColor setGradualChangingColor: _nextButton fromColor:@"FFA5EC" toColor:@"DEA2FF"]];
    [_addProveButton.layer addSublayer:[self buttonSublayer]];
}

-(CAShapeLayer *)buttonSublayer{
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, _addProveButton.size.width, _addProveButton.size.height);//虚线框的大小
    borderLayer.position = CGPointMake(CGRectGetMidX(_addProveButton.bounds),CGRectGetMidY(_addProveButton.bounds));//虚线框锚点
    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;//矩形路径
    borderLayer.lineWidth = 0.5/[[UIScreen mainScreen] scale];//虚线宽度
    //虚线边框
    borderLayer.lineDashPattern = @[@6, @3];
    //实线边框
    //    borderLayer.lineDashPattern = nil;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor grayColor].CGColor;
    return borderLayer;
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
            self.cityArray = [[CompanySigningStore shearCompanySigningStore]industryArray][industryp];;
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

@end
