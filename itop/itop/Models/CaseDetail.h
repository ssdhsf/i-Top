//
//  CaseDetail.h
//  itop
//
//  Created by huangli on 2018/5/8.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CaseInfo.h"
#import "CaseDesignerInfo.h"

@interface CaseDetail : JSONModel

@property (strong ,nonatomic)CaseInfo <CaseInfo,Optional>*info;
@property (strong ,nonatomic)CaseDesignerInfo <CaseDesignerInfo,Optional>*designer_info;

//{
//    "info": {
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
//    },
//    "designer_info": {
//        "id": 14,
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
//    }

@end
