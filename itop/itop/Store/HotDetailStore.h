//
//  HotDetailStore.h
//  itop
//
//  Created by huangli on 2018/1/31.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotDetailStore : NSObject

+ (instancetype)shearHotDetailStore;

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu;


@end
