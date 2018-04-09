//
//  ApplicationDataSource.m
//  xixun
//
//  Created by huangli on 2016/12/1.
//  Copyright © 2016年 3N. All rights reserved.
//

#import "ApplicationTableViewDataSource.h"

@interface ApplicationTableViewDataSource ()

@end

@implementation ApplicationTableViewDataSource

-(instancetype)init{
    
    return nil;
}

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSString *)aCellIdentifier
           cellConfigureBlock:(TableViewCellConfigureBlock)aConfigureBlock{
    
    self = [super init];
    
    if (self) {
        
        self.items = items;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = [aConfigureBlock copy];
    }
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.items[0] isKindOfClass:[NSArray class]]) {
        return self.items[indexPath.section][indexPath.row];
    } else {
        
        return self.items[indexPath.row];
    }
    return self.items[indexPath.row];
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.items.count == 0)  return 0;
    
    if ([self.items[0] isKindOfClass:[NSArray class]]) {
        return [self.items[section] count];
    } else {
        
        return self.items.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item, indexPath);
    return cell;
}

@end
