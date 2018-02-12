//
//  BaseTableViewController.m
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseTableViewController.h"

#define KCELLDEFAULTHEIGHT 44

@interface BaseTableViewController ()

@property (nonatomic, readonly) UITableViewStyle style;
@property (nonatomic, strong)   ApplicationTableViewDataSource *dataSource;

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (instancetype)initWithStyle:(UITableViewStyle)style{
    
    self = [super init];
    if (self) {
        _style = style;
    }
    return self;
}

-(void)initView{
    
    [super initView];
}

- (void)initData{
    
    [super initData];
    _showRefreshHeader = NO;
    _showRefreshFooter = NO;
    _showTableBlankView = NO;
}

- (void)showRefresh{
    
    _showRefreshHeader = YES;
    _showRefreshFooter = YES;
    _showTableBlankView = YES;
}

- (void)tableViewEndRefreshing {
    
    [self.tableView.footer endRefreshing];
    [self.tableView.header endRefreshing];
}

- (void)tableViewbeginRefreshing {
    
    [self.tableView.header beginRefreshing];
}

/**
 *  上拉刷新数据
 */
- (void)tableViewDidTriggerHeaderRefresh {
    
    self.page_no = 1;
    [self refreshData];
    
}

/**
 *  下拉刷新数据
 */
- (void)tableViewDidTriggerFooterRefresh {
    
    self.page_no  ++;
    [self refreshData];
    
}

- (NSMutableArray *)dataArray {
    
    if (_dataArray == nil) {
        
        self.dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)refreshData{
    
    // subClass execute
}


- (void)initTableViewWithFrame:(CGRect )frame{
    
    _tableView = [[UITableView alloc] initWithFrame:frame style:self.style];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [[Global sharedSingleton] setExtraCellLineHidden:_tableView];
    if (_showRefreshHeader) {
        __weak typeof(self) weakSelf = self;
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:weakSelf refreshingAction:@selector(tableViewDidTriggerHeaderRefresh)];
        // 触发刷新（加载数据）
        [self tableViewbeginRefreshing];
    }
    
    if (_showRefreshFooter) {
        __weak typeof(self) weakSelf = self;
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:weakSelf refreshingAction:@selector(tableViewDidTriggerFooterRefresh)];
    }
}


- (void)steupTableViewWithDataSource:(ApplicationTableViewDataSource *)dataSource
                      cellIdentifier:(NSString *)identifier
                             nibName:(NSString *)nibName{
    
    self.tableView.dataSource = dataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:nibName] forCellReuseIdentifier:identifier];
    [ self.tableView reloadData];
//    [self tableViewEndRefreshing];

//    if (self.segmentedTitleArray.count != 0) {
//        [ self.tableView reloadData];
//        [self tableViewEndRefreshing];
//        SegmentedControlIndexModel *segmented = self.segmentedModelArray[self.segmented.selectedSegmentIndex];
//        if (segmented.dataArray.count / segmented.pageNo == 10) {
//            
//            self.tableView.footer.hidden = NO;
//        } else {
//            
//            self.tableView.footer.hidden = YES;
//        }
//    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
