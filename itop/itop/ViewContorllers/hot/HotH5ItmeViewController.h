//
//  HotH5ItmeViewController.h
//  itop
//
//  Created by huangli on 2018/1/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseCollectionViewController.h"

typedef void(^PushH5DetailControl)(H5List *h5);

@interface HotH5ItmeViewController : BaseCollectionViewController

@property (nonatomic, assign)ItemType itemType;
@property (nonatomic, assign) GetArticleListType getArticleListType;
@property (nonatomic ,copy)PushH5DetailControl pushH5DetailControl;

@end
