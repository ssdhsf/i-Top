//
//  BaseCollectionViewController.m
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initView{
    
    [super initView];
}

-(void)initData{
    
    [super initData];
    _showRefreshHeader = NO;
    _showRefreshFooter = NO;
    _showTableBlankView = NO;
    
}

- (NSMutableArray *)dataArray {
    
    if (_dataArray == nil) {
        
        self.dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)collectionViewDidTriggerHeaderRefresh{
    
    self.page_no = 1;
    [self refreshData];
}

- (void)collectionViewDidTriggerFooterRefresh{
    
    self.page_no ++;
    [self refreshData];
}

- (void)refreshData{
    
    // subClass execute
}

- (void)showRefresh{
    
    _showRefreshHeader = YES;
    _showRefreshFooter = YES;
    _showTableBlankView = YES;
}

- (void)tableViewEndRefreshing {
    
    [self.collectionView.footer endRefreshing];
    [self.collectionView.header endRefreshing];
}

- (void)tableViewbeginRefreshing {
    
    [self.collectionView.header beginRefreshing];
}

- (void)initCollectionViewWithFrame:(CGRect )frame
                         flowLayout:(UICollectionViewFlowLayout *)flowLayout{
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = UIColor.whiteColor;
    //    UINib *cellNib = [UINib nibWithNibName:@"HomeItemCollectionViewCell" bundle:nil];
    //    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"HomeItemCollectionViewCell"];
    [self.view addSubview:_collectionView];
    if (_showRefreshHeader) {
        __weak typeof(self) weakSelf = self;
        _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:weakSelf refreshingAction:@selector(collectionViewDidTriggerHeaderRefresh)];
        // 触发刷新（加载数据）
        [self collectionBeginRefreshing];
    }
    
    if (_showRefreshFooter) {
        __weak typeof(self) weakSelf = self;
        _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:weakSelf refreshingAction:@selector(collectionViewDidTriggerFooterRefresh)];
    }
}

- (void)steupCollectionViewWithDataSource:(ApplicationCollectionViewDataSource *)dataSource
                           cellIdentifier:(NSString *)identifier
                                  nibName:(NSString *)nibName{
    
    self.collectionView.dataSource = dataSource;
    [self.collectionView registerNib:[[UIManager sharedUIManager]nibWithNibName:nibName] forCellWithReuseIdentifier:identifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
    
    [ self.collectionView reloadData];
    //    [self collectionEndRefreshing];
}


- (void)collectionEndRefreshing{
    
    [self.collectionView.footer endRefreshing];
    [self.collectionView.header endRefreshing];
}

- (void)collectionBeginRefreshing{
    
    [self.collectionView.header beginRefreshing];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *HeaderIdentifier = @"UICollectionViewCell";
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:HeaderIdentifier
                                                                                   forIndexPath:indexPath];
    
    // Configure the headView...
    return headView;
    
}


@end

