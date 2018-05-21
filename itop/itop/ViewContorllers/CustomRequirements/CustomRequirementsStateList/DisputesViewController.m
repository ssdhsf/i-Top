//
//  DisputesViewController.m
//  itop
//
//  Created by huangli on 2018/5/2.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DisputesViewController.h"
#import "DisputesTableViewCell.h"
#import "DisputesStore.h"
#import "DisputesDataSource.h"

static NSString *const DisputesCellIdentifier = @"Disputes";

@interface DisputesViewController ()

@property (strong, nonatomic)DisputesDataSource *disputesDataSource;
@property (weak, nonatomic) IBOutlet UIButton *addDisputes;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation DisputesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    
    [super initData];
    [self showRefresh];
}

-(void)initNavigationBarItems{
    
    self.title = @"平台介入";
}

-(void)refreshData{
    
    [[UserManager shareUserManager]demandDemanddisputeListWithId:_demant_id pageIndex:1 pageCount:10 ];
    [UserManager shareUserManager].customRequirementsSuccess = ^(NSArray * arr){
        
        [self listDataWithListArray: [[DisputesStore shearDisputesStore]configurationDisputesWithRequsData:arr] page:self.page_no];
        [self steupTableView];
    };
    
    [UserManager shareUserManager].errorFailure = ^(id obj){
        
        [self tableViewEndRefreshing];
    };
}

-(void)initView{
    
    [super initView];
    
    CGFloat orige = 0;
    if (_message != nil) {
        
        orige = [Global  heightWithString:_message width:ScreenWidth-60 fontSize:17];
        _titleLabel.frame = CGRectMake(30, 25, ScreenWidth-60, orige+10);
        _titleLabel.text = _message;
    }
    
    if (orige > 0) {
        
        orige = orige + 50;
    }
    
    [self initTableViewWithFrame:TableViewFrame(0, orige, ScreenWidth, ScreenHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(orige);
        make.bottom.mas_equalTo(kDevice_Is_iPhoneX ? -135 : 100);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [_addDisputes.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_addDisputes)];
    _addDisputes.layer.masksToBounds = YES;
    _addDisputes.layer.cornerRadius = _addDisputes.height/2;
}


- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(DisputesTableViewCell *cell , Disputes *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item ];
    };
    self.disputesDataSource = [[DisputesDataSource alloc]initWithItems:self.dataArray cellIdentifier:DisputesCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.disputesDataSource
                        cellIdentifier:DisputesCellIdentifier
                               nibName:@"DisputesTableViewCell"];
    
    self.tableView.dataSource = self.disputesDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"DisputesTableViewCell"] forCellReuseIdentifier:DisputesCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Disputes *disputes = [self.disputesDataSource itemAtIndexPath:indexPath];
    CGFloat passableHeight = [Global heightWithString:disputes.question width:ScreenWidth-100 fontSize:15];
     CGFloat remarkleHeight = [Global heightWithString:disputes.remark width:ScreenWidth-100 fontSize:15];
    
    return 80 +remarkleHeight+passableHeight+62;
}

- (IBAction)addDisputes:(UIButton *)sender {
    
     [UIManager submitDisputesViewControllerWithCustomId:_demant_id];
}



@end
