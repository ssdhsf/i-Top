//
//  InterfaceBase.m
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "InterfaceBase.h"

@implementation InterfaceBase


+(instancetype)sheardInterfaceBase{

    static InterfaceBase *interface = nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        interface = [[InterfaceBase alloc]init];
    });
    
    return  interface;
    
}

- (NSString *)urlWithPath:(NSString *)path {
    NSURL *interfaceURL = [[NSURL alloc] initWithScheme:[ApiBase sharedSingleton].protocol
                                                   host:[ApiBase sharedSingleton].host
                                                   path:path];
    return [interfaceURL absoluteString];
}

+ (AFSecurityPolicy*)customSecurityPolicy {
    // 先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    // validatesDomainName 是否需要验证域名，默认为YES；
    // 假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    // 置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    // 如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [NSSet setWithObjects:certData, nil];
    
    return securityPolicy;
}

- (void)requestDataWithApi:(NSString *)api
            andRequestType:(NSString *)requestType
             andParameters:(NSDictionary *)parameters
                completion:(completion_t)completion
                     failure:(failure_t)failure
{
    
    NSString *url;
    
    if ([api containsString:WX_BASE_URL]) {
        
        url = api;
    } else {
        url = [self urlWithPath:api];
    }
//    if ([GVUserDefaults standardUserDefaults].userToken) {
//        url = [NSString stringWithFormat:@"%@?token=%@", [self urlWithPath:api], [GVUserDefaults standardUserDefaults].userToken];
//    }
    NSLog(@"\n [AFNetworking]请求参数列表: %@\n\n 接口名: %@\n\n", parameters, url);
    
    netCompletion_t netCompletion = ^(NSURLSessionDataTask *operation, id responseObject) {
        NSLog(@"\n [AFNetworking]请求成功: %@\n\n%@", responseObject,operation.currentRequest);
        NSDictionary *responseDict = responseObject;
        if (responseDict) {
            if (completion) {
                
                NSString *cacheCookie = [[Global sharedSingleton]getUserDefaultsWithKey:UD_CACHE_COOKIE];
                
                if (cacheCookie == nil) {
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                    NSLog(@"=====currentRequest:%@ ----------task.response:%@",operation.currentRequest.allHTTPHeaderFields, response.allHeaderFields[@"Set-Cookie"]);
                    NSString *cookie = response.allHeaderFields[@"Set-Cookie"];
                    [[ApiBase sharedSingleton].sharedManager.requestSerializer setValue:cacheCookie forHTTPHeaderField:@"Cookie"];
                    [[Global sharedSingleton] setUserDefaultsWithKey:UD_CACHE_COOKIE andValue:cookie];
                }
                
                NSDictionary *resultObject = [responseDict objectForKey:@"data"];
                if (resultObject == nil) {
                    resultObject = responseDict;
                }
                NSInteger code = [[responseDict objectForKey:@"code"] integerValue];
                NSString *message = [responseDict objectForKey:@"message"];
                
                NSLog(@"\n [AFNetworking]请求成功描述: %@\n\n", message);
                completion(resultObject, code, message);

            }
        }
    };
    
    netFailure_t netFailure = ^(NSURLSessionDataTask * _Nullable task, NSError *err) {
        NSLog(@"\n [AFNetworking]请求失败: %@\n\n", err);
        NSLog(@"\n [AFNetworking]请求失败描述: %@\n\n", err.domain);
        if (failure) {
            failure(err);
        }
    };
    
    AFHTTPSessionManager *manager = [ApiBase sharedSingleton].sharedManager;
    NSString *cacheCookie = [[Global sharedSingleton]getUserDefaultsWithKey:UD_CACHE_COOKIE];
    
    if (cacheCookie != nil) {
       
        [manager.requestSerializer setValue:cacheCookie forHTTPHeaderField:@"Cookie"];
    }

    /*
     * 使用非认证的SSL证书时，需要添加此处理
     *
    if ([[ApiBase sharedSingleton].protocol isEqualToString:@"https"]) {
        [manager setSecurityPolicy:[self.class customSecurityPolicy]];
    }
     */
    
    if ([requestType isEqualToString:API_REQUEST_TYPE_GET]) {
        [manager GET:url parameters:parameters progress:nil success:netCompletion failure:netFailure];
    } else if ([requestType isEqualToString:API_REQUEST_TYPE_POST]) {
        [manager POST:url parameters:parameters progress:nil success:netCompletion failure:netFailure];
    } else if ([requestType isEqualToString:API_REQUEST_TYPE_PUT]) {
        [manager PUT:url parameters:parameters success:netCompletion failure:netFailure];
    } else if ([requestType isEqualToString:API_REQUEST_TYPE_DELETE]) {
        [manager DELETE:url parameters:parameters success:netCompletion failure:netFailure];
    } else if ([requestType isEqualToString:API_REQUEST_TYPE_PATCH]) {
        [manager PATCH:url parameters:parameters success:netCompletion failure:netFailure];
    }
}


- (void)requestDataWithApi:(NSString *)api
                parameters:(NSDictionary *)parameters
                completion:(void (^)(id object))completion
                   failure:(void (^)(NSError * error))failure{
    
    completion_t _completion = ^(id resultObject, NSInteger code, NSString *description) {
        if (code == SUCCESS_RESULT || code == WECHTLOGINSUCCESS_RESULT) {
 
            completion(resultObject);
            
        } else {
            //
            completion([NSError errorWithDomain:description code:code userInfo:nil]);
        }
    };
    
    failure_t _failure = ^(NSError *error) {

        completion(error);
        NSLog(@"%ld",error.code);
        if (error.code == -1011) {
            
            NSDictionary *dic = @{ERROR_CODE :@(error.code)};
            [[NSNotificationCenter defaultCenter]postNotificationName:Notification_LogoutView object:self userInfo:dic];
        }

    };
    
    [self requestDataWithApi:api andRequestType:@"POST" andParameters:parameters completion:_completion failure:_failure];
    
}

- (void)requestWeChatDataWithApi:(NSString *)api
                      parameters:(NSDictionary *)parameters
                      completion:(void (^)(id object))completion
                         failure:(void (^)(NSError * error))failure{
    
    completion_t _completion = ^(id resultObject, NSInteger code, NSString *description) {
        if (code == 0) {
            
            completion(resultObject);
            
        } else {
            //
            completion([NSError errorWithDomain:description code:code userInfo:nil]);
        }
    };
    
    failure_t _failure = ^(NSError *error) {
        
        completion(error);
        NSLog(@"%ld",error.code);
        if (error.code == -1011) {
            
            NSDictionary *dic = @{ERROR_CODE :@(error.code)};
            [[NSNotificationCenter defaultCenter]postNotificationName:Notification_LogoutView object:self userInfo:dic];
        }
        
    };
    
    [self requestDataWithApi:api andRequestType:API_REQUEST_TYPE_GET andParameters:parameters completion:_completion failure:_failure];
    
}


@end
