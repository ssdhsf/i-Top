//
//  DesignerListViewController.h
//  itop
//
//  Created by huangli on 2018/1/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseCollectionViewController.h"

typedef void(^PushDesignerDetailControl)(NSString *Designer_id);

@interface DesignerListViewController : BaseCollectionViewController

@property (nonatomic ,copy) PushDesignerDetailControl pushDesignerDetailControl;
@property (nonatomic ,assign) DesignerListType designerListType;

@end
