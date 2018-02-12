//
//  HotDetailsViewController.h
//  itop
//
//  Created by huangli on 2018/1/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseTableViewController.h"

typedef NS_ENUM(NSInteger, ItemDetailType) {
    
    H5ItemDetailType = 0,
    HotItemDetailType = 1,
};

@interface HotDetailsViewController : BaseTableViewController

@property (nonatomic ,strong)NSString *hotDetail_id;
@property (nonatomic ,assign)ItemDetailType itemDetailType;

@end
