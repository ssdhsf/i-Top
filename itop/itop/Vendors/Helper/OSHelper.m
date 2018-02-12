//
//  OSHelper.m
//  xixun
//
//  Created by huangli on 2017/1/4.
//  Copyright © 2017年 Vanber. All rights reserved.
//

#import "OSHelper.h"
#import "KeychainItemWrapper.h"

@implementation OSHelper


+ (NSString *)appName{
    NSDictionary * dic = [[NSBundle mainBundle] infoDictionary];
    return [dic objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)appVersion{
    NSDictionary * dic = [[NSBundle mainBundle] infoDictionary];
    return [dic objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildVersion{
    NSDictionary * dic = [[NSBundle mainBundle] infoDictionary];
    return [dic objectForKey:@"CFBundleVersion"];
}

+ (NSString *)gen_uuid {
    CFUUIDRef uuid_ref = CFUUIDCreate(nil);
    CFStringRef uuid_string_ref = CFUUIDCreateString(nil, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)(uuid_string_ref)];
    CFRelease(uuid_string_ref);
    return uuid;
}

+ (NSString *)bundleSeedIDTest {
    
    NSDictionary *query = [NSDictionary
                           dictionaryWithObjectsAndKeys:(__bridge id)(kSecClassGenericPassword),
                           kSecClass, @"bundleSeedID", kSecAttrAccount,
                           @"", kSecAttrService, (id)kCFBooleanTrue,
                           kSecReturnAttributes, nil];
    CFDictionaryRef result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query,
                                          (CFTypeRef *)&result);
    if (status == errSecItemNotFound)
        status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status != errSecSuccess)
        return nil;
    NSString *accessGroup = [(__bridge NSDictionary *)result
                             objectForKey:(__bridge id)(kSecAttrAccessGroup)];
    NSArray *components = [accessGroup componentsSeparatedByString:@"."];
    NSString *bundleSeedID = [[components objectEnumerator] nextObject];
    CFRelease(result);
    return bundleSeedID;
}

+ (NSString *)getKeyChainValue {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Entitlements" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *array = [data valueForKey:@"keychain-access-groups"];
    NSString *accessGroup = array[0];
    KeychainItemWrapper *keyChainItem = [[KeychainItemWrapper alloc]
                                         initWithIdentifier:@"TestUUID"
                                         accessGroup:accessGroup];
    return [keyChainItem objectForKey:(__bridge id)kSecValueData];
}

@end
