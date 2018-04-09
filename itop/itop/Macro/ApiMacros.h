//
//  ApiMacros.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#ifndef ApiMacros_h
#define ApiMacros_h

// API请求类型
#define API_REQUEST_TYPE_GET    @"GET"
#define API_REQUEST_TYPE_POST   @"POST"
#define API_REQUEST_TYPE_PUT    @"PUT"
#define API_REQUEST_TYPE_DELETE @"DELETE"
#define API_REQUEST_TYPE_PATCH  @"PATCH"

/**
 *    接口返回码
 */
// 调用成功的返回码
#define SUCCESS_RESULT 200

// 微信登陆成功的返回码
#define WECHTLOGINSUCCESS_RESULT 201
//错误编码
#define ERROR_CODE @"error_code"

// koocie失效
#define Notification_LogoutView @"LogoutView"
#define Notification_AutoLogin  @"AutoLogin"



#endif /* ApiMacros_h */
