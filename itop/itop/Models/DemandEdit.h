//
//  DemandEdit.h
//  itop
//
//  Created by huangli on 2018/4/22.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DemandEdit : JSONModel

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *content;
@property(nonatomic ,strong) NSString *sendKey; //提交的Key
@property(nonatomic ,strong) UIImage *inamge; //提交的Key
@property(nonatomic ,assign) EditType editType; //选择类型
@property(nonatomic ,assign) BOOL isMust; //选择类型

@end
