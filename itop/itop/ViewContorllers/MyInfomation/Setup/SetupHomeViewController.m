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
    [_loginOutButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_loginOutButton)];
    
    if (![[UserManager shareUserManager]isLogin]) {
        
        [_loginOutButton setTitle:@"登录" forState:UIControlStateNormal];
    } else {
        [_loginOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    }
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
    } else if ([info.myInfoTitle isEqualToString:@"联系客服"]){
        
        [UIManager customerServiceAndFeedbackWithTitle:info.myInfoTitle];
        
    }  else {
        
        if (![[UserManager shareUserManager]isLogin] && [info.myInfoTitle isEqualToString:@"账号与安全"]){
            
            [self showToastWithMessage:@"请登录"];
            return;
        }
        [UIManager showVC:info.nextVcName];
    }
}

- (IBAction)loginOut:(UIButton *)sender {
    
    if ([sender.titleLabel.text  isEqualToString:@"登录"]) {
        
        [[UIManager sharedUIManager]LoginViewControllerWithLoginState:NO];
    } else {
        
        [self alertOperation];
    }
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

-(void)alertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出登录吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[UserManager shareUserManager]loginOut];
        [UserManager shareUserManager].loginSuccess = ^ (id obj){
            
            [[LoginMannager sheardLoginMannager]clearLoginUserMassage];
            [[LoginMannager sheardLoginMannager] stopTimer];
            
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            [UIManager sharedUIManager].loginOutBackOffBolck (nil);
            //        [[UIManager sharedUIManager]LoginViewControllerWithLoginState:YES];
            //        [[LoginMannager sheardLoginMannager]presentViewLoginViewController];
            
        };

//        [self back];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)clearCacheSuccess {
    
    [self showToastWithMessage:@"缓存清理成功"];
}



@end
