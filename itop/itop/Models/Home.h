//
//  home.h
//  itop
//
//  Created by huangli on 2018/1/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Home : JSONModel

@property (nonatomic, strong) NSString <Optional>*itemKey;
@property (nonatomic, strong) NSArray <Optional>*itemArray;
@property (nonatomic, strong) NSString <Optional>*itemHeader;

@end
