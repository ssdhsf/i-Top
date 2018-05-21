//
//  TagList.m
//  itop
//
//  Created by huangli on 2018/2/1.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "TagList.h"

@implementation TagList

-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    
    self = [super initWithDictionary:dict error:err];
    self.selecteTag =[[SelecteTag alloc]init];
    return self;
}

@end
