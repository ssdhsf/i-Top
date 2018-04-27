//
//  CustomRequirementsDetailTabelViewController.h
//  itop
//
//  Created by huangli on 2018/4/20.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseTableViewController.h"

@protocol CustomRequirementsDetailViewControllerDelegate<NSObject>

@optional

- (void)customRequirementsDetailViewControllerTableViewDidScroll:(CGFloat)scrollY;

@end

@interface CustomRequirementsDetailTabelViewController : BaseTableViewController
/**代理*/
@property(nonatomic,weak)id<CustomRequirementsDetailViewControllerDelegate> delegate;
@property(strong,nonatomic)NSArray *array;


@end
