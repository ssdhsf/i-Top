//
//  MessageStore.m
//  itop
//
//  Created by huangli on 2018/3/11.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MessageStore.h"

@implementation MessageStore

+ (instancetype)shearMessageStore{
    
    static MessageStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[MessageStore alloc]init];
    });
    return store;

}

-(NSMutableArray *)configurationUserMessegeMenuWithMenu:(NSArray *)arr{
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        
        UserMessege *messege = [[UserMessege alloc]initWithDictionary:dic error:nil];
        [array addObject:messege];
    }
    return array;
}

@end
