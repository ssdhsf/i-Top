//
//  LeaveStore.h
//  itop
//
//  Created by huangli on 2018/2/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeaveStore : NSObject

+ (instancetype)shearLeaveStore;
- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu testString:(NSString *)testString;

@end
