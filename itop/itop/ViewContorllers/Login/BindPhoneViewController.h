//
//  BindPhoneViewController.h
//  itop
//
//  Created by huangli on 2018/3/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseViewController.h"

@interface BindPhoneViewController : BaseViewController

@property (assign, nonatomic)BindPhoneType bindPhoneType;
@property (strong, nonatomic)NSString *oldPhoneCode; //原来的手机号码验证码

@end
