//
//  MyWorksStore.h
//  itop
//
//  Created by huangli on 2018/1/31.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyWorksStore : NSObject

+ (instancetype)shearMyWorksStore;

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu;
- (NSMutableArray *)commentsListDropdownMenuConfigurationMenuWithMenu:(NSArray *)menu;

@end
