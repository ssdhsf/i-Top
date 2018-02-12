//
//  BaseViewController+ErrorMassager.h
//  xixun
//
//  Created by huangli on 2017/1/3.
//  Copyright © 2017年 Vanber. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (ErrorMassager)

- (void)showToastWithMessage:(NSString *)message;
- (void)showToastWithError:(NSError *)error;

@end
