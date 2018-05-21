//
//  Userwallet.h
//  itop
//
//  Created by huangli on 2018/5/14.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Userwallet : JSONModel

@property (strong ,nonatomic)NSNumber <Optional>*id;
@property (strong ,nonatomic)NSNumber <Optional>*user_id;
@property (strong ,nonatomic)NSString <Optional>*head_img;
@property (strong ,nonatomic)NSString <Optional>*nickname;
@property (strong ,nonatomic)NSNumber <Optional>*age;
@property (strong ,nonatomic)NSNumber <Optional>*sex;
@property (strong ,nonatomic)NSString <Optional>*province;
@property (strong ,nonatomic)NSString <Optional>*city;
@property (strong ,nonatomic)NSString <Optional>*ibean_count;
@property (strong ,nonatomic)NSString <Optional>*total_reward_price;
@property (strong ,nonatomic)NSString <Optional>*price;
@property (strong ,nonatomic)NSString <Optional>*create_datetime;
@property (strong ,nonatomic)NSString <Optional>*update_datetime;

//"id": 15,
//"user_id": 17,
//"head_img": "http://192.168.7.100:8028/files/img/20180507/201805071607359175.png",
//"nickname": "这家伙",
//"age": 18,
//"sex": 1,
//"province": "甘肃省",
//"city": "张掖市",
//"ibean_count": 29999,
//"total_reward_price": 171.4,
//"price": 7.94,
//"create_datetime": "2018-01-02 18:07:36",
//"update_datetime": "2018-05-12 11:48:45"

@end
