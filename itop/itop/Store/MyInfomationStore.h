//
//  MyInfomationStore.h
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyInfomationStore : NSObject

+ (instancetype)shearMyInfomationStore;

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu;


@end
