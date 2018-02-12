//
//  StatisticalDataStore.h
//  itop
//
//  Created by huangli on 2018/1/22.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatisticalDataStore : NSObject

+ (instancetype)shearStatisticalDataStore;

- (NSMutableArray *)configurationStatisticalDataWithData:(NSArray *)statisticalData;

@end
