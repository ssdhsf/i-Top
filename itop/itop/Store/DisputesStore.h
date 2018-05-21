//
//  DisputesStore.h
//  itop
//
//  Created by huangli on 2018/5/3.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisputesStore : NSObject

+ (instancetype)shearDisputesStore;

- (NSMutableArray *)configurationDisputesWithRequsData:(NSArray *)arr;

@end
