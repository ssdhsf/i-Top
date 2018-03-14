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

-(NSMutableArray *)configurationSetupMenuWithMenu:(NSArray *)arr{
    
    return nil;
}

@end
