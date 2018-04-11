//
//  ReleaseHotViewController.m
//  itop
//
//  Created by huangli on 2018/3/16.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ReleaseHotViewController.h"
#import "SegmentTapView.h"

@interface ReleaseHotViewController ()<SegmentTapViewDelegate,UIScrollViewDelegate,SubmitFileManagerDelegate>

@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, assign)NSInteger itmeIndex;
@property (nonatomic ,strong)UIScrollView *scroll;
@property (nonatomic, strong)NSArray *dataArray;
@property (strong, nonatomic )NSArray *views;
@property (strong, nonatomic) CAShapeLayer *currentInfoShapeLayer;
@property (strong, nonatomic) CAShapeLayer *currentH5ShapeLayer;

/*资讯*/
@property (weak, nonatomic) IBOutlet UITextView *titleInfoTV;
@property (weak, nonatomic) IBOutlet UIButton *addInfoImage;
@property (weak, nonatomic) IBOutlet UIButton *submitInfoButton;
@property (weak, nonatomic) IBOutlet UITextView *contentInfoTV;
/*H5*/
@property (weak, nonatomic) IBOutlet UITextView *titleH5TV;
@property (weak, nonatomic) IBOutlet UIButton *addH5Image;
@property (weak, nonatomic) IBOutlet UIButton *submitH5Button;
@property (weak, nonatomic) IBOutlet UITextView *contentH5TV;
@property (weak, nonatomic) IBOutlet UIScrollView *h5ScrollView;
@property (strong, nonatomic) UIImageView *h5_cover;
@property (strong, nonatomic) H5List *select_h5;

@end

@implementation ReleaseHotViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
}

-(void)initView{
    
    [super initView];
    _views = [[NSBundle mainBundle] loadNibNamed:@"ReleaseHotViewController" owner:self options:nil];
    self.view = [_views firstObject];
    _itmeIndex = 0;
    [self initSegment];
    [self.view addSubview:self.segment];
    [self setupH5SubViews];
    [self setupInfoSubViews];
    [SubmitFileManager sheardSubmitFileManager].delegate = self;
//    [[SubmitFileManager sheardSubmitFileManager] addPictrueViewToViewController:_addH5Image];
    [[SubmitFileManager sheardSubmitFileManager] addPictrueViewToViewController:_addInfoImage];
    [SubmitFileManager sheardSubmitFileManager].photoView.howMany = @"1";

}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initNavigationBarItems{
    
    self.title = @"发布热点";
}

-(void)initData{
    
    self.dataArray = [NSArray arrayWithObjects:@"H5",@"资讯", @"视频", nil];
}

-(void)initSegment{
    
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/2, 40) withDataArray:self.dataArray withFont:15];
    self.segment.delegate = self;
    self.segment.lineColor = [UIColor clearColor];
    self.segment.textNomalColor = UIColorFromRGB(0x434a5c);
    self.segment.textSelectedColor = UIColorFromRGB(0xf95aee);
}

-(void)setupH5SubViews{
    
    
    _h5ScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeigh-40);
//    _h5ScrollView.shouldHideToolbarPlaceholder = NO;
    _titleH5TV.placeholder = @"请输入文章标题最多20字";
    _contentH5TV.placeholder = @"请输入H5内容说明";
    [_submitH5Button.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitH5Button)];
    _submitH5Button.layer.cornerRadius = _submitH5Button.height/2;
    _submitH5Button.layer.masksToBounds = YES;
    _currentH5ShapeLayer = [[Global sharedSingleton] buttonSublayerWithButton:_addH5Image];
    [_addH5Image.layer addSublayer:_currentH5ShapeLayer];
}

-(void)setupInfoSubViews{
    
    _titleInfoTV.placeholder = @"请输入文章标题最多20字";
    _contentInfoTV.placeholder = @"请输入H5内容说明";
    [_submitInfoButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitInfoButton)];
    _submitInfoButton.layer
.cornerRadius = _submitInfoButton.height/2;
    _submitInfoButton.layer.masksToBounds = YES;
    _currentInfoShapeLayer = [[Global sharedSingleton] buttonSublayerWithButton:_addInfoImage];
    [_addInfoImage.layer addSublayer:_currentInfoShapeLayer];
}

#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index{

    _itmeIndex = index;
    self.view  = _views[index];
    [self.view addSubview:self.segment];
    if (index > 1) {
       
        self.originY = 50;
        [self setHasData:NO];
    }
}

#pragma Mark-提交获取图片url的协议方法
-(void)compressionAndTransferPicturesWithArray:(NSArray *)array{
   
    if (_itmeIndex == 0) {
        if (array.count == 0) {
            
            [_addH5Image setImage:[UIImage imageNamed:@"ruzhu_icon_add"] forState:UIControlStateNormal];
            [_addH5Image.layer addSublayer:_currentH5ShapeLayer];
            
        }else {
            
            [_currentH5ShapeLayer removeFromSuperlayer];
            [_addH5Image setImage:[array lastObject] forState:UIControlStateNormal];
        }
    } else {
        if (array.count == 0) {
            
            [_addInfoImage setImage:[UIImage imageNamed:@"ruzhu_icon_add"] forState:UIControlStateNormal];
            [_addInfoImage.layer addSublayer:_currentInfoShapeLayer];
            
        }else {
            
            [_currentInfoShapeLayer removeFromSuperlayer];
            [_addInfoImage setImage:[array lastObject] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)addImage:(UIButton *)sender {
   
    if (sender.tag == 1) {
        
        [UIManager productViewControllerWithType:GetProductListTypeSelect];
        [UIManager sharedUIManager].selectProductBolck = ^(H5List *h5){
            
            _select_h5 = h5;
            _h5_cover = [[UIImageView alloc]init];
            [_h5_cover sd_setImageWithURL:[NSURL URLWithString:h5.cover_img] placeholderImage:[UIImage imageNamed:@"h5"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                [_addH5Image setImage:_h5_cover.image forState:UIControlStateNormal];
                [_currentH5ShapeLayer removeFromSuperlayer];
                
            }];
        };
    }else {
        
        [[SubmitFileManager sheardSubmitFileManager]popupsSelectPhotoTipsView];
    }
}

- (IBAction)subMitHot:(UIButton *)sender {
    
    if (sender.tag == 1) {
       
        [self submitH5Hot];

    } else {
       
        [self submitInfoHot];
    }
}

-(void)submitH5Hot{
    
    if ([Global stringIsNullWithString:_titleH5TV.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"标题")];
        return;
    }
    if ([Global stringIsNullWithString:_contentH5TV.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"内容")];
        return;
    }
    
    if (_select_h5 == nil) {
        
        [self showToastWithMessage:TIPSMESSEGEADD(@"作品")];
        return;
    }
    
    [UIManager showVC:@"HotBusinessCircleController"];
    
//    [[SubmitFileManager sheardSubmitFileManager]compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:self andType:nil];
//    [UserManager shareUserManager].submitFileSuccess = ^ (id obj){
    
//        NSString *fileUrl = [NSString stringWithFormat:@"%@",_select_h5.cover_img];
//        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//        [parameters setObject:fileUrl forKey:@"Cover_img"];
//        [parameters setObject:_titleH5TV.text forKey:@"Title"];
//        [parameters setObject:_contentH5TV.text forKey:@"Content"];
//        [parameters setObject:@(1) forKey:@"Article_type"];
//        [parameters setObject:_select_h5.url forKey:@"Url"];
//        
//        [[UserManager shareUserManager]addHotListWithParameters:parameters];
//        [UserManager shareUserManager].addHotSuccess =  ^(id obj){
//            
//            [self alertOperation];
//        };
//    };
}

-(void)submitInfoHot{
    
    if ([Global stringIsNullWithString:_titleInfoTV.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"标题")];
        return;
    }
    if ([Global stringIsNullWithString:_contentInfoTV.text]) {
        
        [self showToastWithMessage:TIPSMESSEGE(@"内容")];
        return;
    }
    
    if ([_addInfoImage.imageView.image isEqual:[UIImage imageNamed:@"ruzhu_icon_add"]]) {
        
        [self showToastWithMessage:TIPSMESSEGEADD(@"文件")];
        return;
    }

    [[SubmitFileManager sheardSubmitFileManager]compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:self andType:nil];
    [UserManager shareUserManager].submitFileSuccess = ^ (id obj){
        
        NSString *fileUrl = [NSString stringWithFormat:@"%@",obj];
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        [parameters setObject:fileUrl forKey:@"Cover_img"];
        [parameters setObject:_titleInfoTV.text forKey:@"Title"];
        [parameters setObject:_contentInfoTV.text forKey:@"Content"];
        [parameters setObject:@(0) forKey:@"Article_type"];
        [[UserManager shareUserManager]addHotListWithParameters:parameters];
        [UserManager shareUserManager].addHotSuccess =  ^(id obj){
            
            
            [self alertOperation];
        };
    };
}

-(void)alertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"热点提交成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续提交" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self back];
        [UIManager sharedUIManager].realesHotBackOffBolck( @(_itmeIndex));
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
