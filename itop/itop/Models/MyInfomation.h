//
//  MyInfomation.h
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MyInfomation : JSONModel

@property (nonatomic, strong) NSString <Optional>*myInfoImageUrl;
@property (nonatomic, strong) NSString <Optional>*myInfoTitle;
@property (nonatomic, strong) NSString <Optional>*nextVcName;

@end
