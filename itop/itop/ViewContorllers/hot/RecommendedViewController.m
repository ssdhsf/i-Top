//
//  RecommendedViewController.m
//  itop
//
//  Created by huangli on 2018/1/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "RecommendedViewController.h"
#import "RecommendedStore.h"
#import "RecommendedDataSource.h"
#import "RecommendedTableViewCell.h"
#import "H5ListStore.h"
#import "HotDetailsViewController.h"

static NSString *const RecommendedCellIdentifier = @"Recommended";

@interface RecommendedViewController ()

@property (nonatomic, strong)RecommendedDataSource *recommendedDataSource;

@end

@implementation RecommendedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    
    NSLog(@"%f",self.view.frame.size.height);
    
    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ViewHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self steupTableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.top.mas_equalTo(self.view);
    }];
}

-(void)initData{
    
    [super initData];
    [self showRefresh];
}

-(void)setItmeType:(NSString *)itmeType{
    
    _itmeType = itmeType;
}

- (void)refreshData{
    
    [[UserManager shareUserManager]hotListWithType:[_itmeType isEqualToString:@"资讯"] ? ArticleTypeDefault :ArticleTypeOther
                                         PageIndex:self.page_no
                                         PageCount:10
                                getArticleListType: _getArticleListType];
    [UserManager shareUserManager].hotlistSuccess = ^(NSArray * obj){
        
        NSLog(@"%@",obj);
        
        [self listDataWithListArray:[[H5ListStore shearH5ListStore] configurationMenuWithMenu:obj] page:self.page_no];
    };
    
    [UserManager shareUserManager].errorFailure = ^ (id obj){
        
        [self tableViewEndRefreshing];
    };
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(RecommendedTableViewCell *cell , H5List *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item getArticleListType:_getArticleListType];
    };
    self.recommendedDataSource = [[RecommendedDataSource alloc]initWithItems:self.dataArray cellIdentifier:RecommendedCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.recommendedDataSource
                        cellIdentifier:RecommendedCellIdentifier
                               nibName:@"RecommendedTableViewCell"];
    
    self.tableView.dataSource = self.recommendedDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"RecommendedTableViewCell"] forCellReuseIdentifier:RecommendedCellIdentifier];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%f",(ScreenHeigh-65)/3);
    return (ScreenHeigh-65)/3;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    H5List *h5list = [_recommendedDataSource itemAtIndexPath:indexPath];
    
    _pushControl(h5list.id);
    
}


@end
