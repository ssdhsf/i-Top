//
//  CustomRequirementsViewController.m
//  itop
//
//  Created by huangli on 2018/4/19.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomRequirementsViewController.h"
#import "CustomRequirementsStoreCell.h"
#import "CustomRequirementsStore.h"
#import "CustomRequirementsDataSource.h"
#import "CustomRequirementsDetailViewController.h"

static NSString *const CustomRequirementsCellIdentifier = @"CustomRequirements";

@interface CustomRequirementsViewController ()

@property (strong, nonatomic)CustomRequirementsDataSource *customRequirementsDataSource;

@end

@implementation CustomRequirementsViewController

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
    
    self.title = @"定制需求";
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
}

-(void)initData{
    
    [super initData];
    [self showRefresh];
}

-(void)refreshData{
    
    [[UserManager shareUserManager] customRequirementsListWithUserId:nil PageIndex:self.page_no PageCount:10];
    [UserManager shareUserManager].customRequirementsSuccess = ^(NSArray * arr){
        
        [self listDataWithListArray: [[CustomRequirementsStore shearCustomRequirementsStore]configurationCustomRequirementsWithRequsData:arr] page:self.page_no];

        [self steupTableView];
        
    };
}

- (void)steupTableView{
    
//    __weak typeof(self) WeakSrelf = self;
    
    TableViewCellConfigureBlock congfigureCell = ^(CustomRequirementsStoreCell *cell , CustomRequirements *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item];
    };
    self.customRequirementsDataSource = [[CustomRequirementsDataSource alloc]initWithItems:self.dataArray cellIdentifier:CustomRequirementsCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.customRequirementsDataSource
                        cellIdentifier:CustomRequirementsCellIdentifier
                               nibName:@"CustomRequirementsStoreCell"];
    
    self.tableView.dataSource = self.customRequirementsDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"CustomRequirementsStoreCell"] forCellReuseIdentifier:CustomRequirementsCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    CustomRequirements *custom = [_customRequirementsDataSource itemAtIndexPath:indexPath];
    [UIManager customRequirementsDetailViewControllerWithCustomId:custom.id];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
