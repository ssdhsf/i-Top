//
//  CaseDesignerInfo.h
//  itop
//
//  Created by huangli on 2018/5/8.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol CaseDesignerInfo  <NSObject>
@end

@interface CaseDesignerInfo : JSONModel

@property (strong ,nonatomic)NSNumber <Optional>*user_id;
@property (strong ,nonatomic)NSString <Optional>*head_img;
@property (strong ,nonatomic)NSString <Optional>*nickname;
@property (strong ,nonatomic)NSString <Optional>*age;
@property (strong ,nonatomic)NSString <Optional>*sex;
@property (strong ,nonatomic)NSString <Optional>*province;
@property (strong ,nonatomic)NSString <Optional>*city;
@property (strong ,nonatomic)NSString <Optional>*ibean_count;
@property (strong ,nonatomic)NSString <Optional>*total_reward_price;
@property (strong ,nonatomic)NSString <Optional>*price;
@property (strong ,nonatomic)NSString <Optional>*create_datetime;
@property (strong ,nonatomic)NSString <Optional>*update_datetime;

//"id": 14,
//        "user_id": 16,
//        "head_img": "http://192.168.7.100:8028/files/img/20180505/201805052038464135.png",
//        "nickname": "一号女嘉宾",
//        "age": 26,
//        "sex": 1,
//        "province": "340000",
//        "city": "340100",
//        "ibean_count": 29710,
//        "total_reward_price": 39.5,
//        "price": 1023.24,
//        "create_datetime": "2018-01-02 18:07:36",
//        "update_datetime": "2018-05-07 17:40:27"

@end
