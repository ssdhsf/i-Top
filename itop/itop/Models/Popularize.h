//
//  Popularize.h
//  itop
//
//  Created by huangli on 2018/3/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Popularize : JSONModel

@property(strong, nonatomic)NSString <Optional>*id;
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
@end
