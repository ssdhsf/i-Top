//
//  H5List.m
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "H5List.h"

@implementation H5List


-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    
    self = [super initWithDictionary:dict error:err];
    Boolean show = (Boolean)dict[@"show"];
    
    if (show == true) {
        self.show == @1;
    } else {
        
        self.show == @0;
    }
    return self;
}
@end
