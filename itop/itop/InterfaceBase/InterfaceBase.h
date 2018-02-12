//
//  InterfaceBase.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiBase.h"

//功能级成功
typedef void (^netCompletion_t)(NSURLSessionDataTask *operation, id responseObject);
//功能级失败
typedef void (^netFailure_t)(NSURLSessionDataTask *operation, NSError *error);
//业务级成功
typedef void (^completion_t)(id resultObject, NSInteger code, NSString *description);
typedef void (^error_t)(NSError *error);
//业务级失败
typedef void (^failure_t)(NSError *error);

@interface InterfaceBase : ApiBase

+(instancetype)sheardInterfaceBase;

/**
 *    API请求统一入口
 *
 *    @param api         请求接口
 *    @param requestType 请求类型
 *    @param parameters  请求参数
 *    @param completion  请求成功回调
 *    @param error       请求失败回调
 */
//- (void)requestDataWithApi:(NSString *)api
//            andRequestType:(NSString *)requestType
//             andParameters:(NSDictionary *)parameters
//                completion:(completion_t)completion
//                     error:(error_t)error;

/**
 *    API请求统一入口
 *
 *    @param api         请求接口
 *    @param parameters  请求参数
 *    @param completion  请求成功回调
 *    @param failure       请求失败回调
 */
- (void)requestDataWithApi:(NSString *)api
                parameters:(NSDictionary *)parameters
                completion:(void (^)(id object))completion
                   failure:(void (^)(NSError * error))failure;

@end
