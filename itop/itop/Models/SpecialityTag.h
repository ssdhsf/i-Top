//
//  SpecialityTag.h
//  itop
//
//  Created by huangli on 2018/2/22.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SpecialityTag : JSONModel

@property (nonatomic, strong) NSString <Optional>*tag;
@property (nonatomic, assign) BOOL selecteTag;

@end
