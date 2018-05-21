//
//  EditChannelListViewController.h
//  itop
//
//  Created by huangli on 2018/5/4.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseTableViewController.h"

@interface EditChannelListViewController : BaseTableViewController

@property (copy, nonatomic) void(^editChannelListBlock )(id array);

@end
