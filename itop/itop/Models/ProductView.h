//
//  ProductView.h
//  itop
//
//  Created by huangli on 2018/2/10.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ProductView : JSONModel

@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*product_id;
@property (nonatomic, strong) NSString <Optional>*index;
@property (nonatomic, strong) NSString <Optional>*url;
@property (nonatomic, strong) NSString <Optional>*create_datetime;
@property (nonatomic, strong) NSString <Optional>*update_datetime;

//{
    //                             "id": 0,
    //                             "product_id": 0,
    //                             "index": 0,
    //                             "url": "string",
    //                             "create_datetime": "2018-02-08T09:11:29.336Z",
    //                             "update_datetime": "2018-02-08T09:11:29.336Z"
    //                         }

@end
