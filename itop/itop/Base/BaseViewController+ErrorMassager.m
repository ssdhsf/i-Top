//
//  BaseViewController+ErrorMassager.m
//  xixun
//
//  Created by huangli on 2017/1/3.
//  Copyright © 2017年 Vanber. All rights reserved.
//

#import "BaseViewController+ErrorMassager.h"

@implementation BaseViewController (ErrorMassager)

- (void)showToastWithError:(NSError *)error{
    [[Global sharedSingleton]showToastInCenter:self.view withError:error];
}

- (void)showToastWithMessage:(NSString *)message{
    [[Global sharedSingleton]showToastInCenter:self.view withMessage:message];
}

@end
