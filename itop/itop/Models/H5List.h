//
//  H5List.h
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface H5List : JSONModel

@property (nonatomic, strong) NSString <Optional>*h5ImageUrl;
@property (nonatomic, strong) NSString <Optional>*h5Title;
@property (nonatomic, strong) NSString <Optional>*h5Money;

@property (nonatomic, strong) NSString <Optional>*browse_count;
@property (nonatomic, strong) NSString <Optional>*collection_count;
@property (nonatomic, strong) NSString <Optional>*comment_count;
@property (nonatomic, strong) NSString <Optional>*cover_img;
@property (nonatomic, strong) NSString <Optional>*head_img;
@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*nickname;
@property (nonatomic, strong) NSString <Optional>*praise_count;
@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*price;

//"browse_count" = 0;
//"collection_count" = 1;
//"comment_count" = 0;
//"cover_img" = "http://192.168.7.100:8029/Lib/images/main/banner1.jpg";
//"head_img" = "http://192.168.7.100:8028/files/img/20180129/201801291921400799.png";
//id = 19;
//nickname = "\U666e\U901a\U7528\U6237188888";
//"praise_count" = 0;
//title = "\U6d4b\U8bd5\U6587\U7ae011111122333";

@end
