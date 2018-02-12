//
//  ApiBase.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;

@interface ApiBase : NSObject <NSCopying>

+ (instancetype)sharedSingleton;

@property (nonatomic, strong) NSString *protocol;
@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong, readonly) AFHTTPSessionManager *sharedManager;

@end
