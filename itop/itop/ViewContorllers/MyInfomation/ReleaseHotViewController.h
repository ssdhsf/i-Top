//
//  ReleaseHotViewController.h
//  itop
//
//  Created by huangli on 2018/3/16.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SubmitBackBolck)(NSInteger submitType);

@interface ReleaseHotViewController : BaseViewController

@property (copy, nonatomic)SubmitBackBolck submitBack;

@end
