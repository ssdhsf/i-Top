//
//  Leave.h
//  itop
//
//  Created by huangli on 2018/2/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "LeaveDetail.h"
@interface Leave : JSONModel

@property (nonatomic, strong) NSString <Optional>*name;
@property (nonatomic, strong) NSString <Optional>*time;
@property (nonatomic, strong) NSString <Optional>*create_datetime;
@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) LeaveDetail <Optional>*json_result;
@property (nonatomic, strong) NSString <Optional>*product_id;
@property (nonatomic, strong) NSNumber <Optional>*select;

//{
//    "create_datetime" = "2018-04-08 16:38:37";
//    id = 59;
//    "json_result" = "{\\\"name\\\":\\\"test2445555\\\",\\\"phone\\\":\\\"312313\\\",\\\"email\\\":\\\"test@qq.com\\\"}";
//    "product_id" = 285;
//}


@end
