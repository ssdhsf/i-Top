//
//  BiddingProduct.h
//  itop
//
//  Created by huangli on 2018/4/27.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BiddingProduct : JSONModel

@property (strong ,nonatomic)NSString <Optional>*case_url;
@property (strong ,nonatomic)NSString <Optional>*cover_img;
@property (strong ,nonatomic)NSString <Optional>*create_datetime;
@property (strong ,nonatomic)NSNumber <Optional>*demand_id;
@property (strong ,nonatomic)NSNumber <Optional>*id;
@property (strong ,nonatomic)NSString <Optional>*introduction;
@property (strong ,nonatomic)NSString <Optional>*name;
@property (strong ,nonatomic)NSString <Optional>*user_id;

//"case_url" = "baidu.com";
//"cover_img" = "http://192.168.7.100:8028/files/img/20180417/201804171557082382.jpg";
//"create_datetime" = "2018-04-17 15:57:21";
//"demand_id" = 26;
//id = 7;
//introduction = waqerfwefgwef;
//name = "test-work111";
//url = "\U94fe\U63a5 465654 \U5bc6\U780113216546";
//"user_id" = 16;
@end
