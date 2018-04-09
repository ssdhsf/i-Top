//
//  SigningState.h
//  itop
//
//  Created by huangli on 2018/4/8.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DesignerSigningState.h"
#import "EnterpriseSigningState.h"
#import "MarketingSigningState.h"

@interface SigningState : JSONModel

@property (nonatomic, strong)DesignerSigningState <DesignerSigningState,Optional>*designer;
@property (nonatomic, strong)EnterpriseSigningState <EnterpriseSigningState,Optional>*enterprise;
@property (nonatomic, strong)MarketingSigningState <MarketingSigningState,Optional>*marketing;

//designer = "<null>";
//enterprise = "<null>";
//marketing = "<null>";

//"data": {
//    "designer": {
//        "id": 15,
//        "user_id": 48,
//        "check_status": 0,
//        "field": "节日传情,中国风,卡通手绘,时尚炫酷",
//        "url": "http://192.168.7.100:8029/files/file/20180408/201804081345010025.rar",
//        "level": 0,
//        "commend": false,
//        "create_datetime": "2018-04-08 13:45:29",
//        "update_datetime": "2018-04-08 13:45:29"
//    },
//    "enterprise": {
//        "id": 24,
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
//    },
//    "marketing": {
//        "id": 8,
//        "user_id": 48,
//        "check_status": 0,
//        "trade": "商务服务,广告",
//        "province": "广东省",
//        "city": "广州市",
//        "order_count": 0,
//        "avg_score": 0,
//        "create_datetime": "2018-04-03 17:50:59",
//        "update_datetime": "2018-04-03 17:50:59"
//    }
//},

@end
