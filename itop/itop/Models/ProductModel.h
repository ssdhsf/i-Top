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

@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*user_id;
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
