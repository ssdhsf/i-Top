//
//  City.h
//  itop
//
//  Created by huangli on 2018/4/12.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface City : JSONModel

@property (nonatomic, strong) NSString <Optional>*code;
@property (nonatomic, strong) NSString <Optional>*hot_count;
@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*name;
@property (nonatomic, strong) NSString <Optional>*pinyin;

//code = 440100;
//"hot_count" = 27;
//id = 197;
//name = "\U5e7f\U5dde\U5e02";
//pinyin = G;

@end
