//
//  Disputes.h
//  itop
//
//  Created by huangli on 2018/5/3.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Disputes : JSONModel

@property (strong ,nonatomic)NSNumber <Optional>*id;
@property (strong ,nonatomic)NSNumber <Optional>*demand_id;
@property (strong ,nonatomic)NSNumber <Optional>*user_id;
@property (strong ,nonatomic)NSString <Optional>*question;
@property (strong ,nonatomic)NSString <Optional>*img;
@property (strong ,nonatomic)NSString <Optional>*remark;
@property (strong ,nonatomic)NSString <Optional>*create_datetime;
//@property (strong ,nonatomic)NSString <Optional>*message;
//"id": 27,
//"demand_id": 92,
//"user_id": 81,
//"question": "未收到款项",
//"img": "http://192.168.7.100:8028/files/img/20180503/201805031200230444.jpg",
//"remark": "Tatty",
//"create_datetime": "2018-05-03 12:00:55"

@end
