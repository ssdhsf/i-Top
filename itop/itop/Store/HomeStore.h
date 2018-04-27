//
//  HomeStore.h
//  itop
//
//  Created by huangli on 2018/1/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const Type_Home = @"Home";
static NSString *const Type_Custrom = @"Custrom";
static NSString *const Type_H5 = @"H5";
static NSString *const Type_Designer = @"Designer";
static NSString *const Type_SearchHot = @"SearchHot";

@interface HomeStore : NSObject

+ (instancetype)shearHomeStore;

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu;

- (NSMutableArray *)requestConfigurationMenuWithMenu:(NSArray *)menu;
- (NSMutableArray *)configurationBanner:(NSArray *)banner;//轮播图
- (NSMutableArray *)configurationTag:(NSArray *)tag;//轮播图

- (NSMutableArray *)configurationTagNameWithMenu:(NSArray *)menu  tagType:(NSString *)tagType;//设置标签name
- (NSMutableArray *)configurationTagWithMenu:(NSArray *)menu  tagType:(NSString *)tagType; //设置标签模型
- (NSMutableArray *)configurationTagNameWithTag:(NSString *)tag;//根据H5类型show标签title

-(NSMutableArray *)configurationAllTagWithMenu:(NSArray *)menu;//解析全部tag模型
@end
