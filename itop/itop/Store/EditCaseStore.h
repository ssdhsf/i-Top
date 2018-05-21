//
//  EditCaseStore.h
//  itop
//
//  Created by huangli on 2018/5/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditCaseStore : NSObject

+ (instancetype)shearEditCaseStore;

- (NSMutableArray *)configurationEditCaseStoreWithRequsData:(NSArray *)arr;
@end
