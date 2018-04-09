//
//  DirectMessagesStore.h
//  itop
//
//  Created by huangli on 2018/3/28.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectMessagesStore : NSObject

+ (instancetype)shearDirectMessagesStore;

-(NSMutableArray *)configurationDirectMessagesMenuWithMenu:(NSArray *)arr;

@end
