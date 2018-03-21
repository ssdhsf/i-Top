//
//  EarningListViewController.m
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "EarningListViewController.h"
#import "TradingListTableViewCell.h"
#import "TradingListStore.h"
#import "TradingListDataSource.h"
#import "EarningDetailViewController.h"

static NSString *const EarningListCellIdentifier = @"EarningList";

@interface EarningListViewController ()

@property(strong, nonatomic)TradingListDataSource *tradingListDataSource;

@end

@implementation EarningListViewController

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

-(void)initData{
    
    [super initData];
    [self showRefresh];
}

-(void)initNavigationBarItems{
    
    self.title = @"收益记录";
}

-(void)refreshData{
    
    [[UserManager shareUserManager] earningListWithPageIndex:self.page_no PageCount:10];
    [UserManager shareUserManager].earningListSuccess = ^(NSArray *arr){
        
        if (arr.count == 0) {
            
            self.noDataType = NoDataTypeDefult;
            self.originY = 50;
        }
        [self listDataWithListArray:[[TradingListStore shearTradingListStore]configurationEarningListMenuWithUserInfo:arr] page:self.page_no];
        [self steupTableView];
    };
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(TradingListTableViewCell *cell , EarningList *item , NSIndexPath *indexPath){
        
        [cell setItmeOfEarningListModel:item];
    };
    self.tradingListDataSource = [[TradingListDataSource alloc]initWithItems:self.dataArray cellIdentifier:EarningListCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.tradingListDataSource
                        cellIdentifier:EarningListCellIdentifier
                               nibName:@"TradingListTableViewCell"];
    
    self.tableView.dataSource = self.tradingListDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"TradingListTableViewCell"] forCellReuseIdentifier:EarningListCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    EarningList *earningList = [self.tradingListDataSource itemAtIndexPath:indexPath];
    
    EarningDetailViewController *vc = [[EarningDetailViewController alloc]init];
    vc.earningList = earningList;
    [UIManager pushVC:vc];
//    [self.navigationController pushViewController:vc animated:YES];
//    _parent_id = comment.id;
}




@end
