//
//  LeaveDetailStore.m
//  itop
//
//  Created by huangli on 2018/2/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "LeaveDetailStore.h"

@implementation LeaveDetailStore


+ (instancetype)shearLeaveDetailStore{
    
    static LeaveDetailStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[LeaveDetailStore alloc]init];
    });
    return store;
}

- (NSMutableArray *)configurationMenuWithMenu:(Leave *)menu{
    NSMutableArray *sectionArray = [NSMutableArray array];
    
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:menu.json_result.name content:@""]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"留资时间" content:menu.create_datetime]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"作品来源" content:@""]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"电话" content:menu.json_result.phone]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"邮箱" content:menu.json_result.email]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"地址" content:menu.json_result.address]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"留言" content:menu.json_result.content]];
    
    return sectionArray;
}

-(Infomation *)setupLeaveDetailWithLeaveDetailTitle:(NSString *)title content:(NSString *)content{
    
    Infomation *leave = [[Infomation alloc]init];
    leave.title = title;
    leave.content = content;
    
    return leave;
}

@end
