//
//  Marketing.h
//  itop
//
//  Created by huangli on 2018/2/28.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Marketing : JSONModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *placeholder;

@end
