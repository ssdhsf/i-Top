//
//  LeaveViewController.h
//  itop
//
//  Created by huangli on 2018/2/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseTableViewController.h"

@class H5List;
typedef NS_ENUM(NSInteger, GetLeaveListType) { //获取留资入口
    GetLeaveListTypeMyLeave = 0,
    GetLeaveListTypeProduct = 1, //获取作品H5
};

@interface LeaveViewController : BaseTableViewController

//@property (nonatomic,strong)NSString *product_id;
@property (nonatomic,assign)GetLeaveListType getLeaveListType;
@property(nonatomic, strong)H5List *currentProduct; //当前的作品

@end
