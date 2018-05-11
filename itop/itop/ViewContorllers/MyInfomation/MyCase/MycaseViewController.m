//
//  MycaseViewController.m
//  itop
//
//  Created by huangli on 2018/5/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MycaseViewController.h"
#import "MyWorksStore.h"
#import "MyWorksDataSource.h"
#import "H5ListCollectionViewCell.h"
#import "EditCaseStore.h"

static NSString *const MycaseCellIdentifier = @"Mycase";
@interface MycaseViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) MyWorksDataSource *myWorksDataSource;
@property (nonatomic, strong) NSDictionary *config;
@property (nonatomic, strong) NSArray *titleArray;
@property (strong, nonatomic) UIView *editorBgView;
@property (strong, nonatomic) IBOutlet UIView *editorView;
@property (nonatomic, strong) NSString *link;

@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) EditCase *editCase;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger currentOffset;
@property (nonatomic, strong) UIImageView *instruct;

@end

@implementation MycaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIManager sharedUIManager].editCaseBackOffBolck = ^(id product){
        
        [self collectionBeginRefreshing];
    };
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigafindHairlineImageView:YES];
    [self hiddenNavigationController:NO];
    self.navigationItem.rightBarButtonItem.tintColor = RGB(232, 98, 159);
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    if (!self.editorBgView) {
        
        [self setupEditor];
        [self steupEditorBuuton];
    }
    
    [[ShearViewManager sharedShearViewManager]setupShearViewWithshearType:ShearTypeProduct];
    [ShearViewManager sharedShearViewManager].selectShearItme = ^(NSInteger tag){
        
    };
}

-(void)initNavigationBarItems{
    
    [super initNavigationBarItems];
    self.navigationItem.title = @"我的案例";
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
    
    [self steupCollectionView];
}

-(void)initData{
    
    [super initData];
    [self showRefresh];
    
    NSDictionary * config = [[MyWorksStore shearMyWorksStore]editMycaseConfigurationMenu];
    self.config = config[@"config"];
    self.titleArray = config[@"title"];
}

-(void)setupEditor{
    
    self.editorBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigh)];
    self.editorBgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    [self.view.window addSubview:self.editorBgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelEditor:)];
    [self.editorBgView addGestureRecognizer:tap];
    self.editorBgView.hidden = YES;
}

- (void)refreshData{
    
    [[UserManager shareUserManager]myCaseListWithPageIndex:self.page_no PageCount:10 getCaseType:_getCaseType];
    [UserManager shareUserManager].myCaseListSuccess = ^(NSArray * arr){
        
        if (arr.count == 0) {
            
            self.noDataType = NoDataTypeProduct;
            self.originY = 0;
        } else {
            
        }
        [self listDataWithListArray:[[EditCaseStore shearEditCaseStore] configurationEditCaseStoreWithRequsData:arr] page:self.page_no];
    };
    
    [UserManager shareUserManager].errorFailure = ^ (id obj){
        
        [self collectionEndRefreshing];
    };
}

-(void)steupCollectionView{
    
    CollectionViewCellConfigureBlock congfigureBlock = ^(H5ListCollectionViewCell *cell , EditCase *item, NSIndexPath *indexPath){
        
         [cell setMyCaseListItmeOfModel:item getCaseType:_getCaseType];
    };
    
    CollectionViewCellHeaderConfigureBlock cellHeaderConfigureCellBlock = ^(UICollectionReusableView *headerView, NSIndexPath *indexPath){
        
        
    };
    
    self.myWorksDataSource = [[MyWorksDataSource alloc]initWithItems:self.dataArray
                                                      cellIdentifier:MycaseCellIdentifier headerIdentifier:nil
                                                  cellConfigureBlock:congfigureBlock
                                        cellHeaderConfigureCellBlock:cellHeaderConfigureCellBlock
                              ];
    [self steupCollectionViewWithDataSource:self.myWorksDataSource
                             cellIdentifier:MycaseCellIdentifier
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
    
    _editCase = [_myWorksDataSource itemAtIndexPath:indexPath];
//    if (_showProductType == GetProductListTypeSelect) {
//
//        [self back];
//        [UIManager sharedUIManager].selectProductBolck(_h5);
//
//    } else {
        _currentIndex = indexPath.row;
        [self editoeViewWithAnimation:YES];
        NSLog(@"23");
//    }
}

- (void)editor:(UIButton *)sender {
    
    [self editoeViewWithAnimation:NO];
    
    if ([sender.titleLabel.text isEqualToString:@"添加"]) {
        
        [UIManager editCaseViewControllerIsEdit:NO editCase:nil];
    }
    if ([sender.titleLabel.text isEqualToString:@"编辑"]) {
       [UIManager editCaseViewControllerIsEdit:YES editCase:_editCase];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"预览"]) {
           [UIManager pushTemplateDetailViewControllerWithTemplateId:_editCase.id productType:H5ProductTypeCase];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"分享"]) {
        [[ShearViewManager sharedShearViewManager]addShearViewToView:self.view shearType:UMS_SHARE_TYPE_WEB_LINK completion:^(NSInteger tag) {
            
            [[ShearViewManager sharedShearViewManager]shareWebPageToPlatformType:tag parameter:[[ShearViewManager sharedShearViewManager] shearInfoWithProduct:_editCase]];
        } ];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"复制链接"]) {
        [self copyTheLinkWithLinkUrl:_editCase.url];
    }
    if ([sender.titleLabel.text isEqualToString:@"二维码"]) {
        [UIManager  qrCodeViewControllerWithCode:_editCase.url];
    }
    if ([sender.titleLabel.text isEqualToString:@"删除"]) {
        [self alertOperation];
    }
}

-(void)copyTheLinkWithLinkUrl:(NSString *)linkUrl{
    
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = linkUrl;
    
//    if ([paste.string isEqualToString:_link]) {
    
        [[Global sharedSingleton] showToastInTop:self.view withMessage:@"复制成功"];
//    }
}

-(void)steupEditorBuuton{
    
    UIScrollView * scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, 251-50)];
    [self.editorView addSubview:scroll];
    scroll.delegate = self;
    NSInteger page= self.titleArray.count/8;
    if (self.titleArray.count%8 != 0) {
        page = page +1;
    }
    scroll.contentSize = CGSizeMake(page*ScreenWidth, 251-50);
    scroll.pagingEnabled=YES;
    scroll.showsHorizontalScrollIndicator = NO;
    self.editorView.frame = CGRectMake(0, ScreenHeigh, ScreenWidth, 251);
    self.editorView.backgroundColor = [UIColor whiteColor];
    [self.editorBgView addSubview:self.editorView];
    
    for (int i = 0; i < self.titleArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if ((i/4)%2<1) {
            button.frame = CGRectMake((i%4)*(ScreenWidth/4)+((i/8)*ScreenWidth), 0, ScreenWidth/4, (251-50)/2);
            
        } else {
            
            button.frame = CGRectMake((i%4)*(ScreenWidth/4)+((i/8)*ScreenWidth), (251-50)/2, ScreenWidth/4, (251-50)/2);
        }
        
        if (i>7) {
            
            _instruct = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth -25, 201/2-12.5, 25, 25)];
            [scroll addSubview:_instruct];
            _instruct.image = [UIImage imageNamed:@"purse_icon_more"];
            _currentOffset = 0;
        }
        
        [button addTarget:self action:@selector(editor:) forControlEvents:UIControlEventTouchDown];
        
        [scroll addSubview:button];
        NSString *string = self.titleArray[i];
        [button setTitle:string forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.config[string]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.frame.size.height+21 ,-button.imageView.frame.size.width, 0.0,0.0)];
        
        CGFloat cha = button.titleLabel.bounds.size.width - button.imageView.frame.size.width;
        if (cha > 6) {
            [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -button.titleLabel.bounds.size.width - cha+6)];
        } else {
            [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -button.titleLabel.bounds.size.width)];
        }
        button.tag = i;
    }
}

#pragma mark --- scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index = scrollView.contentOffset.x/ViewWidth;
    if (index < _currentOffset) {
        
        _instruct.frame = CGRectMake(ScreenWidth -25, 201/2-12.5, 25, 25);
        _instruct.image = [UIImage imageNamed:@"purse_icon_more"];
    }else if (index > _currentOffset){
        
        _instruct.frame = CGRectMake(index*ScreenWidth, 201/2-12.5, 25, 25);
        _instruct.image = [UIImage imageNamed:@"nav_icon_back"];
    }else{
        
        NSLog(@"本页");
    }
    
    _currentOffset = index;
}

-(void)search{
    
}

- (IBAction)cancel:(UIButton *)sender {
    
    self.editorBgView.hidden = YES;
    [self editoeViewWithAnimation:NO];
}

-(void)cancelEditor:(UITapGestureRecognizer *)sender{
    
    CGPoint point = [sender locationInView:self.view];
    NSLog(@"handleSingleTap!pointx:%f,y:%f",point.x,point.y);
    
    NSLog(@"%f",ScreenHeigh);
    if (point.y < ScreenHeigh - 251-64) {
        
        self.editorBgView.hidden = YES;
        [self editoeViewWithAnimation:NO];
    }
}

-(void)editoeViewWithAnimation:(BOOL)animation{
    
    __weak typeof(self) weakSelf = self;
    //添加滚动动画
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat editViewHeight = kDevice_Is_iPhoneX ? 286 : 251;
        self.editorBgView.hidden = !animation;
        if (animation) {
            weakSelf.editorView.frame = CGRectMake(0, ScreenHeigh-editViewHeight, ScreenWidth, editViewHeight);
        }else {
            weakSelf.editorView.frame = CGRectMake(0, ScreenHeigh, ScreenWidth, 300);
        }
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)deleteProductWithId:(NSNumber *)product_id{
    
    [[UserManager shareUserManager]deleteMyCaseWithCaseId:product_id];
    [UserManager shareUserManager].deledeProductSuccess = ^(id obj){
        
        [self.dataArray removeObjectAtIndex:_currentIndex];
        [self.collectionView reloadData];
        
        NSLog(@"%@",obj);
    };
}

-(void)alertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除案例后数据不可恢复，确定要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self  deleteProductWithId:_editCase.id];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
