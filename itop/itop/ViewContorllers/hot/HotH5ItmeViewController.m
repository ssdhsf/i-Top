//
//  HotH5ItmeViewController.m
//  itop
//
//  Created by huangli on 2018/1/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "HotH5ItmeViewController.h"
#import "H5ListStore.h"
#import "H5ListDataSource.h"
#import "H5ListCollectionViewCell.h"

static NSString *const H5ListCellIdentifier = @"H5List";

@interface HotH5ItmeViewController ()

@property (nonatomic, strong)H5ListDataSource *h5ListDataSource;

@end

@implementation HotH5ItmeViewController

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
    
    [[UserManager shareUserManager]hotListWithType:_itemType == H5ItmeViewController? ArticleTypeH5 : ArticleTypeVideo PageIndex:1 PageCount:10 getArticleListType:_getArticleListType];
    [UserManager shareUserManager].hotlistSuccess = ^(NSArray * obj){
        
        NSLog(@"%@",obj);
        
        [self listDataWithListArray:[[H5ListStore shearH5ListStore] configurationMenuWithMenu:obj] page:self.page_no];
    };
    
    [UserManager shareUserManager].errorFailure = ^ (id obj){
      
        [self collectionEndRefreshing];
    };
}

-(void)steupCollectionView{
    
    CollectionViewCellConfigureBlock congfigureBlock = ^(H5ListCollectionViewCell *cell , H5List *item, NSIndexPath *indexPath){
        
        [cell setH5LietItmeOfModel:item];
        
    };
    
    CollectionViewCellHeaderConfigureBlock cellHeaderConfigureCellBlock = ^(UICollectionReusableView *headerView, NSIndexPath *indexPath){
        
        
    };
    
    self.h5ListDataSource = [[H5ListDataSource alloc]initWithItems:self.dataArray
                                                    cellIdentifier:H5ListCellIdentifier headerIdentifier:nil
                                                cellConfigureBlock:congfigureBlock
                                      cellHeaderConfigureCellBlock:cellHeaderConfigureCellBlock
                             ];
    [self steupCollectionViewWithDataSource:self.h5ListDataSource
                             cellIdentifier:H5ListCellIdentifier
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
  
//    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    H5List *h5 = [_h5ListDataSource itemAtIndexPath:indexPath];
    _pushH5DetailControl(h5.id);
}

@end
