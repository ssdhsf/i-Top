//
//  Popularize.h
//  itop
//
//  Created by huangli on 2018/3/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Popularize : JSONModel

@property(strong, nonatomic)NSNumber <Optional>*id;
@property(strong, nonatomic)NSString <Optional>*order_no;
@property(strong, nonatomic)NSString <Optional>*article_type;
@property(strong, nonatomic)NSString <Optional>*customer_phone;
@property(strong, nonatomic)NSString <Optional>*customer_name;
@property(strong, nonatomic)NSString <Optional>*phone;
@property(strong, nonatomic)NSString <Optional>*name;
@property(strong, nonatomic)NSString <Optional>*product_name;
@property(strong, nonatomic)NSString <Optional>*product_url;
@property(strong, nonatomic)NSString <Optional>*price;
@property(strong, nonatomic)NSString <Optional>*order_status;
@property(strong, nonatomic)NSString <Optional>*browse_count;
@property(strong, nonatomic)NSString <Optional>*share_count;

//"id": "31",
//"order_no": "18030915041760",
//"article_type": 1,
//"customer_phone": "18822223335",
//"customer_name": "普通用户195565",
//"phone": "18822223336",
//"name": "普通用户10第三方",
//"product_name": "测试111",
//"product_url": "http://m.creatby.com/v2/manage/book/ydcnxx/",
//"price": 53,
//"order_status": 1


//"article_type" = 1;
//"browse_count" = "<null>";
//"create_datetime" = "2018-03-09 15:04:17";
//"customer_name" = "\U666e\U901a\U7528\U6237195565";
//"customer_phone" = 18822223335;
//id = 31;
//name = "\U666e\U901a\U7528\U623710\U7b2c\U4e09\U65b9";
//"order_no" = 18030915041760;
//"order_status" = 1;
//phone = 18822223336;
//price = 53;
//"product_name" = "\U6d4b\U8bd5111";
//"product_url" = "http://m.creatby.com/v2/manage/book/ydcnxx/";
//"share_count" = 33;

@end
