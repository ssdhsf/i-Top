//
//  ThemeCustomStore.h
//  itop
//
//  Created by huangli on 2018/1/19.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeCustomStore : NSObject

+ (instancetype)shearThemeCustomStore;

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu;


@end
