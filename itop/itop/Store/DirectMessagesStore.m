//
//  DirectMessagesStore.m
//  itop
//
//  Created by huangli on 2018/3/28.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DirectMessagesStore.h"

@implementation DirectMessagesStore

+ (instancetype)shearDirectMessagesStore{
    
    static DirectMessagesStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[DirectMessagesStore alloc]init];
    });
    return store;
}

-(NSMutableArray *)configurationDirectMessagesMenuWithMenu:(NSArray *)arr{
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        
        DirectMessages *messege = [[DirectMessages alloc]initWithDictionary:dic error:nil];
        [array addObject:messege];
    }

    for (int i = 0; i<array.count; i++) {
        
        for (int j = 0; j<array.count- 1-i; j++) {
            
            if ([self compareMessagesSendTimeWithMessages:array[j] lastMessage:array[j+1]]) {
                
                DirectMessages * temp = array[j];
                array[j] = array[j+1];
                array[j+1] = temp;
            }
        }
    }
    return array;
}

-(BOOL)compareMessagesSendTimeWithMessages:(DirectMessages *)firstMessage lastMessage:(DirectMessages *)lastMessage{
    
    NSInteger first = [[NSNumber numberWithDouble:[[[Global sharedSingleton] dateFromString:firstMessage.create_datetime pattern:TIME_PATTERN_second] timeIntervalSince1970]] integerValue];
    
    NSInteger last = [[NSNumber numberWithDouble:[[[Global sharedSingleton] dateFromString:lastMessage.create_datetime pattern:TIME_PATTERN_second] timeIntervalSince1970]] integerValue];
    
    if (first < last) {
        return NO;
    } else {
        return YES;
    }

}


@end
