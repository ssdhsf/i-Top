//
//  MyWorksStore.m
//  itop
//
//  Created by huangli on 2018/1/31.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MyWorksStore.h"

@implementation MyWorksStore

+ (instancetype)shearMyWorksStore{
    
    static MyWorksStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[MyWorksStore alloc]init];
    });
    return store;
}

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu{
    
    NSMutableArray *sectionArray = [NSMutableArray array];
    for (NSDictionary *dic in menu) {
        
            H5List *h5Model = [[H5List alloc]initWithDictionary:dic error:nil];
//            h5Model.h5Title = [NSString stringWithFormat:@"会议邀请函"];
//            h5Model.h5Money = [NSString stringWithFormat:@"￥10"];
//            h5Model.h5ImageUrl = [NSString stringWithFormat:@"h5"];
            [sectionArray addObject:h5Model];

    }
    
#ifdef DEBUG
    // 调试状态, 打开LOG功能
    if (sectionArray.count == 0) {
        for (int i = 0; i < 8; i++) {
            H5List *h5Model = [[H5List alloc]init];
            h5Model.h5Title = [NSString stringWithFormat:@"会议邀请函"];
            h5Model.h5Money = [NSString stringWithFormat:@"￥10"];
            h5Model.h5ImageUrl = [NSString stringWithFormat:@"h5"];
            [sectionArray addObject:h5Model];
        }
    }
    //#define NSLog(...) NSLog(__VA_ARGS__)
#else
    // 发布状态, 关闭LOG功能
//#define
#endif
    return sectionArray;
}


@end
