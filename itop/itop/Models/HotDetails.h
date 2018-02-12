//
//  HotDetails.h
//  itop
//
//  Created by huangli on 2018/1/31.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Article.h"
#import "UserArticle.h"

@interface HotDetails : JSONModel

@property (nonatomic, strong) NSString <Optional>*author_id;
@property (nonatomic, strong) NSString <Optional>*author_head_img;
@property (nonatomic, strong) NSString <Optional>*author_nickname;
@property (nonatomic, strong) Article  <Article, Optional>*article;
@property (nonatomic, strong) UserArticle <UserArticle, Optional>*user_article;
@property (nonatomic, strong) NSArray  <Optional>*article_comment;
@property (nonatomic, strong) NSNumber  <Optional>*follow; //是否关注

//        "author_id": 0,
//        "author_head_img": "string",
//        "author_nickname": "string",
//        "article": {
////        },
//        "user_article": {
//            "id": 0,
//            "user_id": 0,
//            "article_id": 0,
//            "praise": true,
//            "collection": true,
//            "payment": true,
//            "create_datetime": "2018-01-27T03:16:31.203Z",
//            "update_datetime": "2018-01-27T03:16:31.203Z"
//        },
//        "article_comment": [
//                            {
//                                "id": 0,
//                                "user_head_img": "string",
//                                "user_name": "string",
//                                "content": "string",
//                                "parent_id": 0,
//                                "create_datetime": "2018-01-27T03:16:31.203Z"
//                            }
//                            ]
//    },
//    "message": "string",
//    "remark": "string"

@end
