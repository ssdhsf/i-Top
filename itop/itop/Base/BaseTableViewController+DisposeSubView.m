//
//  BaseTableViewController+DisposeSubView.m
//  itop
//
//  Created by huangli on 2018/1/31.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseTableViewController+DisposeSubView.h"

@implementation BaseTableViewController (DisposeSubView)

- (void)listDataWithListArray:(NSArray *)arr page:(NSInteger)page{
    
    if (arr.count == 0 && page == 1) {
        
        [self setHasData:NO];
        
    } else  if(arr.count == 0 && page != 1){
        
        [self setHasData:YES];
        [[Global sharedSingleton] showToastInCenter:self.view withMessage:@"数据加载完毕"];
        
    } else {
        
        [self setHasData:YES];
        if (page == 1) {
            
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:arr];
            
        } else {
            
            [self.dataArray addObjectsFromArray:arr];
        }
    }
    
    if (self.dataArray.count / page != 10 ) {
        self.tableView.footer.hidden = YES;
    }else {
        self.tableView.footer.hidden = NO;
    }
    [self tableViewEndRefreshing];
    [ self.tableView reloadData];
}

@end
