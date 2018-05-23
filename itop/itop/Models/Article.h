//
//  Article.h
//  itop
//
//  Created by huangli on 2018/1/31.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Article <NSObject>

@end

@interface Article : JSONModel

@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*article_type;
@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*cover_img;
@property (nonatomic, strong) NSString <Optional>*url;
@property (nonatomic, strong) NSString <Optional>*content;
@property (nonatomic, strong) NSString <Optional>*price;
@property (nonatomic, strong) NSNumber <Optional>*check_status;
@property (nonatomic, strong) NSNumber <Optional>*show;
@property (nonatomic, strong) NSString <Optional>*praise_count;
@property (nonatomic, strong) NSString <Optional>*collection_count;
@property (nonatomic, strong) NSString <Optional>*browse_count;
@property (nonatomic, strong) NSString <Optional>*commend;
@property (nonatomic, strong) NSString <Optional>*comment_count;
@property (nonatomic, strong) NSString <Optional>*importance;
@property (nonatomic, strong) NSString <Optional>*create_datetime;
@property (nonatomic, strong) NSString <Optional>*author_nickname;
@property (nonatomic, strong) NSString <Optional>*update_datetime;
@property (nonatomic, strong) NSString <Optional>*publish_datetime;
//"id": 0,
//            "user_id": 0,
//            "article_type": "string",
//            "title": "string",
//            "cover_img": "string",
//            "url": "string",
//            "content": "string",
//            "price": 0,
//            "check_status": "string",
//            "show": true,
//            "praise_count": 0,
//            "collection_count": 0,
//            "comment_count": 0,
//            "browse_count": 0,
//            "commend": true,
//            "importance": 0,
//            "create_datetime": "2018-01-27T03:16:31.203Z",
//            "update_datetime": "2018-01-27T03:16:31.203Z",
//            "publish_datetime": "2018-01-27T03:16:31.203Z"

@end
