//
//  BiddingProductListViewController.m
//  itop
//
//  Created by huangli on 2018/4/27.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BiddingProductListViewController.h"
#import "BiddingProductListCell.h"
#import "BiddingProduct.h"
#import "BiddingProductListStore.h"
#import "BiddingProductListDataSource.h"
#import "UploadProductDetailViewController.h"

static NSString *const BiddingProductListCellIdentifier = @"BiddingProductListCell";

@interface BiddingProductListViewController ()

@property (strong, nonatomic)BiddingProductListDataSource *biddingProductListDataSource;

@end

@implementation BiddingProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initData{
    
    [super initData];
    [[UserManager shareUserManager]biddingProductListWithId:_demant_id ];
    [UserManager shareUserManager].customRequirementsSuccess = ^(NSArray * arr){
        
        if (arr.count == 0) {
            
            self.originY = 30;
            [self setHasData:NO];
            
        } else {
            
            self.dataArray = [[BiddingProductListStore shearBiddingProductListStore]configurationBiddingProductListWithRequsData:arr];
            [self steupTableView];

        }
    };
}

-(void)initView{
    
    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ScreenHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.bottom.left.right.mas_equalTo(self.view);
        //        make.bottom.mas_equalTo();
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake( 0, 0, 100, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(BiddingProductListCell *cell , BiddingProduct *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item ];
    };
    self.biddingProductListDataSource = [[BiddingProductListDataSource alloc]initWithItems:self.dataArray cellIdentifier:BiddingProductListCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.biddingProductListDataSource
                        cellIdentifier:BiddingProductListCellIdentifier
                               nibName:@"BiddingProductListCell"];
    
    self.tableView.dataSource = self.biddingProductListDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"BiddingProductListCell"] forCellReuseIdentifier:BiddingProductListCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return 83;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    BiddingProduct *productDetail = [self.biddingProductListDataSource itemAtIndexPath:indexPath];
    UploadProductDetailViewController *vc = [[UploadProductDetailViewController  alloc]init];
    vc.productDetail = productDetail;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
