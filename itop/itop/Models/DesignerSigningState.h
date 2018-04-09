//
//  DesignerSigningState.h
//  itop
//
//  Created by huangli on 2018/4/8.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol DesignerSigningState <NSObject>


@end

@interface DesignerSigningState : JSONModel

@property (nonatomic, strong)NSString <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*user_id;
@property (nonatomic, strong)NSString <Optional>*check_status;
@property (nonatomic, strong)NSString <Optional>*field;
@property (nonatomic, strong)NSString <Optional>*url;
@property (nonatomic, strong)NSString <Optional>*level;
@property (nonatomic, strong)NSString <Optional>*commend;
@property (nonatomic, strong)NSString <Optional>*create_datetime;
@property (nonatomic, strong)NSString <Optional>*update_datetime;
@property (nonatomic, strong)NSString <Optional>*message;

//        "id": 15,
//        "user_id": 48,
//        "check_status": 0,
//        "field": "节日传情,中国风,卡通手绘,时尚炫酷",
//        "url": "http://192.168.7.100:8029/files/file/20180408/201804081345010025.rar",
//        "level": 0,
//        "commend": false,
//        "create_datetime": "2018-04-08 13:45:29",
//        "update_datetime": "2018-04-08 13:45:29"
@end
