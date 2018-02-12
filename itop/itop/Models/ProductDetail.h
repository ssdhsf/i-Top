//
//  ProductDetail.h
//  itop
//
//  Created by huangli on 2018/2/10.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ProductModel.h"
#import "UserProduct.h"

@interface ProductDetail : JSONModel

@property (nonatomic, strong) NSString <Optional>*designer_id;
@property (nonatomic, strong) NSString <Optional>*designer_head_img;
@property (nonatomic, strong) NSString <Optional>*designer_name;
@property (nonatomic, strong) ProductModel <ProductModel, Optional>*product;
@property (nonatomic, strong) NSArray <Optional>*product_view;
@property (nonatomic, strong) NSArray <Optional>*product_tag;
@property (nonatomic, strong) UserProduct <UserProduct,Optional>*user_product;

//        "designer_id": 0,
//        "designer_head_img": "string",
//        "designer_name": "string",
//        "product": {
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
//        "product_view": [
//                         {
//                             "id": 0,
//                             "product_id": 0,
//                             "index": 0,
//                             "url": "string",
//                             "create_datetime": "2018-02-08T09:11:29.336Z",
//                             "update_datetime": "2018-02-08T09:11:29.336Z"
//                         }
//                         ],
//        "product_tag": [
//                        {
//                            "id": 0,
//                            "product_id": 0,
//                            "name": "string"
//                        }
//                        ],
//        "user_product": {
//            "id": 0,
//            "user_id": 0,
//            "product_id": 0,
//            "praise": true,
//            "collection": true,
//            "payment": true,
//            "create_datetime": "2018-02-08T09:11:29.336Z",
//            "update_datetime": "2018-02-08T09:11:29.336Z"
//        }

//}




@end
