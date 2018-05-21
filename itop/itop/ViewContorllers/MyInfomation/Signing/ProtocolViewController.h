//
//  ProtocolViewController.h
//  itop
//
//  Created by huangli on 2018/3/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, ProtocolType) { //文章类型
    ProtocolTypeDesginer = 0, //设计师协议
    ProtocolTypeCompany = 1,//企业协议
    ProtocolTypeMarkting, //自营销人协议
    ProtocolTypeCustomRequirements //定制协议
};

@interface ProtocolViewController : BaseViewController

@property (nonatomic, assign)ProtocolType protocolType;

@end
