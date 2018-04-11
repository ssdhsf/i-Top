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
@property (strong, nonatomic) IBOutlet UIView *headView;

@end

@implementation PopularizeItmeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}


-(void)initNavigationBarItems{
    
    self.title = @"推广管理";
}

-(void)initView{
    
    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ScreenHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.bottom.left.right.mas_equalTo(self.view);
    }];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self steupTableView];
    self.tableView.tableHeaderView = _headView;

}

-(void)initData{
    
    [super initData];
    [self showRefresh];
}

-(void)refreshData{
    
    [[UserManager shareUserManager]popularizeListWithUserId:[[UserManager shareUserManager]crrentUserId]
                                                orderStatus:_orderStatus
                                                  PageIndex:self.page_no
                                                  PageCount:10];
    [UserManager shareUserManager].popularizeSuccess = ^(NSArray * arr){
        
        [self listDataWithListArray: [[PopularizeStore shearPopularizeStore]configurationPopularizeWithMenu:arr] page:self.page_no];
    };
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(PopularizeTableViewCell *cell , Popularize *item , NSIndexPath *indexPath){
        
        [cell setItmeOfPopularizeModel:item];
        cell.orderManagementBolck = ^(PopularizeTableViewCell *cell , UIButton *selectButton){
          
            NSIndexPath *index = [self.tableView indexPathForCell:cell];
            Popularize *pop = [self.popularizeDataSource itemAtIndexPath:index];
            
            if ([selectButton.titleLabel.text  isEqualToString:@"删除"]) {
                
                [[UserManager shareUserManager]deletePopularizeWithOrderId:pop.id];
                [UserManager shareUserManager].popularizeSuccess = ^(id obj){
                    
                    [self refreshData];
                    NSLog(@"%@",obj);
                };
            }
            
            if ([selectButton.titleLabel.text  isEqualToString:@"完成"] || [selectButton.titleLabel.text  isEqualToString:@"取消"]) {
                
                [[UserManager shareUserManager]updataOrderStatePopularizeWithOrderId:pop.id state:[selectButton.titleLabel.text  isEqualToString:@"完成"]?OrderStatusTypeSucess : OrderStatusTypeCanceled];
                [UserManager shareUserManager].popularizeSuccess = ^(id obj){
                    
                    [self refreshData];
                    NSLog(@"%@",obj);
                };
            }
            
            if ([selectButton.titleLabel.text  isEqualToString:@"接单"] || [selectButton.titleLabel.text  isEqualToString:@"拒绝"]) {
                
                [[UserManager shareUserManager]popularizeIsAcceptWithOrderId:pop.id isAccept:[selectButton.titleLabel.text  isEqualToString:@"接单"]? @1 : @0];
                [UserManager shareUserManager].popularizeSuccess = ^(id obj){
                    
                    [self refreshData];
                    NSLog(@"%@",obj);
                };
            }
            
            if ([selectButton.titleLabel.text  isEqualToString:@"评价"]) {
                
                [UIManager showVC:@"CommentPopularizeViewController"];
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
