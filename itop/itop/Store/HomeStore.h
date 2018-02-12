//
//  HomeStore.h
//  itop
//
//  Created by huangli on 2018/1/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const Type_Home = @"Home";
static NSString *const Type_H5 = @"H5";
static NSString *const Type_Designer = @"Designer";

@interface HomeStore : NSObject

+ (instancetype)shearHomeStore;

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu;

- (NSMutableArray *)requestConfigurationMenuWithMenu:(NSArray *)menu;
- (NSMutableArray *)configurationBanner:(NSArray *)banner;//轮播图
- (NSMutableArray *)configurationTag:(NSArray *)tag;//轮播图
@end
