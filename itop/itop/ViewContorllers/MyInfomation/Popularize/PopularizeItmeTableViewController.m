//
//  PopularizeItmeTableViewController.m
//  itop
//
//  Created by huangli on 2018/3/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "PopularizeItmeTableViewController.h"
#import "PopularizeTableViewCell.h"
#import "PopularizeStore.h"
#import "PopularizeDataSource.h"
#import "YYGestureRecognizer.h"
#import "CommentPopularizeViewController.h"

static NSString *const PopularizeCellIdentifier = @"Popularize";

@interface PopularizeItmeTableViewController ()

@property (nonatomic, strong)PopularizeDataSource *popularizeDataSource;
@property (nonatomic, strong)PopularizeAllCount *popularizeAllCount;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *allItemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *allItemLabel;

@property (weak, nonatomic) IBOutlet UILabel *itemTitle1Label;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle2Label;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle3Label;

@property (weak, nonatomic) IBOutlet UILabel *item1Label;
@property (weak, nonatomic) IBOutlet UILabel *item2Label;
@property (weak, nonatomic) IBOutlet UILabel *item3Label;

@end

@implementation PopularizeItmeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:!_isHome];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initNavigationBarItems{
    
    self.title = @"推广管理";
    
    if (_isHome) {
        
        [self setLeftCustomBarItem:@"" action:nil];
    }
}

-(void)initView{
    
    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ScreenHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.bottom.left.right.mas_equalTo(self.view);
    }];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([[UserManager shareUserManager]crrentUserType] == UserTypeEnterprise) {
        
        self.itemTitle1Label .text = @"总费用";
        self.itemTitle2Label .text = @"总浏览";
        self.itemTitle2Label .text = @"总留资";
        self.allItemTitleLabel .text = @"总转发量";
    } else {
    
        self.itemTitle1Label .text = @"订单数";
        self.itemTitle2Label .text = @"总转发";
        self.itemTitle3Label .text = @"总浏览";
        self.allItemTitleLabel .text = @"收益";
    }
    [self steupTableView];
}

-(void)initData{
    
    [super initData];
    [self showRefresh];
    
    [[UserManager shareUserManager]popularizeStatisticsCountWithUserId:[[UserManager shareUserManager]crrentUserId]];
    [UserManager shareUserManager].popularizeSuccess = ^(id obj){
        
        _popularizeAllCount = [[PopularizeAllCount alloc]initWithDictionary:obj error:nil];
        
        if ([[UserManager shareUserManager]crrentUserType] == UserTypeEnterprise) {
            
            self.item1Label .text = [Global stringIsNullWithString:_popularizeAllCount.reward_count]? @"0" : _popularizeAllCount.reward_count ;
            self.item2Label .text = [Global stringIsNullWithString:_popularizeAllCount.browse_count]? @"0" :_popularizeAllCount.browse_count;
            self.item3Label .text = [Global stringIsNullWithString:_popularizeAllCount.register_count]? @"0" :_popularizeAllCount.register_count;
            self.allItemLabel .text = [Global stringIsNullWithString:_popularizeAllCount.share_count]? @"0" :_popularizeAllCount.share_count;
        } else {
            
            self.item1Label .text = [Global stringIsNullWithString:_popularizeAllCount.rows_count]? @"0" :_popularizeAllCount.rows_count;
            self.item2Label .text = [Global stringIsNullWithString:_popularizeAllCount.share_count]? @"0" :_popularizeAllCount.share_count;
            self.item3Label .text = [Global stringIsNullWithString:_popularizeAllCount.browse_count]? @"0" :_popularizeAllCount.browse_count;
            self.allItemLabel .text = [Global stringIsNullWithString:_popularizeAllCount.reward_count]? @"0" :_popularizeAllCount.reward_count;
        }
    };
}

-(void)refreshData{
    
    [[UserManager shareUserManager]popularizeListWithUserId:[[UserManager shareUserManager]crrentUserId]
                                                orderStatus:_orderStatus
                                                  PageIndex:self.page_no
                                                  PageCount:10];
    [UserManager shareUserManager].popularizeSuccess = ^(NSArray * arr){
        
        [self listDataWithListArray: [[PopularizeStore shearPopularizeStore]configurationPopularizeWithMenu:arr] page:self.page_no];

        self.tableView.tableHeaderView = _headView;
        [self steupTableView];

    };
}

- (void)steupTableView{
    
    __weak typeof(self) WeakSrelf = self;
    
    TableViewCellConfigureBlock congfigureCell = ^(PopularizeTableViewCell *cell , Popularize *item , NSIndexPath *indexPath){
        
        [cell setItmeOfPopularizeModel:item];
        cell.orderManagementBolck = ^(PopularizeTableViewCell *cell , UIButton *selectButton){
          
            NSIndexPath *index = [self.tableView indexPathForCell:cell];
            Popularize *pop = [self.popularizeDataSource itemAtIndexPath:index];
            
            if ([selectButton.titleLabel.text  isEqualToString:@"删除"]) {
                
                [[UserManager shareUserManager]deletePopularizeWithOrderId:pop.id];
                [UserManager shareUserManager].popularizeSuccess = ^(id obj){
                    
                    [WeakSrelf refreshData];
                    NSLog(@"%@",obj);
                };
            }
            
            if ([selectButton.titleLabel.text  isEqualToString:@"完成"] || [selectButton.titleLabel.text  isEqualToString:@"取消"]) {
                
                [[UserManager shareUserManager]updataOrderStatePopularizeWithOrderId:pop.id state:[selectButton.titleLabel.text  isEqualToString:@"完成"]?OrderStatusTypeSucess : OrderStatusTypeCanceled];
                [UserManager shareUserManager].popularizeSuccess = ^(id obj){
                    
                    [WeakSrelf refreshData];
                    NSLog(@"%@",obj);
                };
            }
            
            if ([selectButton.titleLabel.text  isEqualToString:@"接单"] || [selectButton.titleLabel.text  isEqualToString:@"拒绝"]) {
                
                [[UserManager shareUserManager]popularizeIsAcceptWithOrderId:pop.id isAccept:[selectButton.titleLabel.text  isEqualToString:@"接单"]? @1 : @0];
                [UserManager shareUserManager].popularizeSuccess = ^(id obj){
                    
                    [WeakSrelf refreshData];
                    NSLog(@"%@",obj);
                };
            }
            
            if ([selectButton.titleLabel.text  isEqualToString:@"评价"]) {
                
                [UIManager commentPopularizeViewControllerWithCustomId:pop.id commentType:CommentTypePopularize];
//                CommentPopularizeViewController *vc = [[CommentPopularizeViewController alloc]init];
//                vc.popularize_id = pop.id;
//
//                [UIManager pushVC:vc];
                [UIManager sharedUIManager].commentPopularizeBackOffBolck = ^ (id obj){
                    
                     [WeakSrelf refreshData];
                };
            }
        };
    };
    self.popularizeDataSource = [[PopularizeDataSource alloc]initWithItems:self.dataArray cellIdentifier:PopularizeCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.popularizeDataSource
                        cellIdentifier:PopularizeCellIdentifier
                               nibName:@"PopularizeTableViewCell"];
    
    self.tableView.dataSource = self.popularizeDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"PopularizeTableViewCell"] forCellReuseIdentifier:PopularizeCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 99;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y ;
    
    if ([self.delegate respondsToSelector:@selector(updateScrollerViewFrameWithTableViewContentOffset:)]) {
        
        [self.delegate updateScrollerViewFrameWithTableViewContentOffset:offsetY];
    }
}

@end
