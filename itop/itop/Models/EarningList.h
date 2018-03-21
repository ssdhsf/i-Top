//
//  EarningList.h
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EarningList : JSONModel

@property (nonatomic, strong) NSString <Optional>*buyer_id;
@property (nonatomic, strong) NSString <Optional>*create_datetime;
@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*name;
@property (nonatomic, strong) NSString <Optional>*order_no;
@property (nonatomic, strong) NSString <Optional>*price;
@property (nonatomic, strong) NSString <Optional>*reward_id;
@property (nonatomic, strong) NSString <Optional>*reward_price;
@property (nonatomic, strong) NSString <Optional>*reward_total_price;
@property (nonatomic, strong) NSString <Optional>*reward_type;
@property (nonatomic, strong) NSString <Optional>*user_id;


//"buyer_id" = 16;
//"create_datetime" = "2018-01-26 18:07:19";
//id = 9;
//name = "\U6d4b\U8bd51111117";
//"order_no" = 18012618071930;
//price = "0.01";
//"reward_id" = 0;
//"reward_price" = "0.01";
//"reward_total_price" = "4000.85";
//"reward_type" = 2;
//"user_id" = 16;

@end
