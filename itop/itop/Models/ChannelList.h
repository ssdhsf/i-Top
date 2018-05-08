//
//  ChannelList.h
//  itop
//
//  Created by huangli on 2018/5/4.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ChannelList : JSONModel

@property (strong ,nonatomic)NSString <Optional>*user_id;
@property (strong ,nonatomic)NSString <Optional>*name;
@property (strong ,nonatomic)NSString <Optional>*index_url;
@property (strong ,nonatomic)NSNumber <Optional>*id;
@property (strong ,nonatomic)NSString <Optional>*fans_count;
@property (strong ,nonatomic)NSString <Optional>*create_datetime;


//"create_datetime" = "2018-05-04 17:10:10";
//"fans_count" = 1234;
//id = 22;
//"index_url" = "www.baidu.com";
//name = "\U4eca\U65e5\U5934\U6761";
//"user_id" = 54;

@end
