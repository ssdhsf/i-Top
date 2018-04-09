//
//  LoginMannager.h
//  itop
//
//  Created by huangli on 2018/2/1.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginMannager : NSObject

+(instancetype)sheardLoginMannager;

//- (NSDictionary *) parametersToApiWithUserName:(NSString *)userNameStr password:(NSString*)passwordStr;
//登出时清楚数据
- (void)clearLoginUserMassage ;


//返回登录页面
//- (void)presentViewLoginViewController;

@end
