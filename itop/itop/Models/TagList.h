//
//  TagList.h
//  itop
//
//  Created by huangli on 2018/2/1.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TagList : JSONModel

@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*parent_id;
@property (nonatomic, strong) NSString <Optional>*tag_type;
@property (nonatomic, strong) NSString <Optional>*name;
@property (nonatomic, strong) NSString <Optional>*icon;
@property (nonatomic, strong) NSString <Optional>*index;
//"id": 37,
//"parent_id": 19,
//"tag_type": 1,
//"name": "作品标签2-5",
//"icon": "",
//"index": 10
@end
