//
//  LeaveDetail.h
//  itop
//
//  Created by huangli on 2018/2/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LeaveDetail : JSONModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

@end
