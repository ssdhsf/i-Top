//
//  MyWorksViewCotroller.m
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MyWorksViewCotroller.h"
#import "MyWorksStore.h"
#import "MyWorksDataSource.h"
#import "H5ListCollectionViewCell.h"
#import "LeaveViewController.h"

static NSString *const MyWorksCellIdentifier = @"MyWork";

@interface MyWorksViewCotroller ()

@property (nonatomic, strong) MyWorksDataSource *myWorksDataSource;
@property (nonatomic, strong) NSDictionary *imageArrayTitle;
@property (nonatomic, strong) NSArray *titleArray;
@property (strong, nonatomic) UIView *editorBgView;
@property (strong, nonatomic) IBOutlet UIView *editorView;
@property (nonatomic, strong) NSString *link;

@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UIView *navBgView;
@property (nonatomic, strong) H5List *h5;

@end

@implementation MyWorksViewCotroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (self.navigationController.navigationBar.hidden) {
        [self hiddenNavigationController:NO];
    } else {
        [self setLeftCustomBarItem:@"" action:nil];
    }
    
    [self setRightCustomBarItem:@"hot_icon_search" action:@selector(search)];
    [self hiddenNavigafindHairlineImageView:NO];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initView{
    
    [super initView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self initCollectionViewWithFrame:ControllerViewFrame(0, 0, ViewWidth, ViewHeigh) flowLayout:layout];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.top.mas_equalTo(self.view);
    }];
    
    [self setupEditor];
    [self steupCollectionView];
    [self steupEditorBuuton];
}

-(void)initData{
    
    [super initData];
    [self showRefresh];
    self.imageArrayTitle = @{@"编辑":@"zuo_icon_edit",
                             @"预览":@"zuo_icon_preview",
                             @"留资":@"zuo_icon_liuzi",
                             @"设置":@"zuo_icon_set",
                             @"分享":@"zuo_icon_share",
                             @"复制链接":@"zuo_icon_link",
                             @"二维码":@"zuo_icon_code",
                             @"删除":@"zuo_icon_delete"};
    self.titleArray = @[@"编辑",@"预览",@"留资",@"设置",@"分享",@"复制链接",@"二维码",@"删除",];
}

-(void)setupEditor{
    
    self.editorBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigh-300)];
    self.editorBgView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
    [self.view addSubview:self.editorBgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelEditor)];
    [self.editorBgView addGestureRecognizer:tap];
    self.editorBgView.hidden = YES;
}

- (void)refreshData{
    
    [[UserManager shareUserManager]myProductListWithProductType:100 PageIndex:self.page_no PageCount:10];
    [UserManager shareUserManager].myProductListSuccess = ^(NSArray * obj){
        
        NSLog(@"%@",obj);
        
        [self listDataWithListArray:[[MyWorksStore shearMyWorksStore] configurationMenuWithMenu:obj] page:self.page_no];
    };
    
    [UserManager shareUserManager].errorFailure = ^ (id obj){
        
        [self collectionEndRefreshing];
    };
}

-(void)steupCollectionView{
    
    CollectionViewCellConfigureBlock congfigureBlock = ^(H5ListCollectionViewCell *cell , H5List *item, NSIndexPath *indexPath){
        
        [cell setMyWorkLietItmeOfModel:item];
        
    };
    
    CollectionViewCellHeaderConfigureBlock cellHeaderConfigureCellBlock = ^(UICollectionReusableView *headerView, NSIndexPath *indexPath){
        
        
    };
    
    self.myWorksDataSource = [[MyWorksDataSource alloc]initWithItems:self.dataArray
                                                    cellIdentifier:MyWorksCellIdentifier headerIdentifier:nil
                                                cellConfigureBlock:congfigureBlock
                                      cellHeaderConfigureCellBlock:cellHeaderConfigureCellBlock
                             ];
    [self steupCollectionViewWithDataSource:self.myWorksDataSource
                             cellIdentifier:MyWorksCellIdentifier
                                    nibName:@"H5ListCollectionViewCell"];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((ScreenWidth-20)/3, ((ScreenWidth-20)/3-20)*1.69+32+5+5+7+9);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake((ScreenWidth-20), 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _h5 = [_myWorksDataSource itemAtIndexPath:indexPath];
     [self editoeViewWithAnimation:YES];
      NSLog(@"23");
    
}

- (void)editor:(UIButton *)sender {
    
    [self editoeViewWithAnimation:NO];
    switch (sender.tag) {
        case 2:
            
            [UIManager leaveWithProductId:_h5.id leaveType:GetLeaveListTypeProduct];
            break;
            
        case 5:
            
            _link = @"http";
            [self copyTheLinkWithLinkUrl:_link];
            break;
            
        default:
            break;
    }
    
    NSLog(@"%ld",sender.tag);
}

-(void)copyTheLinkWithLinkUrl:(NSString *)linkUrl{
    
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = linkUrl;
    
    if ([paste.string isEqualToString:_link]) {
        
        [[Global sharedSingleton] showToastInTop:self.view withMessage:@"复制成功"];
    }
}

-(void)steupEditorBuuton{
    
    self.editorView.frame = CGRectMake(0, ScreenHeigh, ScreenWidth, 300);
    self.editorView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.editorView];

    for (int i = 0; i < self.titleArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UILabel *label = [[UILabel alloc]init];
        if (i < 4) {
            button.frame = CGRectMake(47+i*47+(((ScreenWidth-(47*5))/4)*i), 68, ((ScreenWidth-(47*5))/4), ((ScreenWidth-(47*5))/4));
            
            label.frame = CGRectMake(10+i*10+(((ScreenWidth-(10*5))/4)*i), CGRectGetMaxY(button.frame)+5, ((ScreenWidth-(10*5))/4),19);
            
        } else {
            button.frame = CGRectMake(47+(i-4)*47+(((ScreenWidth-(47*5))/4)*(i-4)), 68+((ScreenWidth-(47*5))/4)+27+24, ((ScreenWidth-(47*5))/4), ((ScreenWidth-(47*5))/4));
            
            label.frame = CGRectMake(10+(i-4)*10+(((ScreenWidth-(10*5))/4)*(i-4)), CGRectGetMaxY(button.frame)+5,((ScreenWidth-(10*5))/4),19);
        }
        
        [button addTarget:self action:@selector(editor:) forControlEvents:UIControlEventTouchDown];
         label.centerX = button.centerX;
        
//        NSLog(@"%f--%f--%f--%f",button.frame.origin.x,button.frame.origin.y,button.frame.size.height,button.frame.size.width);
//        button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.frame.size.height+5, -button.imageView.bounds.size.width, 0,0);
//        // button图片的偏移量
//        button.imageEdgeInsets = UIEdgeInsetsMake(0, button.titleLabel.frame.size.width/2,button.titleLabel.frame.size.height+5, -button.titleLabel.frame.size.width/2);
        
        NSString *string = self.titleArray[i];
        [button setImage:[UIImage imageNamed:self.imageArrayTitle[string]] forState:UIControlStateNormal];
        label.text = string;
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        button.tag = i;
        [self.editorView addSubview:button];
        [self.editorView addSubview:label];
    }
}

- (IBAction)cancel:(UIButton *)sender {
    
    self.editorBgView.hidden = YES;
    [self editoeViewWithAnimation:NO];
}

-(void)cancelEditor{
    
    self.editorBgView.hidden = YES;
    [self editoeViewWithAnimation:NO];
}

-(void)editoeViewWithAnimation:(BOOL)animation{
    
    [self.navigationController.tabBarController.tabBar setHidden:animation];
    __weak typeof(self) weakSelf = self;
    //添加滚动动画
    [UIView animateWithDuration:0.2 animations:^{
        
        if (animation) {
             weakSelf.editorView.frame = CGRectMake(0, ScreenHeigh-300, ScreenWidth, 300);
        }else {
             weakSelf.editorView.frame = CGRectMake(0, ScreenHeigh, ScreenWidth, 300);
            
        }
       
    } completion:^(BOOL finished) {

        self.editorBgView.hidden = !animation;
    }];
}

//- (void)setNavBar{
//    
//    UIView *navBgView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, ScreenWidth, 64)];
//    [self.navigationController.navigationBar addSubview:navBgView];
//    self.navBgView = navBgView;
//    navBgView.backgroundColor = [UIColor clearColor];
//    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.searchBtn.frame = CGRectMake(ScreenWidth-50 , 30, 25 , 25 );
//    [self.searchBtn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchDown];
//    [navBgView addSubview:self.searchBtn];
//    [self.searchBtn setImage:[UIImage imageNamed:@"hot_icon_search"] forState:UIControlStateNormal];
//}


@end
