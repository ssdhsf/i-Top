//
//  CaseInfo.h
//  itop
//
//  Created by huangli on 2018/5/8.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol CaseInfo  <NSObject>
@end

@interface CaseInfo : JSONModel

@property (strong ,nonatomic)NSNumber <Optional>*id;
@property (strong ,nonatomic)NSString <Optional>*title;
@property (strong ,nonatomic)NSString <Optional>*cover_img;
@property (strong ,nonatomic)NSString <Optional>*descrip;
@property (strong ,nonatomic)NSString <Optional>*url;
@property (strong ,nonatomic)NSString <Optional>*case_url;
@property (strong ,nonatomic)NSNumber <Optional>*user_id;
@property (strong ,nonatomic)NSString <Optional>*customer_user_id;
@property (strong ,nonatomic)NSString <Optional>*customer_name;
@property (strong ,nonatomic)NSString <Optional>*price;
@property (strong ,nonatomic)NSString <Optional>*check_status;
@property (strong ,nonatomic)NSString <Optional>*show;
@property (strong ,nonatomic)NSString <Optional>*commend;
@property (strong ,nonatomic)NSString <Optional>*create_datetime;
@property (strong ,nonatomic)NSString <Optional>*update_datetime;
@property (strong ,nonatomic)NSString <Optional>*commend_datetime;
@property (strong ,nonatomic)NSString <Optional>*demand_count;

-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err;

//        "id": 41,
//        "title": "xiaoqiang",
//        "cover_img": "http://192.168.7.100:8028/files/img/20180508/201805081052004705.jpg",
//        "description": "1213231312",
//        "url": "",
//        "case_url": "www.baidu.com",
//        "user_id": 16,
//        "customer_user_id": 0,
//        "customer_name": "xiaoqiang",
//        "price": 12,
//        "check_status": 0,
//        "show": true,
//        "commend": false,
//        "create_datetime": "2018-05-08 10:52:00",
//        "update_datetime": "2018-05-08 10:52:00",
//        "commend_datetime": "1900-01-01 00:00:00"

@end
