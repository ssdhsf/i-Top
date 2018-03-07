//
//  SetupHomeViewController.m
//  itop
//
//  Created by huangli on 2018/3/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SetupHomeViewController.h"
#import "SetupHomeTableViewCell.h"
#import "SetupHomeStore.h"
#import "SetupHomeDataSource.h"

static NSString *const SetupHomeCellIdentifier = @"SetupHome";

@interface SetupHomeViewController ()

@property (nonatomic ,strong)SetupHomeDataSource *setupHomeDataSource;
@property (weak, nonatomic) IBOutlet UIButton *loginOutButton;
@property (strong, nonatomic) IBOutlet UIView *fooderView;
@end

@implementation SetupHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    
    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ViewHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.top.mas_equalTo(self.view);
    }];
    self.tableView.tableFooterView = _fooderView;
    _loginOutButton.layer.masksToBounds = YES;
    _loginOutButton.layer.cornerRadius = _loginOutButton.frame.size.height/2;
    [_loginOutButton.layer addSublayer:[UIColor setGradualChangingColor: _loginOutButton fromColor:@"FFA5EC" toColor:@"DEA2FF"]];
    [self steupTableView];
}

-(void)initData{
    
    [super initData];
    
    self.dataArray = [[SetupHomeStore shearSetupHomeStore]configurationSetupMenu];
}

-(void)initNavigationBarItems{
    
    self.title = @"设置";
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(SetupHomeTableViewCell *cell , MyInfomation *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item ];
        
    };
    self.setupHomeDataSource = [[SetupHomeDataSource alloc]initWithItems:self.dataArray cellIdentifier:SetupHomeCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.setupHomeDataSource
                        cellIdentifier:SetupHomeCellIdentifier
                               nibName:@"SetupHomeTableViewCell"];
    
    self.tableView.dataSource = self.setupHomeDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"SetupHomeTableViewCell"] forCellReuseIdentifier:SetupHomeCellIdentifier];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 71;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    MyInfomation *info = [_setupHomeDataSource itemAtIndexPath:indexPath];
    if ([info.myInfoTitle isEqualToString:@"缓存清理"]) {
        
        [self touchCleanCache];
    }else {
        
        [UIManager showVC:info.nextVcName];
    }
}

- (IBAction)loginOut:(UIButton *)sender {
    
    [[UserManager shareUserManager]loginOut];
    [UserManager shareUserManager].loginSuccess = ^ (id obj){
        
        [[LoginMannager sheardLoginMannager]clearLoginUserMassage];
        [[LoginMannager sheardLoginMannager]presentViewLoginViewController];
        
    };
}

#pragma mark 点击清理缓存空间
- (void)touchCleanCache {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
//        [[CacheManager shareCacheManager] clearAllCache];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] cleanDisk];
        [self performSelectorOnMainThread:@selector(clearCacheSuccess)
                               withObject:nil
                            waitUntilDone:YES];
        
    });
}

- (void)clearCacheSuccess {
    
    [self showToastWithMessage:@"缓存清理成功"];
}


@end
