//
//  RecommendedStore.m
//  itop
//
//  Created by huangli on 2018/1/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "RecommendedStore.h"

@implementation RecommendedStore


+ (instancetype)shearRecommendedStore{
    
    static RecommendedStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[RecommendedStore alloc]init];
    });
    return store;
}

//- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu{
//    
//    NSMutableArray *sectionArray = [NSMutableArray array];
//    for (int i = 0 ; i<5; i++) {
//        
//        Recommended *recommended = [[Recommended alloc]init];
//        recommended.title = [NSString stringWithFormat:@"我的作品"];
//        recommended.imageUrl = [NSString stringWithFormat:@"h5"];
//        recommended.time = [NSString stringWithFormat:@"12小时前"];
//        recommended.good = [NSString stringWithFormat:@"12345"];
//        recommended.comments = [NSString stringWithFormat:@"12345"];
//        recommended.browse = [NSString stringWithFormat:@"12345"];
//        [sectionArray addObject:recommended];
//
//    }
//    
//    return sectionArray;
//}


@end
