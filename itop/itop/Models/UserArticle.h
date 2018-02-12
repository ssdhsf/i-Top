//
//  UserArticle.h
//  itop
//
//  Created by huangli on 2018/2/1.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol UserArticle  <NSObject>

@end

@interface UserArticle : JSONModel

@property (nonatomic, strong) NSString <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*article_id;
@property (nonatomic, strong) NSString <Optional>*praise;
@property (nonatomic, strong) NSString <Optional>*collection;
@property (nonatomic, strong) NSString <Optional>*payment;
@property (nonatomic, strong) NSString <Optional>*create_datetime;
@property (nonatomic, strong) NSString <Optional>*update_datetime;

//"id": 0,
//            "user_id": 0,
//            "article_id": 0,
//            "praise": true,
//            "collection": true,
//            "payment": true,
//            "create_datetime": "2018-01-27T03:16:31.203Z",
//            "update_datetime": "2018-01-27T03:16:31.203Z"

@end
