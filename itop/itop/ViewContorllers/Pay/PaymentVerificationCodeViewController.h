//
//  PaymentVerificationCodeViewController.h
//  itop
//
//  Created by huangli on 2018/5/14.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseViewController.h"

@interface PaymentVerificationCodeViewController : BaseViewController

@property (strong, nonatomic)NSNumber *demand_id;
@property (strong, nonatomic)NSString *money;
@property (assign, nonatomic)PayType payType;


@end
