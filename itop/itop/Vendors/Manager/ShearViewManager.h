//
//  ShearViewManager.h
//  itop
//
//  Created by huangli on 2018/3/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShearViewManager : NSObject

+ (instancetype)sharedShearViewManager;

- (void)addTimeViewToView:(UIView*)view;
- (void)setupShearView;

@end
