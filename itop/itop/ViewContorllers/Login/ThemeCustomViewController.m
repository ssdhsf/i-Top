//
//  ThemeCustomViewController.m
//  itop
//
//  Created by huangli on 2018/1/19.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ThemeCustomViewController.h"
#import "ThemeCustomDataSource.h"
#import "ThemeCustomViewCollectionViewCell.h"
#import "ThemeCustomStore.h"

static NSString *const ThemeCustomCellIdentifier = @"ThemeCustom";

@interface ThemeCustomViewController ()

@property (nonatomic, strong)ThemeCustomDataSource *themeCustomDataSource;

@end

@implementation ThemeCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    
    [super initView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
//    layout.minimumInteritemSpacing = 20;
//    layout.sectionInset = UIEdgeInsetsMake(10, 10, 15, 10);
    [self initCollectionViewWithFrame:ControllerViewFrame(0, 0, ViewWidth, ViewHeigh) flowLayout:layout];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-44);
        make.top.mas_equalTo(self.view);
    }];

    [self steupCollectionView];
}

-(void)initData{
    
    [super initData];
    self.dataArray = [[ThemeCustomStore shearThemeCustomStore] configurationMenuWithMenu:nil];
}

-(void)steupCollectionView{
    
    CollectionViewCellConfigureBlock congfigureBlock = ^(ThemeCustomViewCollectionViewCell *cell , ThemeCustom *item, NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item];
        
    };
    
    CollectionViewCellHeaderConfigureBlock cellHeaderConfigureCellBlock = ^(UICollectionReusableView *headerView, NSIndexPath *indexPath){
        
        // headerView
        
    };
    self.themeCustomDataSource = [[ThemeCustomDataSource alloc]initWithItems:self.dataArray cellIdentifier:ThemeCustomCellIdentifier headerIdentifier:nil
                                                          cellConfigureBlock:congfigureBlock
                                                cellHeaderConfigureCellBlock:cellHeaderConfigureCellBlock
                                  ];
    [self steupCollectionViewWithDataSource:self.themeCustomDataSource
                             cellIdentifier:ThemeCustomCellIdentifier
                                    nibName:@"ThemeCustomViewCollectionViewCell"];
}

- (void)initNavigationBarItems {
    
    self.navigationItem.title = @"主题定制" ;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(60, 78);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(ScreenWidth, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    NSArray *arr = self.dataArray[section];
    CGFloat spaceX  = ((ScreenWidth-40)- arr.count*60)/2;
    return spaceX;
}


@end
