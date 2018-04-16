//
//  ProductModel.h
//  itop
//
//  Created by huangli on 2018/2/10.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ProductModel <NSObject>

@end

@interface ProductModel : JSONModel

@property (nonatomic, strong) NSNumber <Optional>*id;
@property (nonatomic, strong) NSNumber <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*product_type;
@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*cover_img;
@property (nonatomic, strong) NSString <Optional>*descrip;
@property (nonatomic, strong) NSString <Optional>*url;
@property (nonatomic, strong) NSString <Optional>*price;
@property (nonatomic, strong) NSString <Optional>*check_status;
@property (nonatomic, strong) NSString <Optional>*designer_id;
@property (nonatomic, strong) NSString <Optional>*show;
@property (nonatomic, strong) NSString <Optional>*praise_count;
@property (nonatomic, strong) NSString <Optional>*collection_count;
@property (nonatomic, strong) NSString <Optional>*comment_count;
@property (nonatomic, strong) NSString <Optional>*browse_count;
@property (nonatomic, strong) NSString <Optional>*sale_count;
@property (nonatomic, strong) NSString <Optional>*commend;
@property (nonatomic, strong) NSString <Optional>*importance;
@property (nonatomic, strong) NSString <Optional>*share_img;
@property (nonatomic, strong) NSString <Optional>*share_title;
@property (nonatomic, strong) NSString <Optional>*share_description;
@property (nonatomic, strong) NSString <Optional>*create_datetime;
@property (nonatomic, strong) NSString <Optional>*update_datetime;
@property (nonatomic, strong) NSString <Optional>*publish_datetime;

//product =     {
    //        "browse_count" = 144;
    //        "check_status" = 2;
    //        "collection_count" = 0;
    //        commend = 1;
    //        "commend_datetime" = "1900-01-01 00:00:00";
    //        "comment_count" = 2;
    //        "cover_img" = "http://192.168.7.100:8028/files/img/20180209/201802091506019778.png";
    //        "create_datetime" = "2018-02-07 14:10:39";
    //        description = "\U7b56\U5212\Uff1a\U5f53\U4e16\U754c\U672b\U65e5\U6765\U4e34\Uff0c\U6240\U6709\U751f\U547d\U6d88\U5931\U6b86\U5c3d\Uff0c\U4eba\U7c7b\U6587\U660e\U8fd8\U4f1a\U7559\U4e0b\U75d5\U8ff9\U5417\Uff1f\U5e9f\U589f\U4e4b\U4e2d\U7684\U624b\U673a\U51fa\U73b0\U4e86\U4e00\U4e2a\U54c1\U724c\U7684\U5b98\U65b9\U6765\U7535\U63d0\U793a\U2014\U5f70\U663e\U4e86\U54c1\U724c\U4ece\U672b\U65e5\U4e2d\U5e78\U5b58\U7684\U8fc7\U786c\U5b9e\U529b\Uff0c\U9002\U7528\U4e8e\U54c1\U724c\U5ba3\U4f20/\U66dd\U5149\U3002 \U89c6\U89c9\Uff1a\U5199\U5b9e\U98ce\U683c\Uff0c\U573a\U666f\U6062\U5f18\U5927\U6c14\Uff1b \U5e94\U7528\Uff1a\U7535\U8bdd\U6253\U8fdb\U6765\U7684\U6765\U7535\U5934\U50cf/logo \U53ef\U66ff\U6362\U6210\U4efb\U610f\U54c1\U724clogo\U3002";
    //        id = 297;
    //        importance = 0;
    //        "praise_count" = 0;
    //        price = 0;
    //        "product_type" = 1;
    //        "publish_datetime" = "2018-02-07 14:10:39";
    //        "sale_count" = 0;
    //        "share_description" = "\U4e16\U754c\U672b\U65e5";
    //        "share_img" = "http://192.168.7.100:8028/files/img/20180209/201802091506059039.png";
    //        "share_title" = "\U4e16\U754c\U672b\U65e5";
    //        show = 1;
    //        title = "\U4e16\U754c\U672b\U65e5";
    //        "update_datetime" = "2018-02-09 15:06:06";
    //        url = "http://192.168.7.100:8029/html5/20180108shadiao%E6%B2%99%E9%9B%95/index.html";
    //        "user_id" = 20;
    //    };

//"product": {
    //            "id": 0,
    //            "user_id": 0,
    //            "product_type": "string",
    //            "title": "string",
    //            "cover_img": "string",
    //            "description": "string",
    //            "url": "string",
    //            "price": 0,
    //            "check_status": "string",
    //            "show": true,
    //            "praise_count": 0,
    //            "collection_count": 0,
    //            "comment_count": 0,
    //            "browse_count": 0,
    //            "sale_count": 0,
    //            "commend": true,
    //            "importance": 0,
    //            "share_img": "string",
    //            "share_title": "string",
    //            "share_description": "string",
    //            "create_datetime": "2018-02-08T09:11:29.335Z",
    //            "update_datetime": "2018-02-08T09:11:29.335Z",
    //            "publish_datetime": "2018-02-08T09:11:29.335Z"
    //        },

@end
