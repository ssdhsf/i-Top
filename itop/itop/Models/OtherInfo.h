//
//  OtherInfo.h
//  itop
//
//  Created by huangli on 2018/2/27.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol OtherInfo  <NSObject>

@end


@interface OtherInfo : JSONModel

@property (nonatomic, strong) NSString <Optional>*certificates_type;
@property (nonatomic, strong) NSString <Optional>*certificates_url;
@property (nonatomic, strong) NSString <Optional>*check_status;
@property (nonatomic, strong) NSString <Optional>*city;
@property (nonatomic, strong) NSString <Optional>*create_datetime;
@property (nonatomic, strong) NSString <Optional>*end_datetime;
@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*name;
@property (nonatomic, strong) NSString <Optional>*province;
@property (nonatomic, strong) NSString <Optional>*short_name;
@property (nonatomic, strong) NSString <Optional>*start_datetime;
@property (nonatomic, strong) NSString <Optional>*trade;
@property (nonatomic, strong) NSString <Optional>*update_datetime;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*version;
@property (nonatomic, strong) NSString <Optional>*level;

//设计师字段
@property (nonatomic, strong) NSString <Optional>*commend;
@property (nonatomic, strong) NSString <Optional>*field;
@property (nonatomic, strong) NSString <Optional>*url;

//企业
@property (nonatomic, strong) NSString <Optional>*scale;

//自营销
@property (nonatomic, strong) NSString <Optional>*avg_score;
@property (nonatomic, strong) NSString <Optional>*order_count;


//"avg_score" = "5.2";
//        "check_status" = 2;
//        city = "\U5e7f\U5dde\U5e02";
//        "create_datetime" = "2018-01-30 17:18:17";
//        id = 6;
//        "order_count" = 10;
//        province = "\U5e7f\U4e1c\U7701";
//        trade = "\U884c\U4e1a2-\U884c\U4e1a2";
//        "update_datetime" = "2018-02-10 16:23:17";
//        "user_id" = 18;



//"other_info" =     {
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

//设计师
//"check_status" = 2;
//commend = 1;
//"create_datetime" = "2018-01-01 00:00:00";
//field = "\U4f01\U4e1a\U5ba3\U4f20";
//id = 14;
//level = 0;
//"update_datetime" = "2018-01-01 00:00:00";
//url = "";
//"user_id" = 16;

//企业用户
//"other_info" =     {
//    "certificates_type" = 2;
//    "certificates_url" = "http://192.168.7.100:8028/files/img/20180113/201801131142129982.png";
//    "check_status" = 2;
//    city = "\U5e7f\U5dde\U5e02";
//    "create_datetime" = "2018-01-13 11:45:33";
//    "end_datetime" = "2018-01-13 11:45:33";
//    id = 9;
//    name = "\U7535\U8baf\U76c8\U79d1";
//    province = "\U5e7f\U4e1c\U7701";
//    scale = "";
//    "short_name" = PCCW;
//    "start_datetime" = "2018-01-13 11:45:33";
//    trade = "\U884c\U4e1a1-\U884c\U4e1a1-1";
//    "update_datetime" = "2018-01-13 11:45:33";
//    "user_id" = 17;
//    version = 3;
//};

@end
