//
//  UserInfo.h
//  
//
//  Created by huangli on 2018/2/8.
//
//

#import <JSONModel/JSONModel.h>

@protocol UserInfo <NSObject>


@end

@interface UserInfo : JSONModel

@property (nonatomic, strong) NSString <Optional>*age;
@property (nonatomic, strong) NSString <Optional>*city;
@property (nonatomic, strong) NSString <Optional>*head_img;
@property (nonatomic, strong) NSString <Optional>*ibean_count;
@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*price;
@property (nonatomic, strong) NSString <Optional>*province;
@property (nonatomic, strong) NSString <Optional>*nickname;
@property (nonatomic, strong) NSString <Optional>*sex;
@property (nonatomic, strong) NSString <Optional>*total_reward_price;
@property (nonatomic, strong) NSString <Optional>*create_datetime;
@property (nonatomic, strong) NSString <Optional>*update_datetime;
@property (nonatomic, strong) NSString <Optional>*user_id;


//age = 18;
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



//@property (nonatomic, strong) NSString <Optional>*user_type;
//@property (nonatomic, strong) NSString <Optional>*name;
//@property (nonatomic, strong) NSString <Optional>*check_status;
//@property (nonatomic, strong) NSString <Optional>*commend;
////@property (nonatomic, strong) NSString <Optional>*field;
//@property (nonatomic, strong) NSString <Optional>*leveld;
//@property (nonatomic, strong) NSString <Optional>*url;



//"user_info" =     {
    //        age = 0;
    //        city = "";
    //        "create_datetime" = "2018-01-16 18:05:22";
    //        "head_img" = "";
    //        "ibean_count" = 0;
    //        id = 8;
    //        nickname = "\U666e\U901a\U7528\U6237156987";
    //        price = 0;
    //        province = "";
    //        sex = 0;
    //        "total_reward_price" = 0;
    //        "update_datetime" = "2018-01-16 18:05:22";
    //        "user_id" = 27;
    //    };


//设计师字段
//"check_status" = 2;
//commend = 1;
//"create_datetime" = "2018-01-01 00:00:00";
//field = "\U4f01\U4e1a\U5ba3\U4f20";
//id = 14;
//level = 0;
//"update_datetime" = "2018-01-01 00:00:00";
//url = "";
//"user_id" = 16;
@end
