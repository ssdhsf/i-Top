//
//  DesignerListViewController.m
//  itop
//
//  Created by huangli on 2018/1/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DesignerListViewController.h"
#import "DesignerListDataSource.h"
#import "DesignerListViewCollectionViewCell.h"
#import "DesignerListStore.h"

static NSString *const DesignerListCellIdentifier = @"DesignerList";

@interface DesignerListViewController ()

@property (nonatomic, strong)DesignerListDataSource *designerListDataSource;

@end

@implementation DesignerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
}

- (void)initNavigationBarItems {
    
    self.navigationItem.title = @"设计师列表";
}

-(void)initView{
    
    [super initView];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 25;
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    //    layout.minimumInteritemSpacing = 20;
    //    layout.sectionInset = UIEdgeInsetsMake(10, 10, 15, 10);
    [self initCollectionViewWithFrame:ControllerViewFrame(0, 0, ViewWidth, ViewHeigh) flowLayout:layout];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.bottom.top.mas_equalTo(0);
    }];
    
    [self steupCollectionView];
}

-(void)initData{
    
    [super initData];
    [self showRefresh];
}

-(void)refreshData{
    
    if (!_designerListType) {
        _designerListType = DesignerListTypeHome;
    }

    [[UserManager shareUserManager]designerlistWithPageIndex:self.page_no PageCount:10 designerListType:_designerListType];
    [UserManager shareUserManager].designerlistSuccess = ^(NSArray * arr){
        
        [self listDataWithListArray:[[DesignerListStore shearDesignerListStore] configurationMenuWithMenu:arr] page:self.page_no];
    };

    [UserManager shareUserManager].errorFailure = ^ (id obj){
        
        [self collectionEndRefreshing];
    };
}

-(void)steupCollectionView{
    
     __weak typeof(self) weakSelf = self;
    CollectionViewCellConfigureBlock congfigureBlock = ^(DesignerListViewCollectionViewCell *cell , DesignerList *item, NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item DesignerListType:_designerListType index:indexPath.row];
        
        cell.focusUserBlock = ^(NSInteger index, DesignerListViewCollectionViewCell*designerListCell){
            
            DesignerList *designer = self.dataArray[index];
            
            if ([designer.follow integerValue] == 1 || _designerListType == DesignerListTypeFocus) { //当用户处于被关注的状态提示操作
                
                 [weakSelf alertOperationWithDesigner:designer cell:designerListCell index:index];
            } else {
                
                [weakSelf focusStateWithDesigner:designer cell:designerListCell index:index];
            }
        };
        
    };
    
    CollectionViewCellHeaderConfigureBlock cellHeaderConfigureCellBlock = ^(UICollectionReusableView *headerView, NSIndexPath *indexPath){
        
        // headerView
        
    };
    self.designerListDataSource = [[DesignerListDataSource alloc]initWithItems:self.dataArray cellIdentifier:DesignerListCellIdentifier headerIdentifier:nil
                                                          cellConfigureBlock:congfigureBlock
                                                cellHeaderConfigureCellBlock:cellHeaderConfigureCellBlock
                                  ];
    [self steupCollectionViewWithDataSource:self.designerListDataSource
                             cellIdentifier:DesignerListCellIdentifier
                                    nibName:@"DesignerListViewCollectionViewCell"];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(ScreenWidth/3, (ScreenWidth/3-47)+5+18+5+8+16+5+28+16);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(ScreenWidth, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DesignerList *designer = [_designerListDataSource itemAtIndexPath:indexPath];
    if (_designerListType) {
      
        _pushDesignerDetailControl(designer.follow_user_id);
        
    }else {
        
        [UIManager designerDetailWithDesignerId:designer.id];

    }
}


-(void)alertOperationWithDesigner:(DesignerList*)designer
                             cell:(DesignerListViewCollectionViewCell*)designerListCell
                            index:(NSInteger )index{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否取消关注该用户" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self focusStateWithDesigner:designer cell:designerListCell index:index];
//        [self back];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)focusStateWithDesigner:(DesignerList*)designer cell:(DesignerListViewCollectionViewCell*)designerListCell index:(NSInteger )index{
    
    if (_designerListType == DesignerListTypeFocus) {
        
        [[UserManager shareUserManager]focusOnUserWithUserId:[NSString stringWithFormat:@"%@",designer.follow_user_id] focusType:FocusTypeFocus];
        [UserManager shareUserManager].focusOnUserSuccess = ^ (id obj ){

            [self.dataArray removeObjectAtIndex:index];
            [self.collectionView reloadData];
        };
        
    }else {
        [[UserManager shareUserManager]focusOnUserWithUserId:[NSString stringWithFormat:@"%@",designer.id] focusType:[designer.follow integerValue]];
        [UserManager shareUserManager].focusOnUserSuccess = ^ (id obj ){
            
            if ([designer.follow integerValue] == 0) {
                
                designer.follow = @1;
                [designerListCell setupFocusStateWithhFocus:YES];
                [[Global sharedSingleton]showToastInCenter:self.view withMessage:FOCUSSTATETITLE_SUCCESSFOCUS];
            } else {
                
                designer.follow = @0;
                [designerListCell setupFocusStateWithhFocus:NO];
                [[Global sharedSingleton]showToastInCenter:self.view withMessage:FOCUSSTATETITLE_CANCELFOCUS];
            }
        };
    }
}

@end
