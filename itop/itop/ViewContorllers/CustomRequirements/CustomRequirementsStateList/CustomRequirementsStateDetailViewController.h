//
//  CustomRequirementsStateDetailViewController.h
//  itop
//
//  Created by huangli on 2018/4/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseViewController.h"

@interface CustomRequirementsStateDetailViewController : BaseViewController

@property (assign, nonatomic)DemandType demandType;
@property (assign, nonatomic)CustomRequirementsType customRequirementsType;
@property (strong, nonatomic)NSNumber *demand_id;
@property (strong, nonatomic)NSString *message;

@end
