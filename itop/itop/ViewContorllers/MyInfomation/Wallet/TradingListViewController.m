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
#import "EarningDetailViewController.h"

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
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ScreenHeigh-40)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.bottom.left.right.mas_equalTo(self.view);
        
    }];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

-(void)initNavigationBarItems{
    
    self.title = @"交易记录";
}

-(void)initData{
    
    [super initData];
    [self showRefresh];
}

-(void)refreshData{
    
    [[UserManager shareUserManager] tradingListWithPageIndex:self.page_no PageCount:10];
    [UserManager shareUserManager].tradingListSuccess = ^(NSArray *arr){
        
        if (arr.count == 0) {
            
            self.noDataType = NoDataTypeDefult;
            self.originY = 50;
        }
        [self listDataWithListArray:[[TradingListStore shearTradingListStore]configurationTradingListMenuWithUserInfo:arr] page:self.page_no];
        [self steupTableView];
    };
    
    [UserManager shareUserManager].errorFailure = ^ (id obj){
        
        [self tableViewEndRefreshing];
    };
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    TradingList *tradingList = [self.tradingListDataSource itemAtIndexPath:indexPath];
    
    EarningDetailViewController *vc = [[EarningDetailViewController alloc]init];
    vc.tradingList = tradingList;
    vc.detailType = DetailTypeTradingList;
    [UIManager pushVC:vc];
    //    [self.navigationController pushViewController:vc animated:YES];
    //    _parent_id = comment.id;
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
