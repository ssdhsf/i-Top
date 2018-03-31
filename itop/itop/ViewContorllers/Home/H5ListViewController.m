//
//  H5ListViewController.m
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "H5ListViewController.h"
#import "H5ListCollectionViewCell.h"
#import "H5ListDataSource.h"
#import "H5ListStore.h"
#import "HotDetailsViewController.h"

static NSString *const H5ListCellIdentifier = @"H5List";

@interface H5ListViewController ()

@property (nonatomic, strong)H5ListDataSource *h5ListDataSource;
@end

@implementation H5ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigafindHairlineImageView:YES];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)initNavigationBarItems {
    
    self.navigationItem.title = _titleStr;
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
//       NSForegroundColorAttributeName:UIColorFromRGB(0x434a5c)}];
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.shadowImage=[self imageWithColor:[UIColor clearColor] size:CGSizeMake(ScreenWidth, 1)];
}

//-(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
//{
//    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return image;
//}


//-(UIImageView *)findHairlineImageViewUnder:(UIView *)view {
//    
//    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
//        return (UIImageView *)view;
//    }
//    for (UIView *subview in view.subviews) {
//        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
//        if (imageView) {
//            return imageView;
//        }
//    }
//    return nil;
//}


-(void)initView{
    
    [super initView];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
    //    layout.minimumInteritemSpacing = 20;
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
}

- (void)refreshData{
    
//    if (_getH5ListType == GetH5ListTypeProduct) {
    
    [[UserManager shareUserManager]homeH5ListWithType:_h5ProductType PageIndex:self.page_no PageCount:10 tagList:_tagList searchKey:nil];
    [UserManager shareUserManager].homeH5ListSuccess = ^ (NSArray *arr){
        
        [self listDataWithListArray:[[H5ListStore shearH5ListStore] configurationMenuWithMenu:arr] page:self.page_no];
    };
//    } else { //获取TagListH5
//        
//        [[UserManager shareUserManager]tagH5ListWithType:TagH5ListProduct PageIndex:self.page_no PageCount:10];
//        [UserManager shareUserManager].tagListSuccess = ^(NSArray *arr){
//          
//             [self listDataWithListArray:[[H5ListStore shearH5ListStore] configurationMenuWithMenu:arr] page:self.page_no];
//        };
//    }
    
    [UserManager shareUserManager].errorFailure = ^ (id obj){
        
        [self collectionEndRefreshing];
    };

}

-(void)steupCollectionView{
    
    CollectionViewCellConfigureBlock congfigureBlock = ^(H5ListCollectionViewCell *cell , H5List *item, NSIndexPath *indexPath){
        
        [cell setH5LietItmeOfModel:item];
        
    };
    
    CollectionViewCellHeaderConfigureBlock cellHeaderConfigureCellBlock = ^(UICollectionReusableView *headerView, NSIndexPath *indexPath){
        
        // headerView
        
    };
    self.h5ListDataSource = [[H5ListDataSource alloc]initWithItems:self.dataArray cellIdentifier:H5ListCellIdentifier headerIdentifier:nil
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
    [UIManager pushTemplateDetailViewControllerWithTemplateId:h5.id];
//    HotDetailsViewController *hotDetailsVc = [[HotDetailsViewController alloc]init];
//    hotDetailsVc.hotDetail_id = h5.id;
//    hotDetailsVc.itemDetailType = H5ItemDetailType;
//    hotDetailsVc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:hotDetailsVc animated:YES];

}

@end
