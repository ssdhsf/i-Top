//
//  Enterprise.h
//  itop
//
//  Created by huangli on 2018/4/20.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Enterprise  <NSObject>

@end

@interface Enterprise : JSONModel

@property (nonatomic, strong)NSString <Optional>*check_status;
@property (nonatomic, strong)NSString <Optional>*enterprise_id;
@property (nonatomic, strong)NSString <Optional>*enterprise_name;
@property (nonatomic, strong)NSString <Optional>*field;
@property (nonatomic, strong)NSString <Optional>*head_img;
@property (nonatomic, strong)NSString <Optional>*id;
@property (nonatomic, strong)NSString <Optional>*locked;
@property (nonatomic, strong)NSString <Optional>*name;
@property (nonatomic, strong)NSString <Optional>*nickname;
@property (nonatomic, strong)NSString <Optional>*trade;

//"check_status" = 0;
//        "enterprise_id" = 0;
//        "enterprise_name" = "<null>";
//        field = "<null>";
//        "head_img" = "http://192.168.7.100:8028/files/img/20180416/201804162303030365.jpg";
//        id = 0;
//        locked = 0;
//        name = "JJ\U4e86";
//        nickname = "\U4e0a\U6770\U96c6\U56e2";
//        trade = "\U5546\U54c1\U4ea4\U6613,\U5feb\U6d88\U96f6\U552e";
@end
