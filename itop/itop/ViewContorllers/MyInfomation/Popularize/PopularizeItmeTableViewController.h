//
//  PopularizeItmeTableViewController.h
//  itop
//
//  Created by huangli on 2018/3/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseTableViewController.h"

@protocol UpdateFrameDelegate <NSObject>

-(void)updateScrollerViewFrameWithTableViewContentOffset:(CGFloat)contentOffsetY;

@end

@interface PopularizeItmeTableViewController : BaseTableViewController

@property (nonatomic, assign)OrderStatusType orderStatus;
@property (nonatomic, assign) id <UpdateFrameDelegate> delegate;

@end
