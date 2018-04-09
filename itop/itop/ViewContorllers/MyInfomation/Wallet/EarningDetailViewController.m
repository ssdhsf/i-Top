//
//  EarningDetailViewController.m
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "EarningDetailViewController.h"
#import "TradingListStore.h"
#import "EarningDetailTableViewCell.h"
#import "EarningDetailDataSource.h"

static NSString *const EarningDetailCellIdentifier = @"EarningDetail";

@interface EarningDetailViewController ()

@property(strong, nonatomic)EarningDetailDataSource *earningDetailDataSource;
@end

@implementation EarningDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initView{
    
    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ScreenHeigh-40)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.bottom.left.right.mas_equalTo(self.view);
        
    }];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self steupTableView];
    [self.tableView reloadData];
}

-(void)initData{
    
    [super initData];
    
    if (_detailType == DetailTypeEarningList) {
        
        self.dataArray = [[TradingListStore shearTradingListStore]configurationEarningDetailMenuWithUserInfo:_earningList];
    }else {
        
        self.dataArray = [[TradingListStore shearTradingListStore]configurationTradingDetailMenuWithUserInfo:_tradingList];
    }
}

-(void)initNavigationBarItems{
    
    if (_detailType == DetailTypeEarningList) {
        self.title = @"收益详情";
    }else {
        self.title = @"交易详情";
    }
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(EarningDetailTableViewCell *cell , Infomation *item , NSIndexPath *indexPath){
        
        [cell setItmeOfEarningDetailModel:item indexPath:indexPath];
    };
    self.earningDetailDataSource = [[EarningDetailDataSource alloc]initWithItems:self.dataArray cellIdentifier:EarningDetailCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.earningDetailDataSource
                        cellIdentifier:EarningDetailCellIdentifier
                               nibName:@"EarningDetailTableViewCell"];
    
    self.tableView.dataSource = self.earningDetailDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"EarningDetailTableViewCell"] forCellReuseIdentifier:EarningDetailCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
      
        return 64;
    }
    return 44;
}

@end
