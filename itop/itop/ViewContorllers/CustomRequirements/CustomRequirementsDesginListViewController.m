//
//  CustomRequirementsDesginListViewController.m
//  itop
//
//  Created by huangli on 2018/4/23.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomRequirementsDesginListViewController.h"
#import "CustomRequirementsDesginListTableViewCell.h"
#import "DesignerSigningStore.h"
#import "CustomRequirementsDesginListDataSource.h"

static NSString *const CustomRequirementsDesginListCellIdentifier = @"CustomRequirementsDesginList";

@interface CustomRequirementsDesginListViewController ()

@property (strong, nonatomic)CustomRequirementsDesginListDataSource *customRequirementsDesginListDataSource;
@end

@implementation CustomRequirementsDesginListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initData{
    
    [super initData];
}

-(void)initView{
    
    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ScreenHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.bottom.left.mas_equalTo(self.view);
        make.width.mas_equalTo(ScreenWidth);
    }];
    
    self.tableView.contentInset = UIEdgeInsetsMake( 0, 0, -35, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (self.dataArray.count == 0) {
    
        self.originY = 30;
        [self setHasData:NO];
        
    } else {
        [self steupTableView];
    }
}

- (void)steupTableView{
    
    //    __weak typeof(self) WeakSrelf = self;
    
    TableViewCellConfigureBlock congfigureCell = ^(CustomRequirementsDesginListTableViewCell *cell ,  CustomRequirementsDegsinList*item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item];
    };
    self.customRequirementsDesginListDataSource = [[CustomRequirementsDesginListDataSource alloc]initWithItems:self.dataArray cellIdentifier:CustomRequirementsDesginListCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.customRequirementsDesginListDataSource
                        cellIdentifier:CustomRequirementsDesginListCellIdentifier
                               nibName:@"CustomRequirementsDesginListTableViewCell"];
    
    self.tableView.dataSource = self.customRequirementsDesginListDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"CustomRequirementsDesginListTableViewCell"] forCellReuseIdentifier:CustomRequirementsDesginListCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

#pragma mark- scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(CustomRequirementsDesginListViewControllerTableViewDidScroll:)]&& scrollView.contentOffset.y <= 0) {
        [self.delegate CustomRequirementsDesginListViewControllerTableViewDidScroll:scrollView.contentOffset.y];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if ([self.delegate respondsToSelector:@selector(CustomRequirementsDesginListViewControllerTableViewDidScroll:)]) {
        [self.delegate CustomRequirementsDesginListViewControllerTableViewDidScroll:scrollView.contentOffset.y];
        }
    //    NSLog(@"12");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
