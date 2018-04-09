//
//  DirectMessages.h
//  itop
//
//  Created by huangli on 2018/3/28.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DirectMessages : JSONModel <NSMutableCopying>

@property (nonatomic, strong)NSString <Optional>*receive_user_id;
@property (nonatomic, strong)NSString <Optional>*receive_head_img;
@property (nonatomic, strong)NSNumber <Optional>*sender_user_id;
@property (nonatomic, strong)NSString <Optional>*sender_head_img;
@property (nonatomic, strong)NSString <Optional>*message;
@property (nonatomic, strong)NSString <Optional>*read;
@property (nonatomic, strong)NSString <Optional>*create_datetime;

//+ (id)directMessagesWithDirectMessages:(DirectMessages *)messages;
//"receive_user_id": "26",
//"receive_head_img": "",
//"sender_user_id": "16",
//"sender_head_img": "http://192.168.7.100:8028/files/img/20180319/201803190943442299.jpg",
//"message": "123456",
//"read": false,
//"create_datetime": "2018-03-28 14:42:49"

@end
