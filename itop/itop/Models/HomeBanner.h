//
//  HomeBanner.h
//  itop
//
//  Created by huangli on 2018/1/31.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HomeBanner : JSONModel

@property (nonatomic, strong) NSString <Optional>*banner_type;
@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*img;
@property (nonatomic, strong) NSString <Optional>*index;
@property (nonatomic, strong) NSString <Optional>*url;

//"banner_type" = 2;
//id = 8;
//img = "http://192.168.7.100:8029/Lib/images/main/banner4.jpg";
//index = 4;
//url = "#";

@end
