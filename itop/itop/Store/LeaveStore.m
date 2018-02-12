//
//  LeaveStore.m
//  itop
//
//  Created by huangli on 2018/2/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "LeaveStore.h"

@implementation LeaveStore

+ (instancetype)shearLeaveStore{
    
    static LeaveStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[LeaveStore alloc]init];
    });
    return store;
}


- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu testString:(NSString *)testString{
    
    NSMutableArray *sectionArray = [NSMutableArray array];
    
#ifdef DEBUG
    // 调试状态, 打开LOG功能
    if (sectionArray.count == 0) {
        for (int i = 0; i < 8; i++) {
            Leave *leave = [[Leave alloc]init];
            leave.name = [NSString stringWithFormat:@"%@%ld",testString,(long)i+1];
            leave.time = [NSString stringWithFormat:@"2108-1-31 12:12"];
            leave.select = NO;
            [sectionArray addObject:leave];
        }
    }
    //#define NSLog(...) NSLog(__VA_ARGS__)
#else
    
    for (NSDictionary *dic in menu) {
        
        Leave *leave = [[Leave alloc]initWithDictionary:dic error:nil];
        [sectionArray addObject:leave];
    }

    // 发布状态, 关闭LOG功能
    //#define
#endif
    return sectionArray;
}


@end
