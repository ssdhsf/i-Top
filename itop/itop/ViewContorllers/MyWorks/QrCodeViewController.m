//
//  QrCodeViewController.m
//  itop
//
//  Created by huangli on 2018/3/12.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "QrCodeViewController.h"

@interface QrCodeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *savePhoto;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;

@end

@implementation QrCodeViewController

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

-(void)initView{
    
    [super initView];
    [_savePhoto.layer addSublayer:[UIColor setGradualChangingColor:_savePhoto fromColor:@"FFA5EC" toColor:@"DEA2FF"]];
    _savePhoto.layer.cornerRadius = _savePhoto.frame.size.height/2;
    _savePhoto.layer.masksToBounds = YES;
    
    [self createQRCode];
}

-(void)initNavigationBarItems {
    
    self.title = @"二维码";
}

- (IBAction)savePhoto:(UIButton *)sender {
    
    //保存图片到相册
    UIImageWriteToSavedPhotosAlbum(self.qrCodeImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)createQRCode {
    
    //1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //2.恢复滤镜的默认属性
    [filter setDefaults];
    
    //3.将字符串转化为NSData
    NSString *string = @"http://i-top.cn";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //4.通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    //5.获得滤镜输出的图像
    CIImage *outputImg = [filter outputImage];
    
    //6.将CIImage转换为UIImage 并放大显示
    self.qrCodeImageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImg withSize:150];
}


- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
//    NSString *text = nil;
    if(error)
    {
        [self showToastWithMessage:@"保存图片失败"]; ;
    }
    else
    {
        [self showToastWithMessage:@"保存图片成功"];
    }
}


@end
