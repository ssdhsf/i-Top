//
//  SetupHomeStore.m
//  itop
//
//  Created by huangli on 2018/3/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SetupHomeStore.h"

@implementation SetupHomeStore

+ (instancetype)shearSetupHomeStore{
    
    static SetupHomeStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[SetupHomeStore alloc]init];
    });
    return store;
}

-(NSMutableArray *)configurationSetupMenu{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"账号与安全" imageName:nil vcName:@"SecurityViewController"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"数据通知与设置" imageName:nil vcName:@"SetupPushViewController"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"关于i-Top" imageName:nil vcName:@"AboutItopViewController"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"商务合作" imageName:nil vcName:@"AboutItopViewController"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"联系客服" imageName:nil vcName:@"CustomerServiceViewController"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"缓存清理" imageName:nil vcName:@""]];
    return array;
}

-(MyInfomation *)setupMyInfomationWithLeaveDetailTitle:(NSString *)title imageName:(NSString *)imageName vcName:(NSString *)vcName{
    
    MyInfomation *info = [[MyInfomation alloc]init];
    info.myInfoTitle = title;
    info.myInfoImageUrl = imageName;
    info.nextVcName = vcName;
    
    return info;
}

@end
