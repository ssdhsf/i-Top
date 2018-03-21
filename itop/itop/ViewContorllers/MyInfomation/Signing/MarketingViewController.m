//
//  MarketingViewController.m
//  itop
//
//  Created by huangli on 2018/2/28.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MarketingViewController.h"
#import "CompanySigningStore.h"
#import "AlertView.h"
#import "MarketingTableViewCell.h"
#import "MarketingDataSource.h"
#import "MarketingStore.h"

#define TIPSMESSEGE(__CONTENT) [NSString stringWithFormat:@"请输入%@",__CONTENT]
#define TIPSMESSEGESELECT(__CONTENT) [NSString stringWithFormat:@"请选择%@",__CONTENT]

static NSString *const MarketingCellIdentifier = @"Marketing";

@interface MarketingViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *addChannelButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (assign, nonatomic) NSInteger addChannelNumber;

//个人信息页
@property (weak, nonatomic) IBOutlet UIButton *agreedbutton;
@property (weak, nonatomic) IBOutlet UIView *agreedView;
@property (weak, nonatomic) IBOutlet UIButton *verificationCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *protcolbutton;
@property (weak, nonatomic) IBOutlet UIButton *subMitButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *mobiliTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *selectIndustryButton;
@property (weak, nonatomic) IBOutlet UIButton *selectProvinceButton;

@property (strong, nonatomic) NSArray *views;
@property (assign, nonatomic) SignPickViewType signPickViewType;
@property (nonatomic, strong) UIPickerView *pickView;
@property (nonatomic, strong) NSArray *provinceArray; // 省份
@property (nonatomic, strong) NSArray *cityArray;//城市
@property (nonatomic, strong) NSArray *industryArray; // 行业／1级
@property (nonatomic, strong) NSArray *industrySubArray;//行业／子级
@property (nonatomic, strong) Province *province; //选择省份
@property (nonatomic, strong) Province *city; //选择的城市
@property (nonatomic, strong) NSString *industry; //选择的行业／父级
@property (nonatomic, strong) NSString *subIndustry; //选择的行业／子级
@property (nonatomic, strong) NSMutableArray *channelArray; //选择的行业／子级
@property (nonatomic, strong) MarketingDataSource *marketingDataSource; //选择的行业／子级
@property (strong, nonatomic) IBOutlet UIView *fooderView;

@end

@implementation MarketingViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
}

-(void)initNavigationBarItems{
    
    self.title = @"自营销人入驻申请";
}

-(void)initData{
    
    [super initData];
    _provinceArray = [[CompanySigningStore shearCompanySigningStore]provinceArray];
    Province *province = _provinceArray[0];
    _cityArray = province.cityArray;
    
    _industryArray = [[[CompanySigningStore shearCompanySigningStore]industryArray] allKeys];
    NSString *industryKey = _industryArray[0];
    _industrySubArray = [[CompanySigningStore shearCompanySigningStore]industryArray][industryKey];
    
    _addChannelNumber = 1;
    [self.dataArray addObject: [[MarketingStore shearMarketingStore ]configurationMenuWithShowIndex:_addChannelNumber]];
}

-(NSMutableArray *)channelArray{
    
    if (!_channelArray) {
        
        self.channelArray = [NSMutableArray array];
    }
    return _channelArray;
}

-(void)initView{
    
    [super initView];
    _views = [[NSBundle mainBundle] loadNibNamed:@"MarketingViewController" owner:self options:nil];
    self.view = [_views firstObject];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ViewHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.top.mas_equalTo(self.view);
    }];
    [self steupTableView];
    
    [self setupSubView];
    self.tableView.tableFooterView = _fooderView;
}

-(void)setupSubView{
    
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = _nextButton.frame.size.height/2;
    [_nextButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_nextButton)];
    
    _addChannelButton.layer.masksToBounds = YES;
    _addChannelButton.layer.cornerRadius = 5;
    [_addChannelButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_addChannelButton)];
    
    _verificationCodeButton.layer.masksToBounds = YES;
    _verificationCodeButton.layer.cornerRadius = _verificationCodeButton.frame.size.height/2;
    [_verificationCodeButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_verificationCodeButton)];
    
    _agreedView.layer.masksToBounds = YES;
    _agreedView.layer.cornerRadius = _agreedView.height/2;
    [_agreedbutton bringSubviewToFront:_agreedbutton];;
    
    _subMitButton.layer.masksToBounds = YES;
    _subMitButton.layer.cornerRadius = _subMitButton.frame.size.height/2;
    [_subMitButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_subMitButton)];
}


- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(MarketingTableViewCell *cell , Marketing *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item];
        cell.inputConfigureBlock = ^(NSString *inputText, MarketingTableViewCell *cell1){
            
            NSIndexPath *index = [self.tableView indexPathForCell:cell1];
            Marketing *markt = [_marketingDataSource itemAtIndexPath:index];
            markt.content = inputText;
        };
        
    };
    self.marketingDataSource = [[MarketingDataSource alloc]initWithItems:self.dataArray cellIdentifier:MarketingCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.marketingDataSource
                        cellIdentifier:MarketingCellIdentifier
                               nibName:@"MarketingTableViewCell"];
    
    self.tableView.dataSource = self.marketingDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"MarketingTableViewCell"] forCellReuseIdentifier:MarketingCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 74;
}

- (IBAction)addChannel:(UIButton *)sender {
    
    for (NSArray *array in self.dataArray) {
        
        for (Marketing *marking in array) {
            
            if ([Global stringIsNullWithString:marking.content]) {
                
                [self showToastWithMessage:@"请完善当前的渠道信息再添加渠道"];
                return;

            }
        }
    }

    _addChannelNumber ++; //判断晚上后才添加渠道信息

    if (_addChannelNumber > 3) {
        
        [self showToastWithMessage:@"最多添加3个"];
    } else {
        
        [self showProductLinkView];
    }
}

- (IBAction)next:(UIButton *)sender {
    
    if (_addChannelNumber == 1) {
        for (NSArray *array in self.dataArray) {
            
            for (Marketing *marking in array) {
                
                if ([Global stringIsNullWithString:marking.content]) {
                    
                    [self showToastWithMessage:@"请至少完善一个渠道信息"];
                    return;
                }
            }
        }
    }
    self.view  = [_views lastObject];
}

-(void)showProductLinkView{
    
    [self.dataArray addObject: [[MarketingStore shearMarketingStore ]configurationMenuWithShowIndex:_addChannelNumber]];
    [self steupTableView];
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
        } else {
            
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
    } else {
        
        button = _selectProvinceButton;
    }
    if (button.titleLabel.text != nil  && ![button.titleLabel.text isEqualToString:@"请选择行业"] && ![button.titleLabel.text isEqualToString:@"请选择地区"]) {
        
        switch (pickViewType) {
            case SignPickViewTypeIndustry:
                
                [self industrypPositioningWithIndex:button.titleLabel.text];
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
    
    return 2;
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
            
        }else{
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
            
        }else{
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
            
        } else {
            
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

- (IBAction)verificationCode:(UIButton *)sender {
    
    if ([Global stringIsNullWithString:_mobiliTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"手机号")];
        return;
    }
    
    [[UserManager shareUserManager]getVerificationCodeWithPhone:_mobiliTF.text];
    [UserManager shareUserManager].verificationSuccess = ^(id obj){
        
        [[Global sharedSingleton]showToastInTop:self.view withMessage:@"验证码已发送至您手机"];
        NSLog(@"%@",obj);
    };
}

- (IBAction)submit:(UIButton *)sender {
    
    if ([Global stringIsNullWithString:_nameTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"姓名")];
        return;
    }
    if ([_selectIndustryButton.titleLabel.text isEqualToString:TIPSMESSEGESELECT(@"行业")]) {
        
        [self showToastWithMessage:TIPSMESSEGESELECT(@"行业")];
        return;
    }
    
    if ([_selectProvinceButton.titleLabel.text isEqualToString:TIPSMESSEGESELECT(@"地区")]) {
        
        [self showToastWithMessage:TIPSMESSEGESELECT(@"地区")];
        return;
    }
    
    if ([Global stringIsNullWithString:_mobiliTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"手机号码")];
        return;
    }
    if ([Global stringIsNullWithString:_verificationCodeTF.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"验证码")];
        return;
    }
    
    if (!_agreedbutton.selected) {
        
        [self showToastWithMessage:@"必须同意I-Top入驻协议"];
        return;
    }
    
    for (NSArray *array in self.dataArray) {
        
        Marketing *mark = array[0];
        Marketing *mark1 = array[1];
        Marketing *mark2 = array[2];
        
        if (![Global stringIsNullWithString:mark.content] && ![Global stringIsNullWithString:mark1.content] &&
            ![Global stringIsNullWithString:mark2.content]) {
            
            NSDictionary *dic = @{@"name":mark.content,@"fans_count":mark1.content,@"index_url":mark2.content};
            [self.channelArray addObject:dic];
        }
    }
    
    NSDictionary * dic = @{@"Name" : _nameTF.text,
                           @"Phone" : _mobiliTF.text,
                           @"Phone_code" : _verificationCodeTF.text,
                           @"ChannelList" : _channelArray,
                           @"Trade" : [NSString stringWithFormat:@"%@,%@",_industry,_subIndustry],
                           @"Province" : _province.address,
                           @"City" : _city.address,
                           };
    
    [[UserManager shareUserManager]submitSigningWithParameters:dic signingType:SigningTypeMarketing];
    [UserManager shareUserManager].signingSuccess = ^(id obj){
        
        [UIManager signingStateWithShowViewType:ShowViewTypeNext];
    };
}

- (IBAction)browseProtcol:(UIButton *)sender {
   
    [UIManager protocolWithProtocolType:ProtocolTypeMarkting];
}

- (IBAction)agreedProtcol:(UIButton *)sender {
    
    _agreedbutton.selected = !_agreedbutton.selected;
    if (_agreedbutton.selected) {
        
        _agreedView.backgroundColor = UIColorFromRGB(0xfda5ed);
    } else {
        _agreedView.backgroundColor = UIColorFromRGB(0xe0e3e6);
    }
}

-(void)back{
    
    if (self.view == [_views lastObject]) {
        
        self.view  = [_views firstObject];
    }else {
        
        [super back];
    }
}

@end
