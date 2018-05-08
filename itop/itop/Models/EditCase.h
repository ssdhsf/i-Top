//
//  EditCase.h
//  itop
//
//  Created by huangli on 2018/5/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EditCase : JSONModel

@property (strong ,nonatomic)NSString <Optional>*check_status;
@property (strong ,nonatomic)NSString <Optional>*commend;
@property (strong ,nonatomic)NSString <Optional>*cover_img;
@property (strong ,nonatomic)NSString <Optional>*create_datetime;
@property (strong ,nonatomic)NSString <Optional>*designer_head_img;
@property (strong ,nonatomic)NSString <Optional>*designer_name;
@property (strong ,nonatomic)NSNumber <Optional>*id;
@property (strong ,nonatomic)NSString <Optional>*price;
@property (strong ,nonatomic)NSNumber <Optional>*show;
@property (strong ,nonatomic)NSString <Optional>*title;
@property (strong ,nonatomic)NSString <Optional>*url;

//"check_status" = 0;
//commend = 0;
//"cover_img" = "http://192.168.7.100:8028/files/img/20180505/201805052023426105.png";
//"create_datetime" = "2018-05-05 19:45:54";
//"designer_head_img" = "http://192.168.7.100:8028/files/img/20180505/201805052038464135.png";
//"designer_name" = 001;
//id = 35;
//price = 1;
//show = 1;
//title = "\U5c0f\U5f3a\U6848\U4f8b\U4f5c\U54c1\U660e\U767d";
//url = "www.baidu.com";

@end
