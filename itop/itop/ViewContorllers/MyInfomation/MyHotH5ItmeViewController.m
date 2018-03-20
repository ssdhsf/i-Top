//
//  MyHotH5ItmeViewController.m
//  itop
//
//  Created by huangli on 2018/3/15.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MyHotH5ItmeViewController.h"
#import "H5ListStore.h"
#import "H5ListDataSource.h"
#import "MyHotH5ItmeViewCell.h"

static NSString *const MyHotH5ItmeCellIdentifier = @"MyHot";

@interface MyHotH5ItmeViewController ()

@property (nonatomic, strong)H5ListDataSource *h5ListDataSource;

@end

@implementation MyHotH5ItmeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)setItemType:(ItemType)itemType{
    
    _itemType = itemType;
}


-(void)initView{
    
    [super initView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
    //    layout.minimumInteritemSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self initCollectionViewWithFrame:ControllerViewFrame(0, 65, ViewWidth, ViewHeigh-65) flowLayout:layout];
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
}

- (void)refreshData{
    
    [[UserManager shareUserManager]hotListWithType:_itemType == H5ItmeViewController?
                                    ArticleTypeH5 : ArticleTypeVideo
                                         PageIndex:self.page_no
                                         PageCount:10
                                getArticleListType:GetArticleListTypeMyHot];
    [UserManager shareUserManager].hotlistSuccess = ^(NSArray * obj){
        
        
        [self listDataWithListArray:[[H5ListStore shearH5ListStore] configurationMenuWithMenu:obj] page:self.page_no];
    };
    
    [UserManager shareUserManager].errorFailure = ^ (id obj){
        
        [self collectionEndRefreshing];
    };
}

-(void)steupCollectionView{
    
    CollectionViewCellConfigureBlock congfigureBlock = ^(MyHotH5ItmeViewCell *cell , H5List *item, NSIndexPath *indexPath){
        
        [cell setMyHotListItmeOfModel:item];
        
    };
    
    CollectionViewCellHeaderConfigureBlock cellHeaderConfigureCellBlock = ^(UICollectionReusableView *headerView, NSIndexPath *indexPath){
        
    };
    
    self.h5ListDataSource = [[H5ListDataSource alloc]initWithItems:self.dataArray
                                                    cellIdentifier:MyHotH5ItmeCellIdentifier
                                                  headerIdentifier:nil
                                                cellConfigureBlock:congfigureBlock
                                      cellHeaderConfigureCellBlock:cellHeaderConfigureCellBlock
                             ];
    [self steupCollectionViewWithDataSource:self.h5ListDataSource
                             cellIdentifier:MyHotH5ItmeCellIdentifier
                                    nibName:@"MyHotH5ItmeViewCell"];
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
    
    //    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    H5List *h5 = [_h5ListDataSource itemAtIndexPath:indexPath];
    _pushMyHotH5Control(h5);
}

@end
