//
//  CommentListViewController.m
//  itop
//
//  Created by huangli on 2018/3/14.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CommentListViewController.h"
//#import "HotDetailsViewController.h"
#import "LMJDropdownMenu.h"
#import "CommentListDataSource.h"
#import "MyWorksStore.h"
#import "HotDetailStore.h"
#import "HotDetailsCell.h"

static NSString *const CommentListCellIdentifier = @"CommentList";

@interface CommentListViewController ()<LMJDropdownMenuDelegate>

@property (strong, nonatomic)  CommentListDataSource *commentListDataSource;
@property(nonatomic, strong)NSArray *myProductArray; //我的作品
@property(nonatomic, strong)H5List *currentProduct; //当前的作品
@property(nonatomic, strong)NSArray *dropdownItme; //下拉分类
@property (weak, nonatomic) IBOutlet LMJDropdownMenu *dropdownMenu;

@end

@implementation CommentListViewController

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
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ScreenHeigh-50)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(128);
        make.bottom.mas_equalTo(-50);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)initData{
    
    [super initData];
    
    [[UserManager shareUserManager]myProductListWithProductType:100  checkStatusType:CheckStatusTypeNoel isShow:1  PageIndex:1 PageCount:10];

    [UserManager shareUserManager].myProductListSuccess = ^(id obj){
      
        NSArray * array = (NSArray *)obj;
        _myProductArray = [[MyWorksStore shearMyWorksStore]configurationMenuWithMenu:array];
        _dropdownItme = [[MyWorksStore shearMyWorksStore]commentsListDropdownMenuConfigurationMenuWithMenu:_myProductArray];
        [self steupDropdownMenu];
        self.page_no = 1;
        if (_myProductArray.count != 0) {
            _currentProduct = _myProductArray[0];
            [self refreshData];

        }
        
        NSLog(@"%@",obj);
    };
}

-(void)refreshData{
  
    [self refreshProductCommentWithProductId:_currentProduct.id];
}

-(void)refreshProductCommentWithProductId:(NSString *)product_id{
    
    
    [[UserManager shareUserManager]commentListWithProductId:product_id PageIndex:self.page_no PageCount:10];

    [UserManager shareUserManager].commentListSuccess = ^ (NSArray *obj){
        
        [self listDataWithListArray:[[HotDetailStore shearHotDetailStore]configurationMenuWithMenu:obj] page:self.page_no];
        
        [self steupTableView];
    };
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(HotDetailsCell *cell , HotComments *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item];
    };
    self.commentListDataSource = [[CommentListDataSource alloc]initWithItems:self.dataArray cellIdentifier:CommentListCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.commentListDataSource
                        cellIdentifier:CommentListCellIdentifier
                               nibName:@"HotDetailsCell"];
    
    self.tableView.dataSource = self.commentListDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"HotDetailsCell"] forCellReuseIdentifier:CommentListCellIdentifier];
}


-(void)steupDropdownMenu{
    
//    LMJDropdownMenu * dropdownMenu = [[LMJDropdownMenu alloc] init];
//    [dropdownMenu setFrame:CGRectMake(50, 30, ScreenWidth-100, 44)];
    [_dropdownMenu setMenuTitles:self.dropdownItme rowHeight:44];
    _dropdownMenu.delegate = self;
//    [self.view addSubview:dropdownMenu];
}

- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
   
    H5List *product = _myProductArray[number];
    [self refreshProductCommentWithProductId:product.id];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotComments *hot = [_commentListDataSource itemAtIndexPath:indexPath];
    CGFloat contentHeight = [Global heightWithString:hot.content width:ScreenWidth-85 fontSize:15];
    CGFloat replyHeight = [Global heightWithString:hot.replyString width:ScreenWidth-85 fontSize:15];
    return 65+21+contentHeight+replyHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
//    [_commentTV becomeFirstResponder];
//    HotComments *comment = [self.hotDetailDataSource itemAtIndexPath:indexPath];
//    _parent_id = comment.id;
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
