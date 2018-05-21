//
//  Infomation.h
//  itop
//
//  Created by huangli on 2018/2/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlertView.h"

@interface Infomation : JSONModel

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *content;
@property(nonatomic) BOOL isEdit; //是否可以编辑
@property(nonatomic ,strong) NSString *sendKey; //提交的Key
@property(nonatomic ,assign) PickViewType pickViewType; //选择类型

@end
