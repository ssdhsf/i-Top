//
//  LeaveDetailViewController.m
//  itop
//
//  Created by huangli on 2018/2/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "LeaveDetailViewController.h"
#import "LeaveDateilCell.h"
#import "LeaveDetailStore.h"
#import "LeaveDetailDataSource.h"

static NSString *const LeaveDetailCellIdentifier = @"LeaveDetail";

@interface LeaveDetailViewController ()

@property(nonatomic, strong)LeaveDetailDataSource *leaveDetailDataSource;

@end

@implementation LeaveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)initData{
    
    self.dataArray = [[LeaveDetailStore shearLeaveDetailStore]configurationMenuWithMenu:nil ];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initNavigationBarItems{
    
    self.title = @"留资详情";
//    [self setupNavigationItemTintWithTint:MANAGEMENT];
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)steupTableView{
    
//    __weak typeof(self) weakSelf = self;
    TableViewCellConfigureBlock congfigureCell = ^(LeaveDateilCell *cell , LeaveDetail *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item ];
        
        };
    self.leaveDetailDataSource = [[LeaveDetailDataSource alloc]initWithItems:self.dataArray cellIdentifier:LeaveDetailCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.leaveDetailDataSource
                        cellIdentifier:LeaveDetailCellIdentifier
                               nibName:@"LeaveDateilCell"];
    
    self.tableView.dataSource = self.leaveDetailDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"LeaveDateilCell"] forCellReuseIdentifier:LeaveDetailCellIdentifier];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ( indexPath.row == 0) {
        
        return 70;
    } else {
        LeaveDetail *leave = [_leaveDetailDataSource itemAtIndexPath:indexPath];
        NSInteger content = [Global heightWithString:leave.content width:ScreenWidth-113 fontSize:15];
        
        return content +30;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
