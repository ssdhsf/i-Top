//
//  ShearViewController.m
//  itop
//
//  Created by huangli on 2018/3/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ShearViewController.h"
#import "ShearViewManager.h"

static NSString* const UMS_Title = @"i-Top";
static NSString* const UMS_Text = @"欢迎使用i-Top";
static NSString* const UMS_THUMB_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
static NSString* const UMS_Web_Desc = @"i-Top最好的自营销平台";
static NSString* const UMS_WebLink = @"http://mobile.umeng.com/social";

@interface ShearViewController ()<UMSocialShareMenuViewDelegate>

//@property(nonatomic,strong)WebViewController *webVc;

@property (nonatomic, assign) UMSocialPlatformType platform;
@property (nonatomic, assign) UMS_SHARE_TYPE shear_type;
@property (nonatomic, strong) NSDictionary *platfomrSupportTypeDict;

@end

@implementation ShearViewController


- (instancetype)initWithType:(UMSocialPlatformType)type{
    
    if (self = [super init]) {
        self.platform = type;
        [self initPlatfomrSupportType];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    NSString *platformName = nil;
//    NSString *iconName = nil;
//    [UMSocialUIUtility configWithPlatformType:self.platform withImageName:&iconName withPlatformName:&platformName];
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
        
        
        
//        [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];
        
    };
    //    [UMSocialUIManager setShareMenuViewDelegate:self];
}

-(void)initView{
    
    [super initView];
}

-(void)initNavigationBarItems{
    
    self.title = @"分享";
}

- (IBAction)shear:(UIButton *)sender {
    
    [[ShearViewManager sharedShearViewManager]addShearViewToView:self.view shearType:UMS_SHARE_TYPE_WEB_LINK completion:^(NSInteger tag) {
        
        
        
    } ];
//    [[ShearViewManager sharedShearViewManager]addTimeViewToView:self.view ];
}

- (void)initPlatfomrSupportType
{
    self.platfomrSupportTypeDict =
    @{
      @(UMSocialPlatformType_WechatSession): @[@(UMS_SHARE_TYPE_MINI_PROGRAM), @(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK), @(UMS_SHARE_TYPE_EMOTION), @(UMS_SHARE_TYPE_FILE)],
      
      @(UMSocialPlatformType_WechatTimeLine): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_Sina): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_QQ): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_Qzone): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      };
}

- (NSString *)typeNameWithType:(UMS_SHARE_TYPE)type
{
    switch (type) {
        case UMS_SHARE_TYPE_TEXT:
        {
            return @"纯文本";
        }
            break;
        case UMS_SHARE_TYPE_IMAGE:
        {
            return @"本地图片";
        }
            break;
        case UMS_SHARE_TYPE_IMAGE_URL:
        {
            return @"HTTPS网络图片";
        }
            break;
        case UMS_SHARE_TYPE_TEXT_IMAGE:
        {
            if (self.platform == UMSocialPlatformType_Linkedin) {
                return @"文本+HTTPS图片";
            }
            return @"文本+图片";
        }
            break;
        case UMS_SHARE_TYPE_WEB_LINK:
        {
            return @"网页链接";
        }
            break;
        case UMS_SHARE_TYPE_MUSIC_LINK:
        {
            return @"音乐链接";
        }
            break;
        case UMS_SHARE_TYPE_MUSIC:
        {
            return @"本地音乐";
        }
            break;
        case UMS_SHARE_TYPE_VIDEO_LINK:
        {
            return @"视频连接";
        }
            break;
        case UMS_SHARE_TYPE_VIDEO:
        {
            return @"本地视频";
        }
            break;
        case UMS_SHARE_TYPE_EMOTION:
        {
            return @"Gif表情";
        }
            break;
        case UMS_SHARE_TYPE_FILE:
        {
            return @"文件";
        }
        case UMS_SHARE_TYPE_MINI_PROGRAM:
        {
            return @"微信小程序";
        }
            break;
        default:
            break;
    }
    return nil;
}


- (void)shareWithType:(UMS_SHARE_TYPE)type
{
    switch (type) {
        case UMS_SHARE_TYPE_TEXT:
        {
            [self shareTextToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_IMAGE:
        {
            [self shareImageToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_IMAGE_URL:
        {
//            [self shareImageURLToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_TEXT_IMAGE:
        {
//            [self shareImageAndTextToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_WEB_LINK:
        {
            [self shareWebPageToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_MUSIC_LINK:
        {
//            [self shareMusicToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_MUSIC:
        {
            //            [self shareLocalMusicToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_VIDEO_LINK:
        {
//            [self shareVedioToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_VIDEO:
        {
            //            [self shareLocalVedioToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_EMOTION:
        {
            [self shareEmoticonToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_FILE:
        {
            [self shareFileToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_MINI_PROGRAM:
        {
            //            [self shareMiniProgramToPlatformType:self.platform];
        }
            break;
        default:
            break;
    }
}

#pragma mark - share type
//分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = UMS_Text;
    
    //#ifdef UM_Swift
    //    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
    //#else
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        //#endif
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

//分享图片
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图本地
    shareObject.thumbImage = [UIImage imageNamed:@"icon"];
    
    [shareObject setShareImage:[UIImage imageNamed:@"logo"]];
    
    // 设置Pinterest参数
    if (platformType == UMSocialPlatformType_Pinterest) {
        [self setPinterstInfo:messageObject];
    }
    
    // 设置Kakao参数
    if (platformType == UMSocialPlatformType_KakaoTalk) {
        messageObject.moreInfo = @{@"permission" : @1}; // @1 = KOStoryPermissionPublic
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //#ifdef UM_Swift
    //              [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
    //#else
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        //#endif
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

////分享网络图片
//- (void)shareImageURLToPlatformType:(UMSocialPlatformType)platformType
//{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    
//    //创建图片内容对象
//    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
//    //如果有缩略图，则设置缩略图
//    shareObject.thumbImage = UMS_THUMB_IMAGE;
//    
//    [shareObject setShareImage:UMS_IMAGE];
//    
//    // 设置Pinterest参数
//    if (platformType == UMSocialPlatformType_Pinterest) {
//        [self setPinterstInfo:messageObject];
//    }
//    
//    // 设置Kakao参数
//    if (platformType == UMSocialPlatformType_KakaoTalk) {
//        messageObject.moreInfo = @{@"permission" : @1}; // @1 = KOStoryPermissionPublic
//    }
//    
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//    
//    //#ifdef UM_Swift
//    //                   [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
//    //#else
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        //#endif
//        if (error) {
//            UMSocialLogInfo(@"************Share fail with error %@*********",error);
//        }else{
//            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                UMSocialShareResponse *resp = data;
//                //分享结果消息
//                UMSocialLogInfo(@"response message is %@",resp.message);
//                //第三方原始返回的数据
//                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//                
//            }else{
//                UMSocialLogInfo(@"response data is %@",data);
//            }
//        }
//        [self alertWithError:error];
//    }];
//}

////分享图片和文字
//- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
//{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    
//    //设置文本
//    messageObject.text = UMS_Text_image;
//    
//    //创建图片内容对象
//    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
//    //如果有缩略图，则设置缩略图
//    if (platformType == UMSocialPlatformType_Linkedin) {
//        // linkedin仅支持URL图片
//        shareObject.thumbImage = UMS_THUMB_IMAGE;
//        [shareObject setShareImage:UMS_IMAGE];
//    } else {
//        shareObject.thumbImage = [UIImage imageNamed:@"icon"];
//        shareObject.shareImage = [UIImage imageNamed:@"logo"];
//    }
//    
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//    
//    //#ifdef UM_Swift
//    //    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
//    //#else
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        //#endif
//        if (error) {
//            UMSocialLogInfo(@"************Share fail with error %@*********",error);
//        }else{
//            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                UMSocialShareResponse *resp = data;
//                //分享结果消息
//                UMSocialLogInfo(@"response message is %@",resp.message);
//                //第三方原始返回的数据
//                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//                
//            }else{
//                UMSocialLogInfo(@"response data is %@",data);
//            }
//        }
//        [self alertWithError:error];
//    }];
//}

//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:UMS_Title descr:UMS_Web_Desc thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = UMS_WebLink;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
//#ifdef UM_Swift
//    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
//#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//#endif
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];
    }
     
//音乐分享
//- (void)shareMusicToPlatformType:(UMSocialPlatformType)platformType
//{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    
//    //创建音乐内容对象
//    NSString* thumbURL =  UMS_THUMB_IMAGE;
//    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:UMS_Title descr:UMS_Music_Desc thumImage:thumbURL];
//    //设置音乐网页播放地址
//    shareObject.musicUrl = @"http://c.y.qq.com/v8/playsong.html?songid=108782194&source=yqq#wechat_redirect";
//    shareObject.musicDataUrl = @"http://music.huoxing.com/upload/20130330/1364651263157_1085.mp3";
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//    
////#ifdef UM_Swift
////    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
////#else
//        //调用分享接口
//        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
////#endif
//            if (error) {
//                UMSocialLogInfo(@"************Share fail with error %@*********",error);
//            }else{
//                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                    UMSocialShareResponse *resp = data;
//                    //分享结果消息
//                    UMSocialLogInfo(@"response message is %@",resp.message);
//                    //第三方原始返回的数据
//                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//                    
//                }else{
//                    UMSocialLogInfo(@"response data is %@",data);
//                }
//            }
//            [self alertWithError:error];
//        }];
//        
//    }
//视频分享
//- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType
//{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    
//    NSString* thumbURL =  UMS_THUMB_IMAGE;
//    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:UMS_Title descr:UMS_Video_Desc thumImage:thumbURL];
//    //设置视频网页播放地址
//    shareObject.videoUrl = @"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html";
//    
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//    
//    //#ifdef UM_Swift
//    //    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
//    //#else
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        //#endif
//        if (error) {
//            UMSocialLogInfo(@"************Share fail with error %@*********",error);
//        }else{
//            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                UMSocialShareResponse *resp = data;
//                //分享结果消息
//                UMSocialLogInfo(@"response message is %@",resp.message);
//                //第三方原始返回的数据
//                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//                
//            }else{
//                UMSocialLogInfo(@"response data is %@",data);
//            }
//        }
//        [self alertWithError:error];
//    }];
//}

/*
 - (void)shareLocalVedioToPlatformType:(UMSocialPlatformType)platformType
 {
 //创建分享消息对象
 UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
 
 NSString* thumbURL =  UMS_THUMB_IMAGE;
 UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:UMS_Title descr:UMS_Text thumImage:thumbURL];
 //设置视频网页播放地址
 //shareObject.videoUrl = @"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html";
 
 NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"videoviewdemo" withExtension:@"mp4"];
 NSData* videoData = [[NSData alloc] initWithContentsOfURL:bundleURL];
 shareObject.videoData = videoData;
 
 //分享消息对象设置分享内容对象
 messageObject.shareObject = shareObject;
 
 //调用分享接口
 [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
 if (error) {
 UMSocialLogInfo(@"************Share fail with error %@*********",error);
 }else{
 if ([data isKindOfClass:[UMSocialShareResponse class]]) {
 UMSocialShareResponse *resp = data;
 //分享结果消息
 UMSocialLogInfo(@"response message is %@",resp.message);
 //第三方原始返回的数据
 UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
 
 }else{
 UMSocialLogInfo(@"response data is %@",data);
 }
 }
 [self alertWithError:error];
 }];
 }
 */

- (void)shareEmoticonToPlatformType:(UMSocialPlatformType)platformType{
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareEmotionObject *shareObject = [UMShareEmotionObject shareObjectWithTitle:UMS_Title descr:UMS_Text thumImage:thumbURL];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res6"
                                                         ofType:@"gif"];
    NSData *emoticonData = [NSData dataWithContentsOfFile:filePath];
    shareObject.emotionData = emoticonData;
    
    messageObject.shareObject = shareObject;
    
    //#ifdef UM_Swift
    //                   [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
    //#else
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        //#endif
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

- (void)shareFileToPlatformType:(UMSocialPlatformType)platformType
{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareFileObject *shareObject = [UMShareFileObject shareObjectWithTitle:UMS_Title descr:UMS_Text thumImage:thumbURL];
    
    
    NSString *kFileExtension = @"txt";
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"umengFile"
                                                         ofType:kFileExtension];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    shareObject.fileData = fileData;
    shareObject.fileExtension = kFileExtension;
    
    messageObject.shareObject = shareObject;
    
    //#ifdef UM_Swift
    //    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
    //#else
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        //#endif
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
    
}

- (void)setPinterstInfo:(UMSocialMessageObject *)messageObj
{
    messageObj.moreInfo = @{@"source_url": @"http://www.umeng.com",
                            @"app_name": @"U-Share",
                            @"suggested_board_name": @"UShareProduce",
                            @"description": @"U-Share: best social bridge"};
}


- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share succeed"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}




//-(void)setupWebViewVc{
//
//    _webVc = [[WebViewController alloc]init];
//    _webVc.h5Url = @"http://voice.i-top.cn/www/h5/weiwang/04.christmas/index.html?ActivityCategory=1&id=126&medium_id=126&from=groupmessage";
//    _webVc.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeigh);
//    [self.view addSubview:_webVc.view];
//}

//- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    
//    //创建网页内容对象
//    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
//    //设置网页地址
//    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
//    
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//    
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        if (error) {
//            UMSocialLogInfo(@"************Share fail with error %@*********",error);
//        }else{
//            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                UMSocialShareResponse *resp = data;
//                //分享结果消息
//                UMSocialLogInfo(@"response message is %@",resp.message);
//                //第三方原始返回的数据
//                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//                
//            }else{
//                UMSocialLogInfo(@"response data is %@",data);
//            }
//        }
//    }];
//}

#pragma mark - UMSocialShareMenuViewDelegate
//- (void)UMSocialShareMenuViewDidAppear{
//
//    NSLog(@"UMSocialShareMenuViewDidAppear");
//}
//- (void)UMSocialShareMenuViewDidDisappear{
//
//    NSLog(@"UMSocialShareMenuViewDidDisappear");
//}


                         @end
