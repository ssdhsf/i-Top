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
- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu{
    NSMutableArray *sectionArray = [NSMutableArray array];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"张三" content:@""]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"留资时间" content:@"2018-01-22 12:12"]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"作品来源" content:@"双十一狂欢邀请函"]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"电话" content:@"1888888888"]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"邮箱" content:@"346232424@qq.com"]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"地址" content:@"广州市天河区中石化大厦45号"]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"留言" content:@"迄今为止已经连续发表50于篇第一作者论文"]];
    
    return sectionArray;
}

-(LeaveDetail *)setupLeaveDetailWithLeaveDetailTitle:(NSString *)title content:(NSString *)content{
    
    LeaveDetail *leave = [[LeaveDetail alloc]init];
    leave.title = title;
    leave.content = content;
    
    return leave;
}

@end
