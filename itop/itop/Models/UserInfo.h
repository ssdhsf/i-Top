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
@property (nonatomic, strong) NSString <Optional>*create_datetime;
@property (nonatomic, strong) NSString <Optional>*head_img;
@property (nonatomic, strong) NSString <Optional>*ibean_count;
@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*price;
@property (nonatomic, strong) NSString <Optional>*province;
@property (nonatomic, strong) NSString <Optional>*nickname;
@property (nonatomic, strong) NSString <Optional>*sex;
@property (nonatomic, strong) NSString <Optional>*total_reward_price;
@property (nonatomic, strong) NSString <Optional>*update_datetime;
@property (nonatomic, strong) NSString <Optional>*user_id;

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

@end
