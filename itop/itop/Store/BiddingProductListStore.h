//
//  BiddingProductListStore.h
//  itop
//
//  Created by huangli on 2018/4/27.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BiddingProductListStore : NSObject

+ (instancetype)shearBiddingProductListStore;

- (NSMutableArray *)configurationBiddingProductListWithRequsData:(NSArray *)arr;


@end
