//
//  H5List.h
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface H5List : JSONModel

@property (nonatomic, strong) NSString <Optional>*h5ImageUrl;
@property (nonatomic, strong) NSString <Optional>*h5Title;
@property (nonatomic, strong) NSString <Optional>*h5Money;

@property (nonatomic, strong) NSString <Optional>*browse_count;
@property (nonatomic, strong) NSString <Optional>*collection_count;
@property (nonatomic, strong) NSString <Optional>*comment_count;
@property (nonatomic, strong) NSString <Optional>*cover_img;
@property (nonatomic, strong) NSString <Optional>*head_img;
@property (nonatomic, strong) NSNumber <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*nickname;
@property (nonatomic, strong) NSString <Optional>*praise_count;
@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*price;
@property (nonatomic, strong) NSString <Optional>*commend;
@property (nonatomic, strong) NSString <Optional>*check_status;
@property (nonatomic, strong) NSString <Optional>*commend_datetime;
@property (nonatomic, strong) NSString <Optional>*create_datetime;
@property (nonatomic, strong) NSString <Optional>*descrip;
@property (nonatomic, strong) NSString <Optional>*importance;
@property (nonatomic, strong) NSString <Optional>*product_type;
@property (nonatomic, strong) NSString <Optional>*publish_datetime;
@property (nonatomic, strong) NSString <Optional>*sale_count;
@property (nonatomic, strong) NSString <Optional>*share_description;
@property (nonatomic, strong) NSString <Optional>*share_img;
@property (nonatomic, strong) NSString <Optional>*share_title;
@property (nonatomic, strong) NSNumber <Optional>*show;
@property (nonatomic, strong) NSString <Optional>*update_datetime;
@property (nonatomic, strong) NSString <Optional>*url;
@property (nonatomic, strong) NSString <Optional>*user_id;


//{
//    "browse_count" = 38;
//    "check_status" = 0;
//    "collection_count" = 0;
//    commend = 0;
//    "commend_datetime" = "1900-01-01 00:00:00";
//    "comment_count" = 0;
//    "cover_img" = "http://192.168.7.100:8028/files/img/20180312/201803121107170898.png";
//    "create_datetime" = "2018-03-05 11:40:52";
//    description = test;
//    id = 301;
//    importance = 0;
//    "praise_count" = 0;
//    price = 4123123;
//    "product_type" = 1;
//    "publish_datetime" = "2018-01-26 14:51:11";
//    "sale_count" = 0;
//    "share_description" = "";
//    "share_img" = "";
//    "share_title" = "";
//    show = 0;
//    title = test;
//    "update_datetime" = "2018-03-12 11:07:17";
//    url = "http://m.creatby.com/v2/manage/book/ydcnxx/";
//    "user_id" = 16;
//}



//"browse_count" = 0;
//"collection_count" = 1;
//"comment_count" = 0;
//"cover_img" = "http://192.168.7.100:8029/Lib/images/main/banner1.jpg";
//"head_img" = "http://192.168.7.100:8028/files/img/20180129/201801291921400799.png";
//id = 19;
//nickname = "\U666e\U901a\U7528\U6237188888";
//"praise_count" = 0;
//title = "\U6d4b\U8bd5\U6587\U7ae011111122333";

@end
