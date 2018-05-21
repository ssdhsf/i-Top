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
@property (strong, nonatomic)NSNumber *demand_id;

@property (assign, nonatomic)DemandAddType demandAddType;//添加类型
@property (strong, nonatomic)NSNumber *desginer_id;
@property (strong, nonatomic)NSNumber *desginer_product_id;

@end
