//
//  AppDelegate+WeChat.m
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "AppDelegate+WeChat.h"

@implementation AppDelegate (WeChat)

- (void)setupWeChat {
    
    [WXApi registerApp: WECHAT_APP_ID];
    
    //向微信注册支持的文件类型
//    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
//    
//    [WXApi registerAppSupportContentFlag:typeFlag];
//    NSString *appId = CONFIG_DICTIONARY[@"WeChat"][SERVER_ENVIRONMENT][@"appId"];
//    [WXApi registerApp:appId];
}


// onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返
//回。在调用sendRsp返回时，会切回到微信终端程序界面。
-(void) onReq:(BaseReq*)req{
    
    NSLog(@"dfdf");
}

//如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终
//端程序界面。
-(void) onResp:(BaseResp*)resp{
    
}

//-(BOOL) sendReq:(BaseReq*)req{
//    
//}


@end
