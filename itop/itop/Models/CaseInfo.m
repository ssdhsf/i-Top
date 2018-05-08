//
//  CaseInfo.m
//  itop
//
//  Created by huangli on 2018/5/8.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CaseInfo.h"

@implementation CaseInfo

-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    
    self =  [super initWithDictionary:dict error:err];
    self.descrip = dict[@"description"];
    return self;
}
@end
