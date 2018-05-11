//
//  CustomRequirementsDetailTabelViewController.m
//  itop
//
//  Created by huangli on 2018/4/20.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomRequirementsDetailTabelViewController.h"
#import "CustomRequirementsDetailCell.h"
#import "CustomRequirementsStore.h"
#import "CustomRequirementsDetailDataSource.h"


static NSString *const CustomRequirementsDetailCellIdentifier = @"CustomRequirementsDetail";

@interface CustomRequirementsDetailTabelViewController ()

@property (strong, nonatomic)CustomRequirementsDetailDataSource *customRequirementsDetailDataSource;

@end

@implementation CustomRequirementsDetailTabelViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initData{
   
    [super initData];
//    self.dataArray = [[CustomRequirementsStore shearCustomRequirementsStore]configurationCustomRequirementsDetailWithMenu:nil];
}

-(void)initView{
    
    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ScreenHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.bottom.left.mas_equalTo(self.view);
        make.width.mas_equalTo(ScreenWidth);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self steupTableView];
}

- (void)steupTableView{
    
    //    __weak typeof(self) WeakSrelf = self;
    
    TableViewCellConfigureBlock congfigureCell = ^(CustomRequirementsDetailCell *cell , Infomation *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item];
    };
    self.customRequirementsDetailDataSource = [[CustomRequirementsDetailDataSource alloc]initWithItems:self.dataArray cellIdentifier:CustomRequirementsDetailCellIdentifier cellConfigureBlock:congfigureCell];
    [self steupTableViewWithDataSource:self.customRequirementsDetailDataSource
                        cellIdentifier:CustomRequirementsDetailCellIdentifier
                               nibName:@"CustomRequirementsDetailCell"];
    
    self.tableView.dataSource = self.customRequirementsDetailDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"CustomRequirementsDetailCell"] forCellReuseIdentifier:CustomRequirementsDetailCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Infomation *model = [self.customRequirementsDetailDataSource itemAtIndexPath:indexPath];
    if ([model.title isEqualToString:@"参考图片"]) {
        return 122;
    }else {
        
        if ([Global stringIsNullWithString:model.content]) {
            
            return 50;
        } else {
            
            NSInteger contentHigth = [Global heightWithString:model.content width:ScreenWidth-132 fontSize:15];
            
            if (contentHigth >100) {
                
                return 100;
            } else {
                
                return 22+contentHigth+10;
            }
        }
    }
}

#pragma mark- scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(customRequirementsDetailViewControllerTableViewDidScroll:)] && scrollView.contentOffset.y <= 0){
        [self.delegate customRequirementsDetailViewControllerTableViewDidScroll:scrollView.contentOffset.y];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if ([self.delegate respondsToSelector:@selector(customRequirementsDetailViewControllerTableViewDidScroll:)]) {
        [self.delegate customRequirementsDetailViewControllerTableViewDidScroll:scrollView.contentOffset.y];
    }
}

@end
