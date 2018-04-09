//
//  UIButton+Timer.m
//  itop
//
//  Created by huangli on 2018/4/4.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "UIButton+Timer.h"

@implementation UIButton (Timer)


- (void)scheduledGCDTimer
{
    [self cancleGCDTimer];
    __block int timeLeave = kTimeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [UserManager shareUserManager].timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer([UserManager shareUserManager].timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    __typeof (self) __weak weakSelf = self;
    dispatch_source_set_event_handler([UserManager shareUserManager].timer, ^{
        if(timeLeave <= 0){ //倒计时结束，关闭
            dispatch_source_cancel([UserManager shareUserManager].timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }
        else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf setTitle:[NSString stringWithFormat:@"%ds后重发",timeLeave] forState:UIControlStateNormal];
                
            });
            [UserManager shareUserManager].timers = timeLeave;
            --timeLeave;
        }
    });
    dispatch_resume([UserManager shareUserManager].timer);
}

- (void)cancleGCDTimer{
    
    if ([UserManager shareUserManager].timer) {
        dispatch_source_cancel([UserManager shareUserManager].timer);
        [UserManager shareUserManager].timer = nil;
    }
}

@end
