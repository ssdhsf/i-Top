//
//  LeaveViewController.h
//  itop
//
//  Created by huangli on 2018/2/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseTableViewController.h"

typedef NS_ENUM(NSInteger, GetLeaveListType) { //获取H5List入口
    GetLeaveListTypeMyLeave = 0,
    GetLeaveListTypeProduct = 1, //获取作品H5
    //获取TagH5
};

@interface LeaveViewController : BaseTableViewController

@property (nonatomic,strong)NSString *product_id;
@property (nonatomic,assign)GetLeaveListType getLeaveListType;

@end
