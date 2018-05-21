//
//  ProvinceViewController.m
//  itop
//
//  Created by huangli on 2018/4/1.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ProvinceViewController.h"
#import "ProvinceTableViewCell.h"
#import "ProvinceStore.h"
#import "ProvinceDataSource.h"
#import "MapLocationManager.h"

static NSString *const ProvinceCellIdentifier = @"Province";

@interface ProvinceViewController ()

@property (nonatomic, strong)ProvinceDataSource *provinceDataSource;
@property (nonatomic, strong)NSMutableArray *sectionTitle;
@end

@implementation ProvinceViewController

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
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ViewHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-5);
        make.bottom.top.mas_equalTo(self.view);
    }];
//    [[Global sharedSingleton] createProgressHUDInView:self.view withMessage:@"加载中"];
    self.tableView.hidden = YES;
}

-(void)initNavigationBarItems{
    
    self.title = @"选择城市" ;
}

//-(void)viewDidAppear:(BOOL)animated{
//    
//    [super viewDidAppear:animated];
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        
////        NSLog(@"%@",[NSThread currentThread]);
////        self.dataArray = [[ProvinceStore shearProvinceStore]configurationProvinceStoreMenuWithMenu:nil];
////        self.sectionTitle = [[ProvinceStore shearProvinceStore] screeningLetter];
////        dispatch_async(dispatch_get_main_queue(), ^{
////            NSLog(@"%@",[NSThread currentThread]);
////            [MBProgressHUD hideHUDForView:self.view animated:NO];
////            self.tableView.hidden = NO;
////            [self steupTableView];
////        });
//    });
//}

-(void)initData{
    
    [super initData];
    
    self.sectionTitle = [NSMutableArray array];
    [[UserManager shareUserManager]cityList];
    [UserManager shareUserManager].cityListSuccess = ^(NSArray *arr){
      
        self.dataArray = [[ProvinceStore shearProvinceStore]configurationProvinceStoreMenuWithMenu:arr];
        
        for (SelecteProvinceModel *city in self.dataArray) {
            
            [self.sectionTitle addObject:city.letterKey];
        }
        self.tableView.hidden = NO;
        [self steupTableView];
    };
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(ProvinceTableViewCell *cell , City *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item];
        
    };
    self.provinceDataSource = [[ProvinceDataSource alloc]initWithItems:self.dataArray cellIdentifier:ProvinceCellIdentifier cellConfigureBlock:congfigureCell];
    self.provinceDataSource.count = self.sectionTitle;
    [self steupTableViewWithDataSource:self.provinceDataSource
                        cellIdentifier:ProvinceCellIdentifier
                               nibName:@"ProvinceTableViewCell"];
    
    self.tableView.dataSource = self.provinceDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"ProvinceTableViewCell"] forCellReuseIdentifier:ProvinceCellIdentifier];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 25;
}

- (UIView *)tableView:(UITableView *)tableView  viewForHeaderInSection:(NSInteger)section {
    
    UILabel *lable = [[UILabel alloc]init];
    if (_sectionTitle.count != 0) {
        
        if ([_sectionTitle[section] isEqualToString:@"当"]) {
            lable.text =[NSString stringWithFormat:@"    %@", @"当前定位"];
        } else {
            
            lable.text = [NSString stringWithFormat:@"    %@",_sectionTitle[section]];
        }
        
        lable.backgroundColor = RGB(224, 227, 230);
        lable.font = [UIFont systemFontOfSize:13];

    }
    return lable;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    City *city = [_provinceDataSource itemAtIndexPath:indexPath];

    [self back];
    [UIManager sharedUIManager].selectProvinceBackOffBolck(city);
}

@end
