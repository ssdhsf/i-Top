//
//  PopularizeManagementViewController.m
//  itop
//
//  Created by huangli on 2018/3/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "PopularizeManagementViewController.h"
#import "PopularizeItmeTableViewController.h"
#import "YYGestureRecognizer.h"

// 这个系数根据自己喜好设置大小，=屏幕视图滑动距离/手指滑动距离
#define  moveScale 2

//虚假的悬浮效果
static CGFloat floatViewHeight = 40.0;

@interface PopularizeManagementViewController ()<SegmentTapViewDelegate,UIScrollViewDelegate,UpdateFrameDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, strong)PopularizeItmeTableViewController *itemAllVc;
@property (nonatomic, strong)PopularizeItmeTableViewController *itemBeginVc;
@property (nonatomic, strong)PopularizeItmeTableViewController *itemGoingVc;
@property (nonatomic, strong)PopularizeItmeTableViewController *itemCancelVc;
@property (nonatomic, strong)PopularizeItmeTableViewController *itemEndVc;
@property (nonatomic, assign)NSInteger itmeIndex;//当前的选项

@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollerView;
@property (nonatomic ,strong)UIScrollView *scroll;
@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic,assign)CGFloat tableY;
@property (nonatomic,assign)CGFloat tableStartY;
@property (nonatomic,assign)CGFloat scrollY;
@property (nonatomic,assign)CGFloat scrollStartY;

//tableview 的y值 在scrollview中的位置
@property (nonatomic,assign)CGFloat scrollFrameY;

@end

@implementation PopularizeManagementViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    [self hiddenNavigationController:_isHome];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initNavigationBarItems{
    
    self.title = @"推广管理";
}

-(void)initView{
    
    [super initView];
    [self initSegment];
    [self createScrollView];
    
    YYGestureRecognizer *yyges = [YYGestureRecognizer new];
    yyges.action = ^(YYGestureRecognizer *gesture, YYGestureRecognizerState state){
        if (state != YYGestureRecognizerStateMoved) return ;
        
//        if (CGRectContainsPoint(self.itemAllVc.tableView.frame, gesture.startPoint)||
//            CGRectContainsPoint(self.itemBeginVc.tableView.frame, gesture.startPoint)||
//            CGRectContainsPoint(self.itemEndVc.tableView.frame, gesture.startPoint)||
//            CGRectContainsPoint(self.itemCancelVc.tableView.frame, gesture.startPoint)||
//            CGRectContainsPoint(self.itemGoingVc.tableView.frame, gesture.startPoint)) {
        
        if (CGRectContainsPoint(self.scroll.frame, gesture.startPoint)){
            
            [self scrollScrollWithGesture:gesture];
            
        }else{
           
            [self tableScrollWithGesture:gesture tableView:self.itemAllVc.tableView];
        }
            //滑动tableview
        
//        }else{
//            
//           // 滑动scrollview
//            [self scrollScrollWithGesture:gesture tableView:self.itemAllVc.tableView];
//        }
        
    };
    //必须给scroll 加上手势  不要给view加，不然滑动tablew的时候会错误判断去滑动scroll。
    [self.scroll addGestureRecognizer:yyges];
    
    //实现手势代理，解决交互冲突
    yyges.delegate = self;
     _rootScrollerView.scrollEnabled = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.rootScrollerView.contentSize = CGSizeMake(self.view.bounds.size.width, self.scroll.frame.origin.y+self.scroll.frame.size.height);
    self.rootScrollerView.delegate = self;
}

-(void)initData{
    
    self.dataArray = [NSArray arrayWithObjects:@"全部",@"待接单", @"进行中",@"已取消",@"已完成", nil];
    _itmeIndex = 0;
}

-(void)initSegment{
    
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 274, ScreenWidth, 40) withDataArray:self.dataArray withFont:15];
    self.segment.delegate = self;
    self.segment.lineColor = [UIColor clearColor];
    self.segment.textNomalColor = UIColorFromRGB(0x434a5c);
    self.segment.textSelectedColor = UIColorFromRGB(0xf95aee);
    [self.segment selectIndex:_itmeIndex];
    [self.rootScrollerView addSubview:self.segment];
}

-(void)createScrollView{
    
    if(_scroll){
        
        for(UIView *sub in _scroll.subviews)
            [sub removeFromSuperview];
        [_scroll removeFromSuperview];
        _scroll = nil;
    }
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 346, ScreenWidth, ScreenHeigh-40)];;
    [self.rootScrollerView addSubview:_scroll];
    _scroll.delegate = self;
    _scroll.contentSize = CGSizeMake(self.dataArray.count*ScreenWidth, ScreenHeigh);
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentOffset = CGPointMake(ScreenWidth*_itmeIndex, 0);
    [self setItmeWithItmeTitle:self.dataArray[_itmeIndex] itemIndex:_itmeIndex];
    
}

//解决手势按钮冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //如果是 segment或scroll上的其他按钮，取消手势
    if([NSStringFromClass(touch.view.superclass) isEqualToString:@"UIControl"]){
        return NO;
    }
    //
    return YES;
}

-(void)setItmeWithItmeTitle:(NSString *)itmeTitle itemIndex:(NSInteger )itemIndex{
    
    __weak typeof(self) weakSelf = self;
    switch (itemIndex) {
        case 0:
            if (!_itemAllVc) {
                
                _itemAllVc = [[PopularizeItmeTableViewController alloc]initWithNibName:@"PopularizeItmeTableViewController" bundle:nil];
                _itemAllVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-40);
//                _itemAllVc.orderStatus = OrderStatusTypeNoel;
                _itemAllVc.delegate = weakSelf;

            }
        [_scroll addSubview:_itemAllVc.view];
             
        break;
        case 1:
            if (!_itemBeginVc) {
                
                _itemBeginVc = [[PopularizeItmeTableViewController alloc]initWithNibName:@"PopularizeItmeTableViewController" bundle:nil];
                _itemBeginVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-64);
                _itemBeginVc.orderStatus = OrderStatusTypeReady;
                
            }
            [_scroll addSubview:_itemBeginVc.view];
            break;

        case 2:
            if (!_itemGoingVc) {
                
                _itemGoingVc = [[PopularizeItmeTableViewController alloc]initWithNibName:@"PopularizeItmeTableViewController" bundle:nil];
                _itemGoingVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-104);
//                _itemGoingVc.orderStatus = OrderStatusTypeGoOn;
                
            }
            [_scroll addSubview:_itemGoingVc.view];
            break;

        case 3:
            if (!_itemCancelVc) {
                
                _itemCancelVc = [[PopularizeItmeTableViewController alloc]initWithNibName:@"PopularizeItmeTableViewController" bundle:nil];
                _itemCancelVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-104);
//                _itemCancelVc.orderStatus = OrderStatusTypefail;
                
            }
            [_scroll addSubview:_itemCancelVc.view];
            break;

        case 4:
            if (!_itemEndVc) {
                
                _itemEndVc = [[PopularizeItmeTableViewController alloc]initWithNibName:@"PopularizeItmeTableViewController" bundle:nil];
                _itemEndVc.view.frame = CGRectMake(itemIndex*ScreenWidth, 0, ScreenWidth, ScreenHeigh-104);
                _itemEndVc.orderStatus = OrderStatusTypeSucess;
                
            }
            [_scroll addSubview:_itemEndVc.view];
            break;
    }
}

#pragma mark --- scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index = scrollView.contentOffset.x/ViewWidth;
    [self.segment selectIndex:index];
    [self setItmeWithItmeTitle:self.dataArray[index] itemIndex:index];
}

#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index{
    
    __weak typeof(self) weakSelf = self;
    //添加滚动动画
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.scroll.contentOffset = CGPointMake(ScreenWidth*index, 0);
    } completion:^(BOOL finished) {
        
        [self setItmeWithItmeTitle:self.dataArray[index] itemIndex:index];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    int index = scrollView.contentOffset.x/ViewWidth;
    [self.segment selectIndex:index];
    [self setItmeWithItmeTitle:self.dataArray[index] itemIndex:index];
}

-(void)updateScrollerViewFrameWithTableViewContentOffset:(CGFloat)contentOffsetY{
    
    NSLog(@"%lf",contentOffsetY);
}
 - (void)tableScrollWithGesture:(YYGestureRecognizer *)gesture tableView:(UITableView *)tableView{
     
   
     if (tableView.contentSize.height == 0) {
         
         [self scrollScrollWithGesture:gesture];
         return;
     }
//     else {
//         
//         
//         if (tableView.contentOffset.y  <= 0) {
//             
//             [self.rootScrollerView setContentOffset:CGPointMake(0, 0) animated:YES];
//
//         } else {
//             
//             [self.rootScrollerView setContentOffset:CGPointMake(0, 274) animated:YES];
//         }
//         
//     }
     
    CGFloat scrolly;
    
    if (self.tableStartY != gesture.startPoint.y) {
        scrolly = -(gesture.currentPoint.y-gesture.startPoint.y) ;
    }else{
        scrolly =  -(gesture.currentPoint.y-gesture.lastPoint.y) ;
    }
    self.tableStartY = gesture.startPoint.y;
    
    self.tableY += scrolly*moveScale;
    
    //为了显示底部超出屏幕的tableview那部分 滑动scrollview 此时tablewview已经滑动到了底部
     NSLog(@"%f---%f",self.rootScrollerView.bounds.size.height,tableView.bounds.size.height);
    if (self.tableY> tableView.contentSize.height-self.rootScrollerView.bounds.size.height){
        self.scrollY += self.tableY-(tableView.contentSize.height-self.rootScrollerView.bounds.size.height);
        
        //tablewview滑动到底部就不要滑了
        self.tableY = tableView.contentSize.height-self.rootScrollerView.bounds.size.height;
        
        //scrollview 滑动到了底部就不要滑动了
        if (self.scrollY> self.rootScrollerView.contentSize.height-tableView.bounds.size.height-floatViewHeight){
            
            NSLog(@"%f---%f",self.rootScrollerView.contentSize.height,tableView.bounds.size.height);
            self.scrollY = self.rootScrollerView.contentSize.height-tableView.bounds.size.height-floatViewHeight-floatViewHeight;
            //如果scrollview意外的contentsize 小于自己的大小，scrollview就不要滑了
            if (self.scrollY<0) {
                self.scrollY = 0;
            }
            
        }
        [self.rootScrollerView setContentOffset:CGPointMake(0, self.scrollY) animated:YES];
        
        //如果tablewview的cell过少或行高过少致使其contentsize 小于自己的大小，tableview就不要滑了
        if (self.tableY<0) {
            self.tableY = 0;
        }
        
    }
    
    //如果滑到了tableview的最上部，停止滑动tablewview,  如果此时scrollview 没有在最上部就滑动scrollview到最上部
    if (self.tableY<0){
        self.scrollY += self.tableY;
        
        //scroll已经在最上部了，scroll就不滑了
        if (self.scrollY<0) {
            self.scrollY = 0;
        }
        
        NSLog(@"scroll  %lf",self.scrollY);
        [self.scroll setContentOffset:CGPointMake(0, self.scrollY) animated:YES];
        
        //停止滑动tablewview
        self.tableY = 0;
        
    }
    NSLog(@"table  %lf",self.tableY);
    [tableView setContentOffset:CGPointMake(0, self.tableY) animated:YES];
}

- (void)scrollScrollWithGesture:(YYGestureRecognizer *)gesture{
//    CGFloat scrolly;
    
//    if (self.scrollStartY != gesture.startPoint.y) {
//        scrolly = -(gesture.currentPoint.y-gesture.startPoint.y) ;
//    }else{
//        scrolly = -(gesture.currentPoint.y-gesture.lastPoint.y) ;
//    }
//    self.scrollStartY = gesture.startPoint.y;
//    
//    self.scrollY += scrolly*moveScale;
    
    //如果滑到了scroll的底部就不要滑了
//    if (self.scrollY> self.rootScrollerView.contentSize.height-self.scroll.bounds.size.height-floatViewHeight){
//        self.scrollY = self.rootScrollerView.contentSize.height-self.scroll.bounds.size.height;
//        //如果scrollview意外的contentsize 小于自己的大小，scrollview就不要滑了
//        if (self.scrollY<0) {
//            self.scrollY = 0;
//        }
//    }
//    //如果滑到了scroll顶部就不要滑了
//    if (self.scrollY<0){
//        self.scrollY = 0;
//    }
//    NSLog(@"scroll  %lf",self.scrollY);
    
    if(gesture.startPoint.y - gesture.lastPoint.y > 0){
        
        [self.rootScrollerView setContentOffset:CGPointMake(0, 274) animated:YES];

    } else {
        
        [self.rootScrollerView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

@end
