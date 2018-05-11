//
//  CustomRequirementsStateDetailViewController.m
//  itop
//
//  Created by huangli on 2018/4/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomRequirementsStateDetailViewController.h"
#import "CustomRequirementsStore.h"
#import "CustomRequirementsDetailTabelViewController.h"
#import "CustomRequirementsDesginListViewController.h"
#import "BiddingProductListViewController.h"
#import "DesignerListStore.h"
#import "CustomRequirementsCommentsViewController.h"
#import "SubmitDisputesViewController.h"
#import "DisputesViewController.h"

@interface CustomRequirementsStateDetailViewController ()<SegmentTapViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *stateButton;
@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, assign)NSInteger itmeIndex;//当前的选项
@property (nonatomic, assign)BOOL isSubmitBackOff; //是否是提交热点回掉操作
@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong)CustomRequirementsDetail *customRequirementsDetail;
@property (nonatomic,weak)CustomRequirementsDetailTabelViewController *customRequirementsDetaiVc;
@property (nonatomic,weak)CustomRequirementsDesginListViewController *customRequirementsDesginList;
@property (nonatomic,weak)BiddingProductListViewController *biddingProductListVc;

@property (nonatomic,weak)CustomRequirementsCommentsViewController *customRequirementsMyCommentsVc;
@property (nonatomic,weak)CustomRequirementsCommentsViewController *customRequirementsOtherCommentsVc;

@property (nonatomic, strong)CustomRequirementsComments *customRequirementsMyComments;
@property (nonatomic, strong)CustomRequirementsComments *customRequirementsOtherComments;

@property (strong, nonatomic) YZTagList *tagList;

@end

@implementation CustomRequirementsStateDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initView{
    
    [super initView];
}

-(void)initData{
    
    [super initData];
    _dataArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [[UserManager shareUserManager]customRequirementsDetailWithDetailId:_demand_id];
    [UserManager shareUserManager].customRequirementsSuccess = ^(NSDictionary *obj){
        
        _customRequirementsDetail = [[CustomRequirementsDetail alloc]initWithDictionary:obj error:nil];
        weakSelf.customRequirementsDetail.demand.descrip = obj[@"demand"][@"description"];
        [weakSelf.dataArray addObjectsFromArray: [[CustomRequirementsStore shearCustomRequirementsStore] showPageTitleWithState:[_customRequirementsDetail.demand.demand_status integerValue] demandType:_demandType]];
        [weakSelf initSegment];
        [weakSelf setupOptionButton];
        [weakSelf createScrollView];
        [weakSelf initCheckStateView];
        [weakSelf setupChildViewInContentView];
       
    };
}

-(void)initNavigationBarItems{
    
    self.title = @"定制详情";
}

-(void)initCheckStateView{
    
    [self.stateButton setTitle:[[CustomRequirementsStore shearCustomRequirementsStore]showStateWithState:[_customRequirementsDetail.demand.demand_status integerValue]] forState:UIControlStateNormal];
}

-(void)setupChildViewInContentView{
    
    __weak typeof(self) weakSelf = self;
    
    if ([_customRequirementsDetail.demand.demand_status integerValue] == CustomRequirementsTypeSucess && [[UserManager shareUserManager]crrentUserType ] == UserTypeDesigner ) {
        
        [[UserManager shareUserManager]demandDesginerCommentListWithId:_demand_id];
        [UserManager shareUserManager].customRequirementsCommentsDisginSuccess  = ^(NSArray *arr){
            
            [weakSelf addMyCommentsWithArray:arr];
        };
        
    } else if ([_customRequirementsDetail.demand.demand_status integerValue] == CustomRequirementsTypeSucess && [[UserManager shareUserManager]crrentUserType ] == UserTypeEnterprise ) {
        
        [[UserManager shareUserManager]demandentErpriseCommentListWithId:_demand_id];
        [UserManager shareUserManager].customRequirementsCommentsCompanySuccess  = ^(NSArray *arr){
            
             [weakSelf addMyCommentsWithArray:arr];
        };
    } else if ([_customRequirementsDetail.demand.demand_status integerValue] == CustomRequirementsTypeCompletion) {
       
        [[UserManager shareUserManager]demandDesginerCommentListWithId:_demand_id];
        [UserManager shareUserManager].customRequirementsCommentsDisginSuccess  = ^(NSArray *arr){
            [weakSelf getCommentsWithArray:arr index:1];
            
            [[UserManager shareUserManager]demandentErpriseCommentListWithId:_demand_id];
            [UserManager shareUserManager].customRequirementsCommentsCompanySuccess = ^(NSArray *arr){
                
                [weakSelf getCommentsWithArray:arr index:2];
            };
        };
    
    } else {
        
        [weakSelf setupChildViewController];
        for (int i = 0; i < _dataArray.count; i++) {
            
            [self addChildViewInContentViewWithIndex:i];
        }
    }
}

-(void)addMyCommentsWithArray:(NSArray *)arr{
    
    NSArray *commentArray = [[CustomRequirementsStore shearCustomRequirementsStore]configurationCustomRequirementsCommentsWithRequsData:arr];
    
    for (CustomRequirementsComments *comments in commentArray) {
        
        if ([comments.id isEqualToNumber:_customRequirementsDetail.demand.id] && [comments.user_id isEqualToNumber:_customRequirementsDetail.demand.user_id]) {
            
            [self.dataArray addObject:@"我的评价"];
        }
    }
    
    [self setupChildViewController];
    for (int i = 0; i < _dataArray.count; i++) {
        
         [self addChildViewInContentViewWithIndex:i];
    }
}

-(void)getCommentsWithArray:(NSArray *)arr  index:(NSInteger)index{
    
    NSArray *commentArray = [[CustomRequirementsStore shearCustomRequirementsStore]configurationCustomRequirementsCommentsWithRequsData:arr];
    for (CustomRequirementsComments *comments in commentArray) {
        
        if ([comments.demand_id isEqualToNumber:_customRequirementsDetail.demand.id] ){ // 订单id匹配
            
            if ([comments.user_id isEqualToNumber: [[UserManager shareUserManager]crrentUserId]]) {//用户id匹配
                _customRequirementsMyComments = comments;
        
            } else {
                _customRequirementsOtherComments = comments;
            }

            if (index == 2) {
               
                [self setupChildViewController];
                for (int i = 0; i <_dataArray.count; i++) {
                    
                    [self addChildViewInContentViewWithIndex:i];
                }
            }
        }
    }
}

-(void)initSegment{
    
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 113, ScreenWidth, 40) withDataArray:self.dataArray withFont:15];
    self.segment.delegate = self;
    self.segment.lineColor = [UIColor clearColor];
    self.segment.textNomalColor = UIColorFromRGB(0x434a5c);
    self.segment.textSelectedColor = UIColorFromRGB(0xf95aee);
    [self.segment selectIndex:_itmeIndex];
    [self.view addSubview:self.segment];
}

-(void)createScrollView{
    
    if(_scroll){
        
        for(UIView *sub in _scroll.subviews)
            [sub removeFromSuperview];
        [_scroll removeFromSuperview];
        _scroll = nil;
    }
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 154, ScreenWidth, ScreenHeigh-154-NAVIGATION_HIGHT-TABBAR_HIGHT)];
    [self.view addSubview:_scroll];
    _scroll.delegate = self;
    _scroll.contentSize = CGSizeMake(self.dataArray.count*ScreenWidth, 0);
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentOffset = CGPointMake(ScreenWidth*_itmeIndex, 0);
}

-(void)setupOptionButton{
    
    NSArray *optionArray = [[CustomRequirementsStore shearCustomRequirementsStore]operationStateWithState:[_customRequirementsDetail.demand.demand_status integerValue] demandType:_demandType];

    // 高度可以设置为0，会自动跟随标题计算
    _tagList = [[YZTagList alloc] initWithFrame:CGRectMake(10, ScreenHeigh-TABBAR_HIGHT-NAVIGATION_HIGHT, ScreenWidth-20, 0)];
    _tagList.tag = 1;
    _tagList.backgroundColor = [UIColor whiteColor];
    _tagList.tagCornerRadius = 3;
    _tagList.borderColor = UIColorFromRGB(0xc6c8ce);
    _tagList.borderWidth = 0;
    _tagList.tagFont = [UIFont systemFontOfSize:12] ;
    // 设置标签背景色
    _tagList.tagColor = [UIColor blackColor];
    [_tagList addOperationDemandListTag: optionArray action:@selector(operationDemandListTagTag:) ];
    _tagList.operationDemandListTagBlock = ^(NSString *buttonTitle){
        
        [self operationStateWithOperation:buttonTitle customRequirementsId:_customRequirementsDetail.demand.id];
    };
    [self.view addSubview:_tagList];
}

-(void)operationStateWithOperation:(NSString *)operationState customRequirementsId:(NSNumber *)customRequirements_id{
    
    if ([operationState isEqualToString:@"编辑"] || [operationState isEqualToString:@"重新发布"]) {
        
        [UIManager customRequirementsReleaseViewControllerWithDemandAddType:DemandAddTypeOnEdit demandType:_demandType demand_id:customRequirements_id desginerId:nil productId:nil];
    }
    if ([operationState isEqualToString:@"删除"] || [operationState isEqualToString:@"下架"] || [operationState isEqualToString:@"验收完成"]) {
        
        [[UserManager shareUserManager] operationCustomRequirementsWithId:customRequirements_id operation:operationState];
        [UserManager shareUserManager].customRequirementsSuccess = ^(id obj){
            
//            [self refreshData];
        };
    }
    if ([operationState isEqualToString:@"托管赏金"]) {
        
        
    }
    
    if ([operationState isEqualToString:@"平台介入"]) {
        
        [[UserManager shareUserManager]demandDemanddisputeListWithId:_customRequirementsDetail.demand.id pageIndex:1 pageCount:10];
        [UserManager shareUserManager].customRequirementsSuccess = ^(NSArray *arr){
            
            if (arr.count == 0) {
               
                [UIManager submitDisputesViewControllerWithCustomId:_customRequirementsDetail.demand.id];
                
            } else {
                
                [UIManager disputesViewControllerWithCustomId:_customRequirementsDetail.demand.id];
            }
        };
    }
    
    if ([operationState isEqualToString:@"评价"]) {
        

    }
}


- (void)setupChildViewController{

    for (NSString *string in self.dataArray) {
        
        if ([string isEqualToString:@"订单"]) {
            
            CustomRequirementsDetailTabelViewController *oneVc = [[CustomRequirementsDetailTabelViewController alloc]init];
            NSArray *array = [[CustomRequirementsStore shearCustomRequirementsStore]configurationCustomRequirementsDetailWithMenu:_customRequirementsDetail];
            _customRequirementsDetaiVc = oneVc;
            [oneVc.dataArray addObjectsFromArray: array];
            [self addChildViewController:_customRequirementsDetaiVc];
        }
        
        if ([string isEqualToString:@"投标"]) {
            
            CustomRequirementsDesginListViewController *twoVc = [[CustomRequirementsDesginListViewController alloc]init];
            _customRequirementsDesginList = twoVc;
            [twoVc.dataArray  addObject:[[DesignerListStore shearDesignerListStore]configurationCustomRequirementsDegsinListWithRequstData:_customRequirementsDetail.designer_list]];
            [self addChildViewController:_customRequirementsDesginList];
        }
        if ([string isEqualToString:@"作品"]) {
            
            BiddingProductListViewController *product = [[BiddingProductListViewController alloc]init];
            product.demant_id = _customRequirementsDetail.demand.id;
            _biddingProductListVc = product;
            [self addChildViewController:_biddingProductListVc];
        }
        
        if ([string isEqualToString:@"设计师评价"] || [string isEqualToString:@"客户评价"]) {
            
            CustomRequirementsCommentsViewController *comments = [[CustomRequirementsCommentsViewController alloc]init];
            comments.userType = [[UserManager shareUserManager]crrentUserType] == UserTypeDesigner ? UserTypeMarketing : UserTypeDesigner;
            comments.customRequirementsComments = _customRequirementsOtherComments;
            _customRequirementsOtherCommentsVc = comments;
            [self addChildViewController:_customRequirementsOtherCommentsVc];
        }
        if ([string isEqualToString:@"我的评价"]) {
            
            CustomRequirementsCommentsViewController *comments = [[CustomRequirementsCommentsViewController alloc]init];
            comments.userType = [[UserManager shareUserManager]crrentUserType];
            comments.customRequirementsComments = _customRequirementsMyComments;
            _customRequirementsMyCommentsVc = comments;
            [self addChildViewController:_customRequirementsMyCommentsVc];
        }
    }
}
// 添加相应的控制器的view到内容视图中
- (void)addChildViewInContentViewWithIndex:(NSInteger)index{
    
    UIViewController *childView = self.childViewControllers[index];
    [self.scroll addSubview:childView.view];
    childView.view.frame = CGRectMake(index * ScreenWidth, 0, ScreenWidth, ScreenHeigh-NAVIGATION_HIGHT-154-TABBAR_HIGHT);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index = scrollView.contentOffset.x/ViewWidth;
    [self.segment selectIndex:index];
}

#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index{
    
    __weak typeof(self) weakSelf = self;
    //添加滚动动画
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.scroll.contentOffset = CGPointMake(ScreenWidth*index, 0);
    } completion:^(BOOL finished) {
        
    }];
}


@end
