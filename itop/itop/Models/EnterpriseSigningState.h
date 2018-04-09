//
//  EnterpriseSigningState.h
//  itop
//
//  Created by huangli on 2018/4/8.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol EnterpriseSigningState <NSObject>


@end
@interface EnterpriseSigningState : JSONModel

@property (nonatomic, strong)NSString <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*user_id;
@property (nonatomic, strong)NSString <Optional>*check_status;
@property (nonatomic, strong)NSString <Optional>*name;
@property (nonatomic, strong)NSString <Optional>*short_name;
@property (nonatomic, strong)NSString <Optional>*scale;
@property (nonatomic, strong)NSString <Optional>*trade;
@property (nonatomic, strong)NSString <Optional>*city;
@property (nonatomic, strong)NSString <Optional>*province;
@property (nonatomic, strong)NSString <Optional>*version;
@property (nonatomic, strong)NSString <Optional>*start_datetime;
@property (nonatomic, strong)NSString <Optional>*end_datetime;
@property (nonatomic, strong)NSString <Optional>*certificates_type;
@property (nonatomic, strong)NSString <Optional>*certificates_url;
@property (nonatomic, strong)NSString <Optional>*create_datetime;
@property (nonatomic, strong)NSString <Optional>*update_datetime;
@property (nonatomic, strong)NSString <Optional>*message;


//"id": 24,
//        "user_id": 48,
//        "check_status": 0,
//        "name": "上杰国际广告",
//        "short_name": "上杰",
//        "scale": "                    ",
//        "trade": "商务服务,广告",
//        "city": "广州市",
//        "province": "广东省",
//        "version": 0,
//        "start_datetime": "2018-04-03 17:48:52",
//        "end_datetime": "2018-04-03 17:48:52",
//        "certificates_type": 2,
//        "certificates_url": "http://192.168.7.100:8028/files/img/20180403/201804031748519372.jpg",
//        "create_datetime": "2018-04-03 17:48:52",
//        "update_datetime": "2018-04-03 17:48:52"

@end
