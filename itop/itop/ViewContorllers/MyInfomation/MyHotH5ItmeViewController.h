//
//  MyHotH5ItmeViewController.h
//  itop
//
//  Created by huangli on 2018/3/15.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseCollectionViewController.h"

typedef void(^PushMyHotH5Control)(NSString *hotDetails_id);

@interface MyHotH5ItmeViewController : BaseCollectionViewController

@property (nonatomic ,copy)PushMyHotH5Control pushMyHotH5Control;
@property (nonatomic, assign)ItemType itemType;
@property (nonatomic, assign) GetArticleListType getArticleListType;

@end
