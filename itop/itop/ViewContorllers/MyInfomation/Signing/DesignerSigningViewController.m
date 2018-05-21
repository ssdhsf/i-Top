//
//  DesignerSigningViewController.m
//  itop
//
//  Created by huangli on 2018/2/12.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DesignerSigningViewController.h"
#import "DesignerSigningStore.h"
#import "CompanySigningStore.h"
//#import <FileProvider/FileProvider.h>

@interface DesignerSigningViewController ()<UIDocumentPickerDelegate,UIDocumentMenuDelegate>

//设计师信息页
@property (strong, nonatomic) YZTagList *tagList;
@property (strong, nonatomic) NSMutableArray *tagArray;
@property (strong, nonatomic) NSArray *views;
@property (weak, nonatomic) IBOutlet UILabel *goodAtTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *verificationCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *mobiliTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *selectProvinceButton;

@property (nonatomic, strong)NSArray *provinceArray; // 省份
@property (nonatomic, strong)NSArray *cityArray;//城市
@property (nonatomic, strong)Province *province; //选择省份
@property (nonatomic, strong)Province *city; //选择的城市
@property (nonatomic, strong)AlertView *alertView; //弹窗
@property (assign, nonatomic) NSInteger selectButtonTag; //选中的tag

//上传作品页面
@property (weak, nonatomic) IBOutlet UIButton *selectItopProductButton;
@property (weak, nonatomic) IBOutlet UITextField *productLinkTF;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UITextField *fileNameTF;

@property (weak, nonatomic) IBOutlet UIButton *agreedbutton;
@property (weak, nonatomic) IBOutlet UIView *agreedView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (strong, nonatomic) H5List *select_h5;
@property (strong, nonatomic) UIImageView *h5_cover;
@property (strong, nonatomic) CAShapeLayer *currentH5ShapeLayer;
@property (strong, nonatomic) UIDocumentPickerViewController *documentPicker;

@end

@implementation DesignerSigningViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
}

-(void)initView{
    
    [super initView];
    _views = [[NSBundle mainBundle] loadNibNamed:@"DesignerSigningViewController" owner:self options:nil];
    self.view = [_views firstObject];
    _tagArray = [NSMutableArray array];
    if ([[CompanySigningStore shearCompanySigningStore]fieldList].count == 0) {
        
        [[UserManager shareUserManager]hometagListWithType:TagTypeField];
        [UserManager shareUserManager].homeTagListSuccess = ^(id arr){
            
            [[CompanySigningStore shearCompanySigningStore]confitionFieldWithRequstFieldArray:arr];
            [_tagArray addObjectsFromArray:[[CompanySigningStore shearCompanySigningStore]fieldList]];
            [self addkeywordsViewWithkeywords:_tagArray];
        };
    } else {
        
        [_tagArray addObjectsFromArray:[[CompanySigningStore shearCompanySigningStore]fieldList]];
        for (TagList *tag in _tagArray) {
            tag.selecteTag.selecteTag = NO;
        }
        [self addkeywordsViewWithkeywords:_tagArray];
    }

    [self setupViews];
}

-(void)initData{
    
    [super initData];
    _provinceArray = [[CompanySigningStore shearCompanySigningStore]provinceArray];
    Province *province = _provinceArray[0];
    _cityArray = province.cityArray;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)setupViews{
    
    [_verificationCodeButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_verificationCodeButton)];
    _verificationCodeButton.layer.masksToBounds = YES;
    _verificationCodeButton.layer.cornerRadius = _verificationCodeButton.height/2;
    _submitButton.layer.masksToBounds = YES;
    [_submitButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitButton)];
    _submitButton.layer.cornerRadius = _submitButton.height/2;
   
    [_uploadButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_uploadButton)];
    _uploadButton.layer.masksToBounds = YES;
    _uploadButton.layer.cornerRadius = _uploadButton.height/2;
//    [_selectItopProductButton.layer addSublayer:[[Global sharedSingleton] buttonSublayerWithButton:_selectItopProductButton]];
    
    _agreedView.layer.masksToBounds = YES;
    _agreedView.layer.cornerRadius = _agreedView.height/2;
    
    _currentH5ShapeLayer = [[Global sharedSingleton] buttonSublayerWithButton:_selectItopProductButton];
    [_selectItopProductButton.layer addSublayer:_currentH5ShapeLayer];
}

-(void)initNavigationBarItems{
    
    self.title = @"入驻申请";
}

- (IBAction)selectItem:(UIButton *)sender {
    
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
            
        default:
            break;
    }
}

-(void)addkeywordsViewWithkeywords:(NSArray *)keywords{
    
    // 高度可以设置为0，会自动跟随标题计算
    _tagList = [[YZTagList alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_goodAtTitleLabel.frame), CGRectGetMinY(_goodAtTitleLabel.frame), ScreenWidth-CGRectGetMaxX(_goodAtTitleLabel.frame)-20, 0)];
    _tagList.tag = 1;
    _tagList.backgroundColor = [UIColor whiteColor];
    _tagList.tagCornerRadius = 3;
    _tagList.borderColor = UIColorFromRGB(0xc6c8ce);
    _tagList.borderWidth = 1;
    _tagList.tagFont =  [UIFont systemFontOfSize:15] ;
    // 设置标签背景色
//    _tagList.tagBackgroundColor = RGB(244, 245, 247);
    _tagList.tagColor = [UIColor blackColor];
    [_tagList addFieldTag: keywords action:@selector(fieldTag:)];
    [_scrollView addSubview:_tagList];
//    _nextButton.frame = CGRectMake(ScreenWidth/2-65,CGRectGetMaxY(_tagList.frame)+30,130 , 35);
    
     __weak typeof(self) weakSelf = self;
    _tagList.fieldTagBlock = ^ (NSString *tag, BOOL select){
        
        NSInteger selectNumber = 0 ;
        for (TagList *sTag in weakSelf.tagArray) {
            if (sTag.selecteTag.selecteTag ==YES) {
                
                selectNumber ++;
            }
        }
        if (selectNumber == 3) {
            
            for (TagList *sTag in weakSelf.tagArray) {
                if ([sTag.name isEqualToString:tag]  && sTag.selecteTag.selecteTag == YES) {
                    
                    sTag.selecteTag.selecteTag = !sTag.selecteTag.selecteTag;
                    [weakSelf addkeywordsViewWithkeywords:weakSelf.tagArray];
                    return ;
                }
            }
            [[Global sharedSingleton]showToastInTop:weakSelf.view withMessage:@"选择不超过3个"];
            return ;
        }else {
        
            for (TagList *sTag in weakSelf.tagArray) {
                if ([sTag.name isEqualToString:tag]) {
                    
                    sTag.selecteTag.selecteTag = !sTag.selecteTag.selecteTag;
                }
            }
            
        }
        [weakSelf addkeywordsViewWithkeywords:weakSelf.tagArray];
        NSLog(@"%@",tag);
    };
    
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = _nextButton.height/2;
    _nextButton.frame = CGRectMake(ScreenWidth/2-65,CGRectGetMaxY(_tagList.frame)+30,130 , 35);
    [_nextButton.layer insertSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_nextButton) atIndex:0];
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

- (IBAction)next:(UIButton *)sender {

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
    if (!_province) {
        
        [self showToastWithMessage:TIPSMESSEGESELECT(@"地区")];
        return;
    }

    NSInteger selectNumber = 0 ;
    for (TagList *sTag in self.tagArray) {
        if (sTag.selecteTag.selecteTag ==YES) {
            
            selectNumber ++;
        }
    }
    
    if (selectNumber == 0) {
        
        [self showToastWithMessage:@"请选择您的特长"];
        return;
    }
    
    self.view  = _views[1] ;
}

- (IBAction)agreedProtcol:(UIButton *)sender {
    
    _agreedbutton.selected = !_agreedbutton.selected;
    if (_agreedbutton.selected) {
        
        _agreedView.backgroundColor = UIColorFromRGB(0xfda5ed);
    } else {
        _agreedView.backgroundColor = UIColorFromRGB(0xe0e3e6);
    }
    NSLog(@"ddddd");
}

- (IBAction)Protcol:(UIButton *)sender {
    
    [UIManager protocolWithProtocolType:ProtocolTypeDesginer];
}

- (IBAction)selectProduct:(UIButton *)sender {
    
    [UIManager productViewControllerWithType:GetProductListTypeSelect];
    [UIManager sharedUIManager].selectProductBolck = ^(H5List *h5){
        
        _select_h5 = h5;
        _h5_cover = [[UIImageView alloc]init];
        [_h5_cover sd_setImageWithURL:[NSURL URLWithString:h5.cover_img] placeholderImage:H5PlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [_selectItopProductButton setImage:_h5_cover.image forState:UIControlStateNormal];
            [_currentH5ShapeLayer removeFromSuperlayer];
            
        }];
    };

}

- (IBAction)selectZipFile:(UIButton *)sender {
    
    NSArray* docTypes = @[ (NSString*)kUTTypeZipArchive ,(NSString*)kUTTypeBzip2Archive,(NSString *)kUTTypeGNUZipArchive,(NSString *)kUTTypeArchive];
     _documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:docTypes inMode:UIDocumentPickerModeImport];
    
    _documentPicker.delegate = self;
    _documentPicker.modalPresentationStyle = UIModalPresentationCustom;

//    UIBarButtonItem *left = [UIBarButtonItem ]
//    documentPicker.navigationController.navigationItem.leftBarButtonItem
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateNormal];
//    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
//    [leftBtn setTitleColor:UIColorFromRGB(0xFFA5EC) forState:UIControlStateNormal];
//    [leftBtn setTintColor:UIColorFromRGB(0xFFA5EC)];
    [leftBtn addTarget:self action:@selector(documentPickerBack) forControlEvents:UIControlEventTouchUpInside];
//    leftBtn.backgroundColor = [UIColor blueColor];
    leftBtn.frame = CGRectMake(20, 30, 30, 30);
    [_documentPicker.view addSubview:leftBtn];
    
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    
//    [rightBtn setTintColor:UIColorFromRGB(0xFFA5EC)];
    //    leftBtn.backgroundColor = [UIColor blueColor];
    rightBtn.frame = CGRectMake(ScreenWidth-80, 30, 60, 30);
    [rightBtn setTitleColor:UIColorFromRGB(0xFFA5EC) forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [_documentPicker.view addSubview:rightBtn];
    
    
    [self presentViewController:_documentPicker animated:YES completion:^{
        
        NSLog(@"12");
    }];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    if (controller.documentPickerMode == UIDocumentPickerModeImport) {
        dispatch_async(dispatch_get_main_queue(), ^{

            NSData *data = [NSData dataWithContentsOfURL:url];
            NSInteger length = [data length]/1000/1000;
            
            if (length > 10) {
                
                [self AlertOperation];
            } else {
                
                _fileNameTF.text = [url lastPathComponent];
            }
            NSLog(@"%ldfM",length);
        });
    }
}

-(void)documentPickerBack{
    
    [self.documentPicker.navigationController popToViewController:self.documentPicker animated:YES];
}

-(void)cancel{
    
    [self.documentPicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)back{
    
    if (self.view == _views[1] ) {
        
        self.view  = [_views firstObject];
    }else {
        
        [super back];
    }
}

-(void)AlertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"压缩文件不能大于10M" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//        [self back];
//    }];
    [alertController addAction:cancelAction];
//    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)submit:(UIButton *)sender {

    if (!_agreedbutton.selected) {
        
        [self showToastWithMessage:@"必须同意i-Top协议才能入驻申请"];
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (_select_h5 == nil && [Global stringIsNullWithString:_productLinkTF.text]) {
        
        [self showToastWithMessage:@"请至少选择一个作品或者作品链接"];
        
    } else {
        if (_select_h5 != nil) {
            
            [parameters setObject:_select_h5.url forKey:@"Url"];
        }
        
        if (![Global stringIsNullWithString:_productLinkTF.text]) {
            
            [parameters setObject:_productLinkTF.text forKey:@"Attachment"];
        }
    }

    NSString *field ;
    for (TagList *sTag in self.tagArray) {
        if (sTag.selecteTag.selecteTag == YES) {
            
            if (field == nil) {
                
                field = [NSString stringWithFormat:@"%@",sTag.id];
            } else {
                
                field = [NSString stringWithFormat:@"%@,%@",field,sTag.id];
            }
        }
    }

    [parameters setObject:_nameTF.text forKey:@"Name"];
    [parameters setObject:_mobiliTF.text forKey:@"Phone"];
    [parameters setObject:_verificationCodeTF.text forKey:@"Phone_code"];
    [parameters setObject:_province.code forKey:@"Province_code"];
    [parameters setObject:_city.code forKey:@"City_code"];
    [parameters setObject:field forKey:@"Field"];
    
    [[UserManager shareUserManager]submitSigningWithParameters:parameters signingType:SigningTypeDesigner];
    [UserManager shareUserManager].signingSuccess =  ^(id obj){
        
        [UIManager signingStateWithShowViewType:ShowSigningStateViewTypeNext signingState:nil signingType:SigningTypeMarNoel];
    };

    
//    if (_select_h5 != nil || _fileNameTF.text != nil || _productLinkTF != nil) {
//        
//        
//    }
}
- (IBAction)guide:(UIButton *)sender {
    
    
    
}

@end
