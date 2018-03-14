//
//  LeaveViewController.m
//  itop
//
//  Created by huangli on 2018/2/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "LeaveViewController.h"
#import "LeaveTableViewCell.h"
#import "LeaveStore.h"
#import "LeaveDataSource.h"
#import "LMJDropdownMenu.h"
#import "LeaveDetailViewController.h"

#define MANAGEMENT @"管理"
#define DELETE @"删除"
#define CANCEL @"取消"

static NSString *const LeaveCellIdentifier = @"Leave";

@interface LeaveViewController ()<LMJDropdownMenuDelegate>

@property(nonatomic, strong)LeaveDataSource *leaveDataSouce;
@property(nonatomic, strong)NSArray *dropdownItme; //下拉分类
@property(nonatomic, assign)BOOL isManageMent;
@property(nonatomic, assign)BOOL isDelete;
@property (strong, nonatomic) LMJDropdownMenu * dropdownMenu;

@end

@implementation LeaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initData{
    
    [super initData];
    self.dropdownItme = @[@"国际会议邀请函",@"WWDC会议邀请函",@"博鳌亚洲峰会邀请函",@"党的19大会议出席",@"国际会议邀请函",@"WWDC会议邀请函",@"博鳌亚洲峰会邀请函",@"党的19大会议出席"];
    self.dataArray = [[LeaveStore shearLeaveStore]configurationMenuWithMenu:nil testString:self.dropdownItme[0]];
    _isManageMent = YES;
    _isDelete = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigafindHairlineImageView:YES];
    [self hiddenNavigationController:NO];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initNavigationBarItems{
    
    self.title = @"留资";
    [self setupNavigationItemTintWithTint:MANAGEMENT];
}

-(void)initView{
    
    [super initView];
    
    NSInteger tabelViewHeight;
    if (_getLeaveListType == GetLeaveListTypeProduct) {
        
        tabelViewHeight =  0;
    } else {
        
        tabelViewHeight =  80;
        [self steupDropdownMenu];
    }
    [self initTableViewWithFrame:TableViewFrame(0, tabelViewHeight, ScreenWidth, ViewHeigh-tabelViewHeight)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self steupTableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.bottom.right.mas_equalTo(self.view);
        make.bottom.top.mas_equalTo(tabelViewHeight);
        
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

-(void)steupDropdownMenu{
    
    _dropdownMenu = [[LMJDropdownMenu alloc] init];
    [_dropdownMenu setFrame:CGRectMake(50, 30, ScreenWidth-100, 44)];
    [_dropdownMenu setMenuTitles:self.dropdownItme rowHeight:44];
    _dropdownMenu.delegate = self;
    [self.view addSubview:_dropdownMenu];
   
}

- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    
    self.dataArray = [[LeaveStore shearLeaveStore]configurationMenuWithMenu:nil testString:self.dropdownItme[number]];
    [self steupTableView];
}

- (void)refreshData{
    
    [[UserManager shareUserManager]leaveProductWithProductId:_product_id PageIndex:self.page_no PageCount:10];
    
    [UserManager shareUserManager].leaveProductSuccess = ^(id obj){
        
        [self listDataWithListArray:[[LeaveStore shearLeaveStore] configurationMenuWithMenu:obj testString:self.dropdownItme[0]] page:self.page_no];
    };
    
    [UserManager shareUserManager].errorFailure = ^ (id obj){
        
        [self tableViewEndRefreshing];
    };
}

- (void)steupTableView{
    
     __weak typeof(self) weakSelf = self;
    TableViewCellConfigureBlock congfigureCell = ^(LeaveTableViewCell *cell , Leave *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item animation:_isManageMent];
       
        cell.deleteIndex = ^(LeaveTableViewCell *cell){
            
            NSIndexPath *indexPath = [weakSelf.tableView indexPathForCell:cell];
            Leave *selectLeave = weakSelf.dataArray [indexPath.row];
            selectLeave.select = cell.deleteButton.selected;
            
            _isDelete = NO;
            for (int i = 0; i< weakSelf.dataArray.count; i++) {
                Leave *leave = weakSelf.dataArray[i];
                if (leave.select) {
                 
                    _isDelete = YES;
                }
            }
            [self setupNavigationItemTintWithTint:_isDelete ? DELETE : CANCEL];
        };
    };
    self.leaveDataSouce = [[LeaveDataSource alloc]initWithItems:self.dataArray cellIdentifier:LeaveCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.leaveDataSouce
                        cellIdentifier:LeaveCellIdentifier
                               nibName:@"LeaveTableViewCell"];
    
    self.tableView.dataSource = self.leaveDataSouce;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"LeaveTableViewCell"] forCellReuseIdentifier:LeaveCellIdentifier];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    LeaveDetailViewController *vc = [[LeaveDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
     NSLog(@"push");
}

-(void)management:(UIBarButtonItem *)rightBar{

    if ([rightBar.title isEqualToString:MANAGEMENT]) {
       
         _isManageMent = NO;
        [self setupNavigationItemTintWithTint:CANCEL];
        self.tableView.allowsSelection = NO;
        
    } else if([rightBar.title isEqualToString:CANCEL]) {

        _isManageMent = YES;
        [self setupNavigationItemTintWithTint:MANAGEMENT];
        self.tableView.allowsSelection = YES;
    } else {
        
        [self AlertOperation];
    }

    [self.tableView reloadData];
    NSLog(@"push");
}

-(void)setupNavigationItemTintWithTint:(NSString *)tint{
    
    [self setRightBarItemString:tint action:@selector(management:)];
    self.navigationItem.rightBarButtonItem.tintColor = RGB(232, 98, 159);
}

-(void)AlertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除选中项" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        for (int i = 0; i < self.dataArray.count; i++) {
            Leave *leav = self.dataArray[i];
            
            if (leav.select) {
                
                [self.dataArray removeObject:leav];
                i--;
            }
        }
        
        [self setupNavigationItemTintWithTint:CANCEL];
        [self.tableView reloadData];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu{
    
    self.tableView.scrollEnabled = NO;
    self.tableView.allowsSelection = NO;

}

- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu{

    self.tableView.scrollEnabled = YES;
    self.tableView.allowsSelection = YES;
}



@end
