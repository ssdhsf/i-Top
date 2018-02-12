//
//  Recommended.h
//  itop
//
//  Created by huangli on 2018/1/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Recommended : JSONModel

@property (nonatomic, strong) NSString <Optional>*imageUrl;
@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*browse;
@property (nonatomic, strong) NSString <Optional>*good;
@property (nonatomic, strong) NSString <Optional>*comments;
@property (nonatomic, strong) NSString <Optional>*time;
@property (nonatomic, strong) NSString <Optional>*id;


@end
