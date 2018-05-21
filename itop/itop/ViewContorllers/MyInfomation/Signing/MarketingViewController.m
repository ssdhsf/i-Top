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
@property (nonatomic, strong) NSArray *provinceArray; // 省份
@property (nonatomic, strong) NSArray *cityArray;//城市
@property (nonatomic, strong) NSArray *industryArray; // 行业／1级
@property (nonatomic, strong) NSArray *industrySubArray;//行业／子级
@property (nonatomic, strong) Province *province; //选择省份
@property (nonatomic, strong) Province *city; //选择的城市
@property (nonatomic, strong)TagList *superTag; //选择行业 父级
@property (nonatomic, strong)TagList *subTag; //选择行业 子级

@property (nonatomic, strong) NSMutableArray *channelArray; //渠道列表
@property (nonatomic, strong) MarketingDataSource *marketingDataSource;
@property (strong, nonatomic) IBOutlet UIView *fooderView;

@property (nonatomic, strong)AlertView *alertView; //弹窗

@property (assign, nonatomic) NSInteger selectButtonTag;
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
    
    if ([[CompanySigningStore shearCompanySigningStore]superTagList].count == 0) {
        
        [[UserManager shareUserManager]hometagListWithType:TagTypeTrade];
        [UserManager shareUserManager].homeTagListSuccess = ^(id arr){
            
            [[CompanySigningStore shearCompanySigningStore]confitionIndustryWithRequstIndustryArray:arr];
            _industryArray = [[CompanySigningStore shearCompanySigningStore]superTagList];
            TagList *tag = _industryArray[0];
            _industrySubArray = tag.subTagArray;
            
        };
    }

    _provinceArray = [[CompanySigningStore shearCompanySigningStore]provinceArray];
    Province *province = _provinceArray[0];
    _cityArray = province.cityArray;
    
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

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

-(void)setupSubView{
    
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = _nextButton.frame.size.height/2;
    [_nextButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_nextButton)];
    
    _addChannelButton.frame = CGRectMake(100, 42, ScreenWidth-120, 30);
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
            
            NSLog(@"%@",inputText);
            NSIndexPath *index = [self.tableView indexPathForCell:cell1];
            MarketingTableViewCell *cell = [self.tableView cellForRowAtIndexPath:index];
            NSLog(@"%@",cell.ContentTF.text);
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
    
    [_nameTF resignFirstResponder];
    [_mobiliTF resignFirstResponder];
    [_verificationCodeTF resignFirstResponder];
    _selectButtonTag = sender.tag;
    [self showAlertViewWithItem:sender];
}

-(void)showAlertViewWithItem:(UIButton*)button{

    NSString *string = [NSString stringWithFormat:@"请选择%@",button.titleLabel.text];
    
    NSArray *superArray = [NSArray array];
    NSArray *subArray = [NSArray array];
    switch (button.tag) {
            
        case PickViewTypeProvince:
            
            superArray = _provinceArray;
            subArray = _cityArray;
            break;
        case PickViewTypeIndustry:
            
            superArray = _industryArray;
            subArray = _industrySubArray;
            break;
        default:
            break;
    }
    
    _alertView = [[AlertView alloc]initWithTitle:string
                                         message:nil
                                         sureBtn:@"确定"
                                       cancleBtn:@"取消"
                                    pickViewType:button.tag
                                      superArray:superArray
                                        subArray:subArray];
    
    
    __weak typeof(self) weakSelf = self;
    _alertView.selectResult = ^( id superResult, id subResult) {
        
        [weakSelf updataInfomationWithselectSuperItme:superResult selectSubItme:subResult];
    };
    
    if ([button.titleLabel.text  rangeOfString:@"请选择"].location  == NSNotFound) {
        [_alertView setupPickViewWithContent:button.titleLabel.text];
    }
    [_alertView showXLAlertView];
}

-(void)updataInfomationWithselectSuperItme:(id)selectSuperItme
                             selectSubItme:(id)selectSubItme{
    
    switch (_selectButtonTag) {

        case PickViewTypeProvince:
            
            _province = (Province *)selectSuperItme;
            _city = (Province *)selectSubItme;
            
            [_selectProvinceButton setTitle:[NSString stringWithFormat:@"%@,%@",_province.address,_city.address] forState:UIControlStateNormal];
            break;
        case PickViewTypeIndustry:
            _superTag = (TagList *)selectSuperItme;
            _subTag = (TagList *)selectSubItme;
            [_selectIndustryButton setTitle:[NSString stringWithFormat:@"%@,%@",_superTag.name,_subTag.name] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
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
                           @"Trade" : [NSString stringWithFormat:@"%@,%@",_superTag.id,_subTag.id],
                           @"Province" : _province.code,
                           @"City" : _city.code,
                           };
    
    [[UserManager shareUserManager]submitSigningWithParameters:dic signingType:SigningTypeMarketing];
    [UserManager shareUserManager].signingSuccess = ^(id obj){
        
        [UIManager signingStateWithShowViewType:ShowSigningStateViewTypeNext signingState:nil signingType:SigningTypeMarNoel];
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
