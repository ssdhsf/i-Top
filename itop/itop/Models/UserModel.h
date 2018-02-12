//
//  User.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "UserInfomation.h"

@interface UserModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*username;
@property (nonatomic, strong) NSString <Optional>*userType;
@property (nonatomic, strong) NSString <Optional>*user_type;
@property (nonatomic, strong) NSString <Optional>*other_info;
@property (nonatomic, strong) NSString <Optional>*name;
@property (nonatomic, strong) NSString <Optional>*login_count;
@property (nonatomic, strong) NSString <Optional>*last_login_datetime;
@property (nonatomic, strong) NSString <Optional>*channelList;
@property (nonatomic, strong) UserInfomation <UserInfomation,Optional>*user_info;

//channelList = "<null>";
//"last_login_datetime" = "2018-02-01 16:05:46";
//"login_count" = 7;
//name = "\U666e\U901a\U7528\U6237156987";
//"other_info" = "<null>";
//"user_info" =     {
//    age = 0;
//    city = "";
//    "create_datetime" = "2018-01-16 18:05:22";
//    "head_img" = "";
//    "ibean_count" = 0;
//    id = 8;
//    nickname = "\U666e\U901a\U7528\U6237156987";
//    price = 0;
//    province = "";
//    sex = 0;
//    "total_reward_price" = 0;
//    "update_datetime" = "2018-01-16 18:05:22";
//    "user_id" = 27;
//};
//"user_type" = 0;
//username = 18826468690;
//username = 18826468690;
@end
