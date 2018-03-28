//
//  PopularizeStore.h
//  itop
//
//  Created by huangli on 2018/3/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ApplicationTableViewDataSource.h"

@interface PopularizeStore : NSObject


+ (instancetype)shearPopularizeStore;

-(NSMutableArray *)configurationPopularizeWithMenu:(NSArray *)arr;


@end
