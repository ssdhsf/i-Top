//
//  HotComments.h
//  itop
//
//  Created by huangli on 2018/1/31.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HotComments : JSONModel

@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*user_head_img;
@property (nonatomic, strong) NSString <Optional>*user_name;
@property (nonatomic, strong) NSString <Optional>*content;
@property (nonatomic, strong) NSString <Optional>*parent_id;
@property (nonatomic, strong) NSString <Optional>*create_datetime;
@property (nonatomic, strong) NSString <Optional>*replyString;

//{
//    "id": 0,
//    "user_head_img": "string",
//    "user_name": "string",
//    "content": "string",
//    "parent_id": 0,
//    "create_datetime": "2018-01-27T03:16:31.203Z"
@end
