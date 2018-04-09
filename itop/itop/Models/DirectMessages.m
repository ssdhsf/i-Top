//
//  DirectMessages.m
//  itop
//
//  Created by huangli on 2018/3/28.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DirectMessages.h"

@implementation DirectMessages

//+ (id)directMessagesWithDirectMessages:(DirectMessages *)messages {
//    // 这里最好写[self class]
//    DirectMessages *directMessages = [[[self class] alloc] init];
//    directMessages = messages;
//    return directMessages;
//}

- (id)mutableCopyWithZone:(struct _NSZone *)zone{
    
    DirectMessages *copy = [[[self class] allocWithZone:zone] init];
    
    // 拷贝名字给副本对象
    copy = self;
    return copy;
}

@end
