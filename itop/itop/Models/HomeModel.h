//
//  HomeModel.h
//  itop
//
//  Created by huangli on 2018/1/27.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HomeModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*imageUrl;
@property (nonatomic, strong) NSString <Optional>*title;

@end
