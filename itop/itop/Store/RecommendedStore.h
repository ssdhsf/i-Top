//
//  RecommendedStore.h
//  itop
//
//  Created by huangli on 2018/1/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendedStore : NSObject

+ (instancetype)shearRecommendedStore;

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu;

@end
