//
//  SetupProductViewController.m
//  itop
//
//  Created by huangli on 2018/3/12.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SetupProductViewController.h"

@interface SetupProductViewController ()<UITextViewDelegate,SubmitFileManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *titleTV;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UIButton *shearIconButton;
@property (weak, nonatomic) IBOutlet UILabel *stringCount;
@property (strong, nonatomic) UIImageView *h5_cover;

@end

@implementation SetupProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initNavigationBarItems{
    
    self.title = @"分享设置";
    [self setRightBarItemString:@"分享" action:@selector(shearSetup)];
    self.navigationItem.rightBarButtonItem.tintColor = RGB(232, 98, 159);
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [[ShearViewManager sharedShearViewManager]setupShearView];
    [ShearViewManager sharedShearViewManager].selectShearItme = ^(NSInteger tag){
        
    };
}

-(void)initView{
    
    [super initView];
    
    _titleTV.layer.cornerRadius = 4;
    _contentTV.layer.cornerRadius = 4;
    _contentTV.delegate = self;
    
    _titleTV.placeholder = @"请输入分享标题";
    _contentTV.placeholder = @"请输入分享描述";
    
    _stringCount.text = @"0/80";
    
    [SubmitFileManager sheardSubmitFileManager].delegate = self;
    [[SubmitFileManager sheardSubmitFileManager] addPictrueViewToViewController:_shearIconButton];
    [SubmitFileManager sheardSubmitFileManager].photoView.howMany = @"1";
}

-(void)initData{
    
    [super initData];
    
    _h5_cover = [[UIImageView alloc]init];
    [_h5_cover sd_setImageWithURL:[NSURL URLWithString:_product.cover_img] placeholderImage:[UIImage imageNamed:@"h5"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [_shearIconButton setImage:_h5_cover.image forState:UIControlStateNormal];
    }];
}

-(void)shearSetup{
    
    if ([Global stringIsNullWithString:_titleTV.text]) {
        [self showToastWithMessage:@"请输入分享标题"];
        return;
        
    }
    if ([Global stringIsNullWithString:_titleTV.text]) {
        [self showToastWithMessage:@"请输入分享描述"];
        return;
    }
    [[ShearViewManager sharedShearViewManager]addShearViewToView:self.view shearType:UMS_SHARE_TYPE_WEB_LINK completion:^(NSInteger tag) {
        
    } ];

//    [[ShearViewManager sharedShearViewManager]addTimeViewToView:self.view ];
}

- (IBAction)changeShearImage:(UIButton *)sender {
    
     [[SubmitFileManager sheardSubmitFileManager]popupsSelectPhotoTipsView];
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length > 80) {
        
        _contentTV.text = [_contentTV.text substringWithRange:NSMakeRange(0, 80)];
        [self showToastWithMessage:@"输入内容长度不超过80"];
    }
    
    _stringCount.text = [NSString stringWithFormat:@"%ld/80",(long)textView.text.length];
    NSLog(@"%@",_contentTV.text);
    NSLog(@"%ld",_contentTV.text.length);
}

#pragma Mark-提交获取图片url的协议方法
-(void)compressionAndTransferPicturesWithArray:(NSArray *)array{
    
    [_shearIconButton setBackgroundImage:[array firstObject] forState:UIControlStateNormal];
}



@end
