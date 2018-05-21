//
//  Demand.h
//  itop
//
//  Created by huangli on 2018/4/20.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Demand  <NSObject>
@end

@interface Demand : JSONModel

@property (nonatomic, strong)NSString <Optional>*browse_count;
@property (nonatomic, strong)NSString <Optional>*check_status;
@property (nonatomic, strong)NSString <Optional>*city;
@property (nonatomic, strong)NSString <Optional>*contact_name;
@property (nonatomic, strong)NSString <Optional>*contact_phone;
@property (nonatomic, strong)NSString <Optional>*create_datetime;
@property (nonatomic, strong)NSNumber <Optional>*demand_case_id;
@property (nonatomic, strong)NSString <Optional>*demand_status;
@property (nonatomic, strong)NSString <Optional>*demand_type;
@property (nonatomic, strong)NSString <Optional>*descrip;
@property (nonatomic, strong)NSNumber <Optional>*designer_user_id;
@property (nonatomic, strong)NSString <Optional>*finish_datetime;
@property (nonatomic, strong)NSNumber <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*pay_order_no;
@property (nonatomic, strong)NSString <Optional>*price;
@property (nonatomic, strong)NSString <Optional>*province;
@property (nonatomic, strong)NSString <Optional>*reference_img;
@property (nonatomic, strong)NSString <Optional>*reference_url;
@property (nonatomic, strong)NSString <Optional>*title;
@property (nonatomic, strong)NSString <Optional>*trade;
@property (nonatomic, strong)NSString <Optional>*update_datetime;
@property (nonatomic, strong)NSNumber <Optional>*user_id;
//        "browse_count" = 0;
//        "check_status" = 2;
//        city = "";
//        "contact_name" = "wo ";
//        "contact_phone" = 312321;
//        "create_datetime" = "2018-04-17 21:03:12";
//        "demand_case_id" = 15;
//        "demand_status" = 3;
//        "demand_type" = 1;
//        description = "\U8be6\U7ec6";
//        "designer_user_id" = 16;
//        "finish_datetime" = "2018-02-15 00:00:00";
//        id = 44;
//        "pay_order_no" = "";
//        price = 15;
//        province = "";
//        "reference_img" = "";
//        "reference_url" = "";
//        title = "\U5c0f\U5f3a";
//        trade = "wo ";
//        "update_datetime" = "2018-04-18 12:00:01";
//        "user_id" = 17;
@end
