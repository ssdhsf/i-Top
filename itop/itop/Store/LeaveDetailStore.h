//
//  LeaveDetailStore.h
//  itop
//
//  Created by huangli on 2018/2/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeaveDetailStore : NSObject

+ (instancetype)shearLeaveDetailStore;
- (NSMutableArray *)configurationMenuWithMenu:(Leave *)menu;

@end
