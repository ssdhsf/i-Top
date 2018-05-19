//
//  UserProduct.h
//  itop
//
//  Created by huangli on 2018/2/10.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol UserProduct  <NSObject>

@end

@interface UserProduct : JSONModel

@property (nonatomic, strong) NSNumber <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*product_id;
@property (nonatomic, strong) NSString <Optional>*praise;
@property (nonatomic, strong) NSString <Optional>*collection;
@property (nonatomic, strong) NSString <Optional>*payment;
@property (nonatomic, strong) NSString <Optional>*create_datetime;
@property (nonatomic, strong) NSString <Optional>*update_datetime;

//"id": 0,
//            "user_id": 0,
//            "product_id": 0,
//            "praise": true,
//            "collection": true,
//            "payment": true,
//            "create_datetime": "2018-02-08T09:11:29.336Z",
//            "update_datetime": "2018-02-08T09:11:29.336Z"

@end
