//
//  LoginMannager.h
//  itop
//
//  Created by huangli on 2018/2/1.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  滚动时间间隔 可以自己修改
 */
static double continueTokenInterval = 10.0f;

@interface LoginMannager : NSObject

+(instancetype)sheardLoginMannager;

//- (NSDictionary *) parametersToApiWithUserName:(NSString *)userNameStr password:(NSString*)passwordStr;
//登出时清楚数据
- (void)clearLoginUserMassage ;

//续登陆
- (void)continueWithToken;

//定时器
-(void)initTimer;
-(void)stopTimer;
//返回登录页面
//- (void)presentViewLoginViewController;

@end
