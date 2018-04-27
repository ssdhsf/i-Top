//
//  CustomRequirements.h
//  itop
//
//  Created by huangli on 2018/4/19.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CustomRequirements : JSONModel //首页获取

@property (nonatomic, strong)NSNumber <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*title;
@property (nonatomic, strong)NSString <Optional>*check_status;
@property (nonatomic, strong)NSString <Optional>*city;
@property (nonatomic, strong)NSString <Optional>*price;
@property (nonatomic, strong)NSString <Optional>*contact_name;
@property (nonatomic, strong)NSString <Optional>*create_datetime;
@property (nonatomic, strong)NSString <Optional>*demand_status;
@property (nonatomic, strong)NSString <Optional>*demand_type;
@property (nonatomic, strong)NSString <Optional>*descrip;
@property (nonatomic, strong)NSString <Optional>*designer_count;
@property (nonatomic, strong)NSString <Optional>*enterprise_nickname;
@property (nonatomic, strong)NSString <Optional>*head_img;
@property (nonatomic, strong)NSString <Optional>*level;
@property (nonatomic, strong)NSString <Optional>*name;
@property (nonatomic, strong)NSString <Optional>*nickname;
@property (nonatomic, strong)NSString <Optional>*pay_order_no;
@property (nonatomic, strong)NSString <Optional>*province;
@property (nonatomic, strong)NSString <Optional>*reference_img;
@property (nonatomic, strong)NSString <Optional>*reference_url;
@property (nonatomic, strong)NSString <Optional>*trade;
@property (nonatomic, strong)NSString <Optional>*contact_phone;
@property (nonatomic, strong)NSString <Optional>*short_name;


//"id": 4,
//"title": "我是案例一标题",
//"cover_img": "http://192.168.7.100:8029/Lib/images/main/waterfall-chart-1.jpg",
//"url": "http://www.i-top.cn",
//"price": 3000,
//"designer_head_img": "http://192.168.7.100:8028/files/img/20180209/201802091503260825.jpg",
//"designer_name": "普通用户188887"

//"check_status" = 2;
//city = 440100;
//"contact_name" = "\U597d\U50cf\U662f";
//"contact_phone" = 13794337101;
//"create_datetime" = "2018/4/19 13:48:08";
//"demand_status" = 3;
//"demand_type" = 1;
//description = 666;
//"designer_count" = 0;
//"enterprise_nickname" = "\U4e0a\U6770\U96c6\U56e2";
//"head_img" = "http://192.168.7.100:8028/files/img/20180416/201804162303030365.jpg";
//id = 54;
//level = 0;
//name = "<null>";
//nickname = "<null>";
//"pay_order_no" = "";
//price = "500.00";
//province = "";
//"reference_img" = "http://192.168.7.100:8028/files/img/20180419/201804191348084983.png";
//"reference_url" = "";
//"short_name" = "<null>";
//title = "\U7ed9\U6211";
//trade = "133,144";

@end
