//
//  MyHotDetailViewController.h
//  itop
//
//  Created by huangli on 2018/4/10.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseTableViewController.h"

@interface MyHotDetailViewController : BaseTableViewController

@property (nonatomic ,strong)NSString *hotDetail_id;
@property (nonatomic ,assign)CheckStatusType checkStatusType;
@property (nonatomic ,assign)ItemDetailType itemDetailType;

@end
