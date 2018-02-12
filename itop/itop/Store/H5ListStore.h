//
//  H5ListStore.h
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface H5ListStore : NSObject

+ (instancetype)shearH5ListStore;

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu;
- (NSMutableArray *)configurationUserProductMenuWithMenu:(NSArray *)menu;

@end
