//
//  TradingListViewController.m
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "TradingListViewController.h"
#import "TradingListTableViewCell.h"
#import "TradingListStore.h"
#import "TradingListDataSource.h"

static NSString *const TradingListCellIdentifier = @"TradingList";

@interface TradingListViewController ()

@property(strong, nonatomic)TradingListDataSource *tradingListDataSource;

@end

@implementation TradingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    
    [super initView];
}

-(void)initData{
    
    [super initData];
    [self showRefresh];
}

-(void)refreshData{
    
    
    
    
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(TradingListTableViewCell *cell , TradingList *item , NSIndexPath *indexPath){
        
        [cell setItmeOfTradingListModel:item];
    };
    self.tradingListDataSource = [[TradingListDataSource alloc]initWithItems:self.dataArray cellIdentifier:TradingListCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.tradingListDataSource
                        cellIdentifier:TradingListCellIdentifier
                               nibName:@"TradingListTableViewCell"];
    
    self.tableView.dataSource = self.tradingListDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"TradingListTableViewCell"] forCellReuseIdentifier:TradingListCellIdentifier];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
