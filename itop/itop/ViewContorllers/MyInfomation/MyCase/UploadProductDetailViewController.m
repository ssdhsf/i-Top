//
//  UploadProductDetailViewController.m
//  itop
//
//  Created by huangli on 2018/5/8.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "UploadProductDetailViewController.h"
#import "DirectionalDemandReleaseStore.h"
//#import "DirectionalDemandReleaseViewCell.h"
#import "DirectionalDemandReleaseDataSource.h"
#import "UploadProductDetailCell.h"

static NSString *const UploadProductDetailCellIdentifier = @"UploadProductDetail";

@interface UploadProductDetailViewController ()

@property (strong, nonatomic)DirectionalDemandReleaseDataSource *directionalDemandReleaseDataSource;
@end

@implementation UploadProductDetailViewController

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
    
    self.title = @"作品详情";
}

-(void)initData{
    
    [super initData];
    self.dataArray = [[DirectionalDemandReleaseStore shearDirectionalDemandReleaseStore]configurationUploadProductDetailWithProductDetail:_productDetail];
}

-(void)initView{
    
    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ScreenHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(kDevice_Is_iPhoneX ? -34 : 0);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self steupTableView];
   
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(UploadProductDetailCell *cell , DemandEdit *item , NSIndexPath *indexPath){
        
        [cell showProductDedailItmeOfModel:item];
    };
    self.directionalDemandReleaseDataSource = [[DirectionalDemandReleaseDataSource alloc]initWithItems:self.dataArray cellIdentifier:UploadProductDetailCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.directionalDemandReleaseDataSource
                        cellIdentifier:UploadProductDetailCellIdentifier
                               nibName:@"UploadProductDetailCell"];
    
    self.tableView.dataSource = self.directionalDemandReleaseDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"UploadProductDetailCell"] forCellReuseIdentifier:UploadProductDetailCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DemandEdit * demandEdit = [self.directionalDemandReleaseDataSource itemAtIndexPath:indexPath];
    if(demandEdit.editType == EditTypeSelectImage){
        
        return 180;
    } else{
       
        if ([Global stringIsNullWithString:demandEdit.content]) {
            
            return 50;
        } else {
            
            CGFloat contentHeight ;
            if ([demandEdit.title isEqualToString: @"作品链接"] || [demandEdit.title isEqualToString: @"网盘地址"]) {
                contentHeight = [Global heightWithString:demandEdit.content width:ScreenWidth - 161 fontSize:15];
            } else {
                
                contentHeight = [Global heightWithString:demandEdit.content width:ScreenWidth - 121 fontSize:15];
            }
            return contentHeight + 30;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
