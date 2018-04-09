//
//  TradingList.h
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TradingList : JSONModel

@property (nonatomic, strong) NSString <Optional>*json_result;
@property (nonatomic, strong) NSString <Optional>*create_datetime;
@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*order_no;
@property (nonatomic, strong) NSString <Optional>*price;

@property (nonatomic, strong) NSString <Optional>*pay_scene;
@property (nonatomic, strong) NSString <Optional>*pay_status;
@property (nonatomic, strong) NSString <Optional>*pay_type;
@property (nonatomic, strong) NSString <Optional>*user_id;
//"create_datetime" = "2018-04-01 11:46:24";
//id = 1434;
//"json_result" = "";
//message = 186;
//"order_no" = 18040111462476;
//"pay_scene" = 2;
//"pay_status" = 0;
//"pay_type" = 7;
//price = "0.01";
//"user_id" = 16;

@end
