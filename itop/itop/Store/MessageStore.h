//
//  MessageStore.h
//  itop
//
//  Created by huangli on 2018/3/11.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageStore : NSObject

+ (instancetype)shearMessageStore;

-(NSMutableArray *)configurationUserMessegeMenuWithMenu:(NSArray *)arr;

@end
