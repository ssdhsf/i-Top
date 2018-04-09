//
//  MarketingStore.h
//  itop
//
//  Created by huangli on 2018/2/28.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarketingStore : NSObject

+ (instancetype)shearMarketingStore;

- (NSMutableArray *)configurationMenuWithShowIndex:(NSInteger )index;


@end
