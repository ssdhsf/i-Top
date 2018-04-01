//
//  RecommendedViewController.h
//  itop
//
//  Created by huangli on 2018/1/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseTableViewController.h"

@class HotDetailsViewController;

typedef void(^PushControl)(H5List *hotDetails);

@interface RecommendedViewController : BaseTableViewController

@property (nonatomic ,strong)NSString *itmeType;
@property (nonatomic ,strong)NSString *searchKey;
@property (nonatomic, assign) GetArticleListType getArticleListType;
@property (nonatomic ,copy)PushControl pushControl;

@end
