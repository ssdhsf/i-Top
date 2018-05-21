//
//  EditCaseViewController.h
//  itop
//
//  Created by huangli on 2018/5/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseTableViewController.h"

@interface EditCaseViewController : BaseTableViewController

@property (assign, nonatomic)BOOL isEdit;
@property (nonatomic, strong) EditCase *editCase;
@end
