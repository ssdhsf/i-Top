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
            [self operationStateWithOperation:tagButtonTitle customRequirements:list];
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
    vc.demandType = _demandType;
    vc.message = list.message;
    [UIManager pushVC:vc];
}

-(void)operationStateWithOperation:(NSString *)operationState customRequirements:(CustomRequirementsList *)customRequirements{
    
    if ([operationState isEqualToString:@"编辑"] || [operationState isEqualToString:@"重新发布"]) {
        
        [UIManager customRequirementsReleaseViewControllerWithDemandAddType:DemandAddTypeOnEdit demandType:_demandType demand_id:customRequirements.id desginerId:nil productId:nil];
    }
    if ([operationState isEqualToString:@"删除"] ||
        [operationState isEqualToString:@"下架"] ||
        [operationState isEqualToString:@"验收完成"] ||
        [operationState isEqualToString:@"上架"] ||
        [operationState isEqualToString:@"取消合作"]) {
       
        [[UserManager shareUserManager] operationCustomRequirementsWithId:customRequirements.id operation:operationState];
        [UserManager shareUserManager].customRequirementsSuccess = ^(id obj){
          
            [self tableViewbeginRefreshing];
        };
    }
    
    if ([operationState isEqualToString:@"接单"] || [operationState isEqualToString:@"拒绝"]) {
        
        BOOL isAccept = [operationState isEqualToString:@"接单"] ? YES : NO;
        [[UserManager shareUserManager] operationCustomRequirementsWithId:customRequirements.id isAccept:isAccept];
        [UserManager shareUserManager].customRequirementsSuccess = ^(id obj){
            
            [self tableViewbeginRefreshing];
        };
    }
    if ([operationState isEqualToString:@"托管赏金"]) {
        
        [UIManager hostingBountyViewControllerWithDemandId:customRequirements.id];
        
    }
    if ([operationState isEqualToString:@"作品上传"]) {
        
        [UIManager uploadProductLinkViewControllerWithDemandId:customRequirements.id userId:[[UserManager shareUserManager]crrentUserId]];
    }
    if ([operationState isEqualToString:@"平台介入"]) {
        
        [[UserManager shareUserManager]demandDemanddisputeListWithId:customRequirements.id pageIndex:1 pageCount:10];
        [UserManager shareUserManager].customRequirementsSuccess = ^(NSArray *arr){
            
            if (arr.count == 0) {

                [UIManager submitDisputesViewControllerWithCustomId:customRequirements.id ];
                
            } else {
                
                [UIManager disputesViewControllerWithCustomId:customRequirements.id message:customRequirements.message];
            }
        };
    }
    
    if ([operationState isEqualToString:@"评价"]) {
        
        CommentType commentType = [[UserManager shareUserManager] crrentUserType] == UserTypeDesigner ? CommentTypeDemandDesginerToEnterprise : CommentTypeDemandEnterpriseToDesginer;
         [UIManager commentPopularizeViewControllerWithCustomId:customRequirements.id commentType:commentType];
        
        [UIManager sharedUIManager].commentPopularizeBackOffBolck = ^ (id obj){
            
            [self refreshData];
        };
    }
}

@end
