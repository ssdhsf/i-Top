//
//  OSHelper.h
//  xixun
//
//  Created by huangli on 2017/1/4.
//  Copyright © 2017年 Vanber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSHelper : NSObject

/*
 * @desc 取得应用名称
 * @return NSString 应用名称
 */
+ (NSString *)appName;

/*
 * @desc 取得应用版本
 * @return NSString 应用版本
 */
+ (NSString *)appVersion;

/*
 * @desc 取得应用build版本
 * @return NSString 应用build版本
 */
+ (NSString *)appBuildVersion;

/*
 * @desc 取得UUID
 * @return NSString UUID
 */
+ (NSString *)gen_uuid;

/**
 * @desc 获取开发者账户的的前缀,存Keychain时要用
 * @return 开发者账户的的前缀
 */
+ (NSString *)bundleSeedIDTest;

/**
 *  获取keychain中uuid
 * @return keychain中uuid
 */
+ (NSString *)getKeyChainValue;


@end
