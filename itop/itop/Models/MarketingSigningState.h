//
//  MarketingSigningState.h
//  itop
//
//  Created by huangli on 2018/4/8.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol MarketingSigningState <NSObject>

@end

@interface MarketingSigningState : JSONModel

@property (nonatomic, strong)NSString <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*user_id;
@property (nonatomic, strong)NSString <Optional>*check_status;
@property (nonatomic, strong)NSString <Optional>*trade;
@property (nonatomic, strong)NSString <Optional>*avg_score;
@property (nonatomic, strong)NSString <Optional>*order_count;
@property (nonatomic, strong)NSString <Optional>*city;
@property (nonatomic, strong)NSString <Optional>*create_datetime;
@property (nonatomic, strong)NSString <Optional>*update_datetime;
@property (nonatomic, strong)NSString <Optional>*message;

//"id": 8,
//        "user_id": 48,
//        "check_status": 0,
//        "trade": "商务服务,广告",
//        "province": "广东省",
//        "city": "广州市",
//        "order_count": 0,
//        "avg_score": 0,
//        "create_datetime": "2018-04-03 17:50:59",
//        "update_datetime": "2018-04-03 17:50:59"

@end
