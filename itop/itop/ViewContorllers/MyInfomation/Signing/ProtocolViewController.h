//
//  ProtocolViewController.h
//  itop
//
//  Created by huangli on 2018/3/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, ProtocolType) { //文章类型
    ProtocolTypeDesginer = 0, //资讯
    ProtocolTypeCompany = 1,//H5List
    ProtocolTypeMarkting//H5视频
};

@interface ProtocolViewController : BaseViewController

@property (nonatomic, assign)ProtocolType protocolType;

@end
