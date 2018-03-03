//
//  ApiBase.m
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ApiBase.h"
#import <AFHTTPSessionManager.h>

@implementation ApiBase

static AFHTTPSessionManager *_sharedSessionManager = nil;

+ (instancetype)sharedSingleton {
    static ApiBase *_singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[super allocWithZone:NULL] init];
    });
    return _singleton;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedSingleton];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (NSString *)protocol {
    return CONFIG_DICTIONARY[@"ApiSettings"][SERVER_ENVIRONMENT][@"protocol"];
}

- (NSString *)host {
    return CONFIG_DICTIONARY[@"ApiSettings"][SERVER_ENVIRONMENT][@"host"];
}

- (AFURLSessionManager *)sharedManager {
    if (!_sharedSessionManager) {
        @synchronized (self) {
            if (!_sharedSessionManager) {
                _sharedSessionManager = [AFHTTPSessionManager manager];
                _sharedSessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
                _sharedSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
                // 设置30s超时
                _sharedSessionManager.requestSerializer.timeoutInterval = 30;
                
                AFSecurityPolicy *security = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
                
                [security setValidatesDomainName:NO];
                
                security.allowInvalidCertificates = YES;
                
                _sharedSessionManager.securityPolicy = security;
                _sharedSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
                
            }
        }
    }
    return _sharedSessionManager;
}

@end
