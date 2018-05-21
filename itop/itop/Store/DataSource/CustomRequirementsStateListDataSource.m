//
//  CustomRequirementsStateListDataSource.m
//  itop
//
//  Created by huangli on 2018/4/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomRequirementsStateListDataSource.h"
#import "CustomRequirementsStateListCell.h"

@implementation CustomRequirementsStateListDataSource


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (!cell) {
       
        cell =[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CustomRequirementsStateListCell class]) owner:self options:nil].lastObject ;
// [[CustomRequirementsStateListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.cellIdentifier];
    }

//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item, indexPath);
    return cell;
}

@end
