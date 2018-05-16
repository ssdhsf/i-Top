//
//  UserInfomation.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol UserInfomation  <NSObject>

@end

@interface UserInfomation : JSONModel

@property (nonatomic, strong) NSNumber <Optional>*id;
@property (nonatomic, strong) NSNumber <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*head_img;
@property (nonatomic, strong) NSString <Optional>*nickname;
@property (nonatomic, strong) NSString <Optional>*age;
@property (nonatomic, strong) NSString <Optional>*sex;
@property (nonatomic, strong) NSString <Optional>*province;
@property (nonatomic, strong) NSString <Optional>*city;
@property (nonatomic, strong) NSString <Optional>*ibean_count;
@property (nonatomic, strong) NSString <Optional>*total_price;
@property (nonatomic, strong) NSString <Optional>*price;
@property (nonatomic, strong) NSString <Optional>*create_datetime;
@property (nonatomic, strong) NSString <Optional>*update_datetime;
@property (nonatomic, strong) NSString <Optional>*total_reward_price;




//"id": 8,
//"user_id": 27,
//"head_img": "",
//"nickname": "普通用户156987",
//"age": 0,
//"sex": 0,
//"province": "",
//"city": "",
//"ibean_count": 0,
//"total_price": 0,
//"price": 0,
//"create_datetime": "2018-01-16 18:05:22",
//"update_datetime": "2018-01-16 18:05:22"

@end
