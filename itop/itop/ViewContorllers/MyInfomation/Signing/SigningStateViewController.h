//
//  SigningStateViewController.h
//  itop
//
//  Created by huangli on 2018/2/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, ShowViewType) {  //展示视图类型
    ShowViewTypeRequest = 0, // 网络获取审核状态
    ShowViewTypeNext = 1,//提交的下一步
};

@interface SigningStateViewController : BaseViewController


@property (nonatomic, assign)ShowViewType showView_type;

@end
