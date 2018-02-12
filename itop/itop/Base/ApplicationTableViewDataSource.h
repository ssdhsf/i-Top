//
//  ApplicationDataSource.h
//  xixun
//
//  Created by huangli on 2016/12/1.
//  Copyright © 2016年 3N. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id data, id indexPath);

@interface ApplicationTableViewDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSString *)aCellIdentifier
           cellConfigureBlock:(TableViewCellConfigureBlock)aConfigureBlock;

-(id)itemAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
