//
//  SigningStateViewController.h
//  itop
//
//  Created by huangli on 2018/2/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseViewController.h"
#import "SigningState.h"

typedef NS_ENUM(NSInteger, ShowSigningStateViewType) {  //展示视图类型
    ShowSigningStateViewTypeRequest = 0, // 网络获取审核状态
    ShowSigningStateViewTypeNext = 1,//提交的下一步
};

@interface SigningStateViewController : BaseViewController

@property (nonatomic, assign)ShowSigningStateViewType showView_type;
@property (nonatomic, assign)SigningType signingType;
@property (nonatomic, strong)SigningState *signingState;

@end
