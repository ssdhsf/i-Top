//
//  User.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "UserInfomation.h"
#import "OtherInfo.h"

@interface UserModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*username;
@property (nonatomic, strong) NSString <Optional>*user_type;
@property (nonatomic, strong) OtherInfo <OtherInfo ,Optional>*other_info;
@property (nonatomic, strong) NSString <Optional>*name;
@property (nonatomic, strong) NSString <Optional>*login_count;
@property (nonatomic, strong) NSString <Optional>*token;
@property (nonatomic, strong) NSString <Optional>*last_login_datetime;
@property (nonatomic, strong) NSArray <Optional>*channelList;
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


//{
//    channelList = "<null>";
//    "last_login_datetime" = "2018-02-27 14:23:46";
//    "login_count" = 4;
//    name = "\U666e\U901a\U7528\U6237147465";
//    "other_info" =     {
//        "certificates_type" = 2;
//        "certificates_url" = "http://192.168.7.100:8028/files/img/20180131/201801311104212598.png";
//        "check_status" = 1;
//        city = "\U5e7f\U5dde\U5e02";
//        "create_datetime" = "2018-01-31 11:04:56";
//        "end_datetime" = "2018-01-31 11:04:56";
//        id = 10;
//        name = "\U5e7f\U4e1c\U667a\U5408\U521b\U4eab\U8425\U9500\U7b56\U5212\U6709\U9650\U516c\U53f8";
//        province = "\U5e7f\U4e1c\U7701";
//        "short_name" = "\U667a\U5408\U521b\U4eab";
//        "start_datetime" = "2018-01-31 11:04:56";
//        trade = "\U884c\U4e1a1-\U884c\U4e1a1";
//        "update_datetime" = "2018-02-02 15:39:07";
//        "user_id" = 33;
//        version = 0;
//    };
//    "user_info" =     {
//        age = 0;
//        city = "";
//        "create_datetime" = "2018-01-31 10:53:03";
//        "head_img" = "";
//        "ibean_count" = 0;
//        id = 17;
//        nickname = "\U666e\U901a\U7528\U6237147465";
//        price = 0;
//        province = "";
//        sex = 0;
//        "total_reward_price" = 0;
//        "update_datetime" = "2018-01-31 10:53:03";
//        "user_id" = 33;
//    };
//    "user_type" = 2;
//    username = 13642731171;
//}


//{
//    channelList = "<null>";
//    "last_login_datetime" = "2018-03-02 13:59:10";
//    "login_count" = 772;
//    name = "\U666e\U901a\U7528\U6237195565";
//    "other_info" =     {
//        "certificates_type" = 2;
//        "certificates_url" = "http://192.168.7.100:8028/files/img/20180113/201801131142129982.png";
//        "check_status" = 2;
//        city = "\U5e7f\U5dde\U5e02";
//        "create_datetime" = "2018-01-13 11:45:33";
//        "end_datetime" = "2018-01-13 11:45:33";
//        id = 9;
//        name = "\U7535\U8baf\U76c8\U79d1";
//        province = "\U5e7f\U4e1c\U7701";
//        scale = "";
//        "short_name" = PCCW;
//        "start_datetime" = "2018-01-13 11:45:33";
//        trade = "\U884c\U4e1a1-\U884c\U4e1a1-1";
//        "update_datetime" = "2018-01-13 11:45:33";
//        "user_id" = 17;
//        version = 3;
//    };
//    "user_info" =     {
//        age = 18;
//        city = "";
//        "create_datetime" = "2018-01-02 18:07:36";
//        "head_img" = "http://192.168.7.100:8029/Lib/images/main/Designer1.jpg";
//        "ibean_count" = 30000;
//        id = 15;
//        nickname = "\U4e0a\U6770\U96c6\U56e2";
//        price = "3001.2";
//        province = "";
//        sex = 1;
//        "total_reward_price" = "1.2";
//        "update_datetime" = "2018-02-10 17:29:16";
//        "user_id" = 17;
//    };
//    "user_type" = 2;
//    username = 18822223335;
//}


@end
