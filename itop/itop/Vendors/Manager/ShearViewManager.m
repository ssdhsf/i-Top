//
//  ShearViewManager.m
//  itop
//
//  Created by huangli on 2018/3/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ShearViewManager.h"
#import "ShearView.h"
#import "ShearViewController.h"

static NSString* const UMS_Title = @"i-Top";
static NSString* const UMS_Text = @"欢迎使用i-Top";
static NSString* const UMS_THUMB_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
static NSString* const UMS_Web_Desc = @"i-Top最好的自营销平台";
static NSString* const UMS_WebLink = @"http://mobile.umeng.com/social";

@interface ShearViewManager()<UIGestureRecognizerDelegate>{
    
    ShearView *shearView;
    UIView * bgView;
    UMSocialPlatformType platform;
    UMS_SHARE_TYPE _shear_type;
    NSDictionary *platfomrSupportTypeDict;
}

@end

@implementation ShearViewManager

+ (instancetype)sharedShearViewManager{
    
    static ShearViewManager *organization = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken ,^{
        organization  = [[ShearViewManager alloc]init];
    });
    
    return organization;
}

-(ShearInfo *)shearInfoWithProduct:(H5List *)h5{
   
    ShearInfo *sherInfo = [[ShearInfo alloc]init];
    sherInfo.shear_title = h5.share_title;
    sherInfo.shear_webLink = h5.url;
    sherInfo.shear_discrimination = h5.share_description;
    sherInfo.shear_thume_image = h5.cover_img;
    return sherInfo;
}

-(void)setupShearView{
    
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigh)];
    bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBgViewAndPickerView)];
    recognizer.delegate = self;
    [bgView addGestureRecognizer:recognizer];
    shearView = [[[NSBundle mainBundle] loadNibNamed:@"ShearView" owner:nil options:nil] lastObject];
    shearView.frame = CGRectMake(0, ScreenHeigh, ScreenWidth, 300*KadapterH);
   
//    __weak typeof(self) weakSelf = self;
//    shearView.selectShearItme = ^(NSInteger tag){
//
//        if (tag < shearType.count && [weakSelf opinionInstallAppWithTag:tag]) {
//            
//            platform = [shearType[tag] integerValue];
//            [weakSelf shareWithType:UMS_SHARE_TYPE_WEB_LINK];
//        }
//    };
    
    [shearView setupShearItem];
    [self setupPreDefinePlatforms];
//    _shearType = @[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)];
    
    [[UMSocialManager defaultManager] openLog:YES];
    [bgView addSubview:shearView];
}

-(NSArray *)shearType{
    
    return @[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)];
}


-(void)setupPreDefinePlatforms{
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatTimeLine),
                                               @(UMSocialPlatformType_WechatSession),
                                               @(UMSocialPlatformType_Qzone),
                                               @(UMSocialPlatformType_QQ),
                                               @(UMSocialPlatformType_Sina)]];
}

- (void)addShearViewToView:(UIView*)view
                 shearType:(UMS_SHARE_TYPE)shear_type
                completion:(SelectShearItemBlock)completion{
    
    [view.window addSubview:bgView];
    
    _shear_type = shear_type;
    [self editoeViewWithAnimation:YES];
    __weak typeof(self) weakSelf = self;
    shearView.selectShearItme = ^(NSInteger tag){
        
        if (tag < self.shearType.count && [weakSelf opinionInstallAppWithTag:tag]) {
            
            platform = [self.shearType[tag] integerValue];
            completion(tag);
            
//            platform = [shearType[tag] integerValue];
//            [weakSelf shareWithType:UMS_SHARE_TYPE_WEB_LINK];
        }
    };

}

-(void)hiddenBgViewAndPickerView{
    
    [self editoeViewWithAnimation:NO];
}

-(void)editoeViewWithAnimation:(BOOL)animation{
    
    //添加滚动动画
    [UIView animateWithDuration:0.2 animations:^{
        
        if (animation) {
            shearView.frame = CGRectMake(0, ScreenHeigh-245*KadapterH, ScreenWidth, 245*KadapterH);
        }else {
            shearView.frame = CGRectMake(0, ScreenHeigh, ScreenWidth, 300*KadapterH);
        }
        
    } completion:^(BOOL finished) {
        
        bgView.hidden  = !animation;
    }];
}

- (void)shareWithType:(UMS_SHARE_TYPE)type
{
    switch (type) {
        case UMS_SHARE_TYPE_TEXT:
        {
            [self shareTextToPlatformType:platform];
        }
            break;
        case UMS_SHARE_TYPE_IMAGE:
        {
            [self shareImageToPlatformType:platform];
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
            [self shareWebPageToPlatformType:platform parameter:nil];
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
            [self shareEmoticonToPlatformType:platform];
        }
            break;
        case UMS_SHARE_TYPE_FILE:
        {
            [self shareFileToPlatformType:platform];
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
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[[UIManager sharedUIManager] topViewController] completion:^(id data, NSError *error) {
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
                [self editoeViewWithAnimation:NO];
                
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
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[[UIManager sharedUIManager] topViewController] completion:^(id data, NSError *error) {
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
                [self editoeViewWithAnimation:NO];
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType parameter:(ShearInfo *)parameter
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
//    NSString* thumbURL =  parameter.shear_thume_image;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:parameter.shear_title descr:parameter.shear_discrimination thumImage:parameter.shear_thume_image];

    //设置网页地址
    shareObject.webpageUrl = parameter.shear_webLink;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //#ifdef UM_Swift
    //    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
    //#else
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platform messageObject:messageObject currentViewController:[[UIManager sharedUIManager] topViewController] completion:^(id data, NSError *error) {
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
                [self editoeViewWithAnimation:NO];
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

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
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[[UIManager sharedUIManager] topViewController] completion:^(id data, NSError *error) {
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
                [self editoeViewWithAnimation:NO];
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

- (void)shareFileToPlatformType:(UMSocialPlatformType)platformType{
    
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
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[[UIManager sharedUIManager] topViewController] completion:^(id data, NSError *error) {
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
                [self editoeViewWithAnimation:NO];
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


- (void)alertWithError:(NSError *)error{
    
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功"];
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}

-(void)alertOperationWithMessage:(NSString*)message{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [[[UIManager sharedUIManager]topViewController] presentViewController:alertController animated:YES completion:nil];
}

//提示用户为安装的应用
-(BOOL)opinionInstallAppWithTag:(NSInteger)tag{
    
    if (tag == 0 || tag ==1) {
        
        if (![WXApi isWXAppInstalled]) {
            
            [self hiddenBgViewAndPickerView];
            [self alertOperationWithMessage:@"你还没有安装微信，请安装微信"];
            
        }
        return [WXApi isWXAppInstalled];
        
    }else if (tag == 2 || tag == 3){
        
        if (![QQApiInterface isQQInstalled]) {
            
            [self hiddenBgViewAndPickerView];
            [self alertOperationWithMessage:@"你还没有安装QQ，请安装QQ"];
        }
        
        return [QQApiInterface isQQInstalled];
        
    }else if (tag == 4){
        
        if (![WeiboSDK isWeiboAppInstalled]) {
            
            [self hiddenBgViewAndPickerView];
            [self alertOperationWithMessage:@"你还没有安装新浪微博，请安装新浪微博"];
        }
        return [WeiboSDK isWeiboAppInstalled];
        
    } else {
        
        return NO;
    }
}


@end
