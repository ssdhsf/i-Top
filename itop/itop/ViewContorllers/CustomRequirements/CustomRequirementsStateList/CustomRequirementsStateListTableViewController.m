//
//  CustomRequirementsStateListTableViewController.m
//  itop
//
//  Created by huangli on 2018/4/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomRequirementsStateListTableViewController.h"
#import "CustomRequirementsStateListCell.h"
#import "CustomRequirementsStateListDataSource.h"
#import "CustomRequirementsStore.h"
#import "DirectionalDemandReleaseViewController.h"
#import "CustomRequirementsStateDetailViewController.h"

static NSString *const CustomRequirementsStateListCellIdentifier = @"CustomRequirementsStateListCell";

@interface CustomRequirementsStateListTableViewController ()

@property (strong, nonatomic)CustomRequirementsStateListDataSource *customRequirementsStateListDataSource;

@end

@implementation CustomRequirementsStateListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIManager sharedUIManager].customRequirementsBackOffBolck = ^ (id obj){
        
        [self tableViewbeginRefreshing];
    };
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
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
    [self steupTableView];
}

-(void)initData{
    
    [super initData];
    [self showRefresh];
}

-(void)refreshData{
    
    [[UserManager shareUserManager] getUserCustomRequirementsListWithUserId:nil demandType:_demandType PageIndex:self.page_no PageCount:10];
    [UserManager shareUserManager].customRequirementsSuccess = ^(NSArray * arr){
        
        [self listDataWithListArray: [[CustomRequirementsStore shearCustomRequirementsStore]configurationCustomRequirementsListWithRequsData:arr] page:self.page_no];
        [self steupTableView];
    };
    
    [UserManager shareUserManager].errorFailure = ^(id obj){
        
        [self tableViewEndRefreshing];
    };
}

- (void)steupTableView{
    
    //    __weak typeof(self) WeakSrelf = self;
    
    TableViewCellConfigureBlock congfigureCell = ^(CustomRequirementsStateListCell *cell , CustomRequirementsList *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item demantType:_demandType];
        cell.operationDemandListTagBlock = ^(NSString *tagButtonTitle, CustomRequirementsStateListCell *cell){
         
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            CustomRequirementsList *list = [self.customRequirementsStateListDataSource itemAtIndexPath:indexPath];
            [self operationStateWithOperation:tagButtonTitle customRequirementsId:list.id];
        };
    };
    self.customRequirementsStateListDataSource = [[CustomRequirementsStateListDataSource alloc]initWithItems:self.dataArray cellIdentifier:CustomRequirementsStateListCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.customRequirementsStateListDataSource
                        cellIdentifier:CustomRequirementsStateListCellIdentifier
                               nibName:@"CustomRequirementsStateListCell"];
    
    self.tableView.dataSource = self.customRequirementsStateListDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"CustomRequirementsStateListCell"] forCellReuseIdentifier:CustomRequirementsStateListCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YZTagList *tagList = [[YZTagList alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 0)];
    tagList.tagFont = [UIFont systemFontOfSize:12];
    CustomRequirementsList *customRequirements = [self.customRequirementsStateListDataSource itemAtIndexPath:indexPath];
    [tagList addOperationDemandListTag: [[CustomRequirementsStore shearCustomRequirementsStore]operationStateWithState:[customRequirements.demand_status integerValue] demandType:_demandType] action:nil];
    return 77+45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    CustomRequirementsList *list = [self.customRequirementsStateListDataSource itemAtIndexPath:indexPath];
    CustomRequirementsStateDetailViewController *vc = [[CustomRequirementsStateDetailViewController alloc]init];
    vc.demand_id = list.id;
    vc.customRequirementsType = [list.demand_type integerValue];
    [UIManager pushVC:vc];
}

-(void)operationStateWithOperation:(NSString *)operationState customRequirementsId:(NSNumber *)customRequirements_id{
    
    if ([operationState isEqualToString:@"编辑"]) {
        
        [UIManager customRequirementsReleaseViewControllerWithIsEdit:YES demandType:_demandType demand_id:customRequirements_id];
    }
    if ([operationState isEqualToString:@"删除"] || [operationState isEqualToString:@"下架"] || [operationState isEqualToString:@"验收完成"]) {
       
        [[UserManager shareUserManager] operationCustomRequirementsWithId:customRequirements_id operation:operationState];
        [UserManager shareUserManager].customRequirementsSuccess = ^(id obj){
          
            [self refreshData];
        };
        
    }
    if ([operationState isEqualToString:@"重新发布"]) {
        
        
    }
    if ([operationState isEqualToString:@"托管赏金"]) {
        
        
    }
    
    if ([operationState isEqualToString:@"平台介入"]) {
        
        
    }
    
    if ([operationState isEqualToString:@"评价"]) {
        
        
    }
}

@end
