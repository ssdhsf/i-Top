//
//  H5ListStore.m
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "H5ListStore.h"

@implementation H5ListStore

+ (instancetype)shearH5ListStore{
    
    static H5ListStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[H5ListStore alloc]init];
    });
    return store;
}

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu{
    
     NSMutableArray *sectionArray = [NSMutableArray array];
    for (NSDictionary *dic in menu) {
        
        H5List *h5Model = [[H5List alloc]initWithDictionary:dic error:nil];
        [sectionArray addObject:h5Model];
    }
    
    
//   
//    for (int i = 0 ; i<9; i++) {
//        
////        NSMutableArray *itmeArray = [NSMutableArray array];
////        for (int i = 0 ; i<3; i++) {
//        
//            H5List *h5Model = [[H5List alloc]init];
//            h5Model.h5Title = [NSString stringWithFormat:@"会议邀请函"];
//            h5Model.h5Money = [NSString stringWithFormat:@"$10"];
//            h5Model.h5ImageUrl = [NSString stringWithFormat:@"h5"];
////            [itmeArray addObject:h5Model];
////        }
////        
//        [sectionArray addObject:h5Model];
//    }
    
    return sectionArray;
}

- (NSMutableArray *)configurationUserProductMenuWithMenu:(NSArray *)menu{
    
    NSMutableArray *sectionArray = [NSMutableArray array];
//    for (NSDictionary *dic in menu) {
//        
//        H5List *h5Model = [[H5List alloc]initWithDictionary:dic error:nil];
//        [sectionArray addObject:h5Model];
//    }
    
    
    
        for (int i = 0 ; i<9; i++) {
    
    //        NSMutableArray *itmeArray = [NSMutableArray array];
    //        for (int i = 0 ; i<3; i++) {
    
                H5List *h5Model = [[H5List alloc]init];
                h5Model.h5Title = [NSString stringWithFormat:@"会议邀请函"];
                h5Model.h5Money = [NSString stringWithFormat:@"$10"];
                h5Model.h5ImageUrl = [NSString stringWithFormat:@"h5"];
    //            [itmeArray addObject:h5Model];
    //        }
    //
            [sectionArray addObject:h5Model];
        }
    
    return sectionArray;
}


@end
