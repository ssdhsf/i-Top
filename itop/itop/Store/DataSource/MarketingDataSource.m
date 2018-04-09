//
//  MarketingDataSource.m
//  itop
//
//  Created by huangli on 2018/2/28.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MarketingDataSource.h"

@implementation MarketingDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.items.count;
}


@end
