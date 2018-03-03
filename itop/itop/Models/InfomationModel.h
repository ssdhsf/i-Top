//
//  InfomationModel.h
//  itop
//
//  Created by huangli on 2018/2/8.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "UserInfo.h"
#import "OtherInfo.h"

@interface InfomationModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*last_login_datetime;
@property (nonatomic, strong) NSString <Optional>*login_count;
@property (nonatomic, strong) NSString <Optional>*name;
@property (nonatomic, strong) OtherInfo <OtherInfo,Optional>*other_info;
@property (nonatomic, strong) UserInfo <UserInfo,Optional>*user_info;
@property (nonatomic, strong) NSString <Optional>*user_type;
@property (nonatomic, strong) NSString <Optional>*username;
@property (nonatomic, strong) NSArray <Optional>*channelList;

//{
//    channelList = "<null>";
//    "last_login_datetime" = "2018-03-02 10:54:45";
//    "login_count" = 259;
//    name = "i-top\U5b98\U65b9\U8bbe\U8ba1\U5e08 ";
//    "other_info" =     {
//        "check_status" = 2;
//        commend = 1;
//        "create_datetime" = "2018-01-01 00:00:00";
//        field = "\U4f01\U4e1a\U5ba3\U4f20";
//        id = 14;
//        level = 0;
//        "update_datetime" = "2018-01-01 00:00:00";
//        url = "";
//        "user_id" = 16;
//    };
//    "user_info" =     {
//        age = 1;
//        city = "\U6dee\U5357\U5e02";
//        "create_datetime" = "2018-01-02 18:07:36";
//        "head_img" = "http://192.168.7.100:8028/files/img/20180227/201802271605497056.png";
//        "ibean_count" = 30000;
//        id = 14;
//        nickname = "i-top\U5b98\U65b9\U8bbe\U8ba1\U5e08 ";
//        price = "2999.96";
//        province = "\U5b89\U5fbd\U7701";
//        sex = 1;
//        "total_reward_price" = 0;
//        "update_datetime" = "2018-02-27 16:05:49";
//        "user_id" = 16;
//    };
//    "user_type" = 1;
//    username = 18822223334;
//}



//自营销人

//{
//    channelList =     (
//    );
//    "last_login_datetime" = "2018-03-02 14:05:47";
//    "login_count" = 65;
//    name = "\U666e\U901a\U7528\U6237105143";
//    "other_info" =     {
//        "avg_score" = "5.2";
//        "check_status" = 2;
//        city = "\U5e7f\U5dde\U5e02";
//        "create_datetime" = "2018-01-30 17:18:17";
//        id = 6;
//        "order_count" = 10;
//        province = "\U5e7f\U4e1c\U7701";
//        trade = "\U884c\U4e1a2-\U884c\U4e1a2";
//        "update_datetime" = "2018-02-10 16:23:17";
//        "user_id" = 18;
//    };
//    "user_info" =     {
//        age = 18;
//        city = "\U5e7f\U5dde\U5e02";
//        "create_datetime" = "2018-01-02 18:07:36";
//        "head_img" = "http://192.168.7.100:8029/Lib/images/main/Designer1.jpg";
//        "ibean_count" = 30000;
//        id = 16;
//        nickname = "\U666e\U901a\U7528\U623711114";
//        price = 3000;
//        province = "\U5e7f\U4e1c\U7701";
//        sex = 1;
//        "total_reward_price" = 0;
//        "update_datetime" = "2018-02-12 10:24:39";
//        "user_id" = 18;
//    };
//    "user_type" = 3;
//    username = 18822223336;
//}


@end
