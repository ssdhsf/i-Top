//
//  DirectionalDemandReleaseViewController.h
//  itop
//
//  Created by huangli on 2018/4/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//


#import "BaseTableViewController.h"

@interface DirectionalDemandReleaseViewController : BaseTableViewController

@property (assign, nonatomic)DemandType demandType;
@property (assign, nonatomic)BOOL isEdit;//重新编辑
@property (strong, nonatomic)NSNumber *demand_id;

@end
