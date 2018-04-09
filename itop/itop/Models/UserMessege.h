//
//  UserMessege.h
//  itop
//
//  Created by huangli on 2018/3/28.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserMessege : JSONModel

@property (nonatomic, strong)NSString <Optional>*create_datetime;
@property (nonatomic, strong)NSString <Optional>*head_img;
@property (nonatomic, strong)NSString <Optional>*message;
@property (nonatomic, strong)NSString <Optional>*nickname;
@property (nonatomic, strong)NSString <Optional>*user_id;

//"create_datetime" = "2018-02-11 14:27:57";
//"head_img" = "http://192.168.7.100:8029/Lib/images/main/Designer1.jpg";
//message = heidfd;
//nickname = "\U4e0a\U6770\U96c6\U56e2";
//"user_id" = 17;

@end
