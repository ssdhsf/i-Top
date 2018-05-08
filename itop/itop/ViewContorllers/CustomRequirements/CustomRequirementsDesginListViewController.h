//
//  CustomRequirementsDesginListViewController.h
//  itop
//
//  Created by huangli on 2018/4/23.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseTableViewController.h"

@protocol CustomRequirementsDesginListViewControllerDelegate<NSObject>
@optional

- (void)CustomRequirementsDesginListViewControllerTableViewDidScroll:(CGFloat)scrollY;

@end

@interface CustomRequirementsDesginListViewController : BaseTableViewController

@property(nonatomic,weak)id<CustomRequirementsDesginListViewControllerDelegate> delegate;
//@property(strong,nonatomic)NSArray *array;

@end
