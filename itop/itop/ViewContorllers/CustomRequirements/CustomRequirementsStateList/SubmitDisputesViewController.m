//
//  SubmitDisputesViewController.m
//  itop
//
//  Created by huangli on 2018/5/3.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SubmitDisputesViewController.h"
#import "LMJDropdownMenu.h"

@interface SubmitDisputesViewController ()<SubmitFileManagerDelegate,LMJDropdownMenuDelegate>

@property (weak, nonatomic) IBOutlet UILabel *passableTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *passableImageButton;
@property (weak, nonatomic) IBOutlet UITextView *noteTV;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSArray *dropdownItme; //下拉分类
@property (strong, nonatomic) LMJDropdownMenu *dropdownMenu;
@property (strong, nonatomic) CAShapeLayer *currentShapeLayer;
@property (strong, nonatomic) NSString *selectPassable;

@end

@implementation SubmitDisputesViewController

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
    
    self.title = @"平台介入";
}

-(void)initView{
    
    [super initView];
    [SubmitFileManager sheardSubmitFileManager].delegate = self;
    [[SubmitFileManager sheardSubmitFileManager] addPictrueViewToViewController:_passableImageButton];
    [SubmitFileManager sheardSubmitFileManager].photoView.howMany = @"1";
    
    [self steupDropdownMenu];
    
    [_submitButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitButton)];
    _submitButton.layer.masksToBounds = YES;
    _submitButton.layer.cornerRadius = _submitButton.height /2;

    _currentShapeLayer = [[Global sharedSingleton] buttonSublayerWithButton:_passableImageButton];
    [_passableImageButton.layer addSublayer:_currentShapeLayer];
    
    self.noteTV.layer.borderWidth = 1.0f;
    self.noteTV.layer.borderColor = UIColorFromRGB(0xDADEE4).CGColor;
}

-(void)initData{
    
    [super initData];
    [[SubmitFileManager sheardSubmitFileManager]emptyThePictureArray];

}

-(void)steupDropdownMenu{
    
    _dropdownMenu = [[LMJDropdownMenu alloc]initWithFrame:CGRectMake(94, 0, ScreenWidth-188, 44)];
    _dropdownMenu.centerY = _passableTitleLabel.centerY;
    [_scrollView addSubview:_dropdownMenu];
    _dropdownItme = @[@"多次修改需求",@"未收到款项",@"态度恶劣，不想继续合作", @"其他"];
    [_dropdownMenu setMenuTitles:self.dropdownItme rowHeight:44];
    _dropdownMenu.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)compressionAndTransferPicturesWithArray:(NSArray *)array{
    
    if (array.count == 0) {
        
        [_passableImageButton setImage:[UIImage imageNamed:@"ruzhu_icon_add"] forState:UIControlStateNormal];
        [_passableImageButton.layer addSublayer:_currentShapeLayer];
        
    }else {
        
        [_currentShapeLayer removeFromSuperlayer];
        [_passableImageButton setImage:[array lastObject] forState:UIControlStateNormal];
    }
}

- (IBAction)addImage:(UIButton *)sender {
    
    [[SubmitFileManager sheardSubmitFileManager]popupsSelectPhotoTipsView];
}

- (IBAction)submit:(UIButton *)sender {
    
    if ([_dropdownMenu.mainBtn.titleLabel.text isEqualToString:@"请选择"]) {
        
        [self showToastWithMessage:@"请选择问题"];
        return;
    }
    
    if ([[SubmitFileManager sheardSubmitFileManager]getSelectedPicktures].count == 0) {
        
        [self showToastWithMessage:@"请添加图片"];
        return;
    }
    
    if ([Global stringIsNullWithString:_noteTV.text]) {
        
        [self showToastWithMessage:@"请填写备注"];
        return;
    }
    
    NSNumber *user_id = [[UserManager shareUserManager]crrentUserId];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_dropdownMenu.mainBtn.titleLabel.text forKey:@"Question"];
    [dic setObject:_demant_id forKey:@"Demand_id"];
    [dic setObject:user_id forKey:@"User_id"];
    [dic setObject:_noteTV.text forKey:@"Remark"];
 
    [[SubmitFileManager sheardSubmitFileManager]compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:self andType:nil];
    [UserManager shareUserManager].submitFileSuccess = ^ (id obj){
        
           [dic setObject:obj forKey:@"Img"];
        [[UserManager shareUserManager]addDemandDemanddisputeWithParameters:dic];
        [UserManager shareUserManager].customRequirementsSuccess = ^(id obj){
            
            [self alertOperation];
        };
    };
}

-(void)alertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续提交" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self back];
//        [UIManager sharedUIManager].realesHotBackOffBolck( @(_itmeIndex));
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
