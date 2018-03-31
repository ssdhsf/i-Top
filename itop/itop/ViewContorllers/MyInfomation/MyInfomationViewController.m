//
//  MyInfomationViewController.m
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MyInfomationViewController.h"
#import "MyInfomation.h"
#import "MyInfomationStore.h"
#import "MyInfomationDataSource.h"
#import "MyInfomationCollectionViewCell.h"
#import "MyInfomationSectionHeaderView.h"
#import "InfomationViewController.h"

static NSString *const MyInfomationCellIdentifier = @"MyInfomation";

@interface MyInfomationViewController ()

@property (nonatomic ,strong)MyInfomationDataSource *myInfomationDataSource;

@property (strong, nonatomic) UIButton *iconImageView;
@property (strong, nonatomic) UILabel *userNameLabel;

@end

@implementation MyInfomationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [[ShearViewManager sharedShearViewManager]setupShearView];
    [ShearViewManager sharedShearViewManager].selectShearItme = ^(NSInteger tag){
        
    };
}


-(void)initView{
    
    [super initView];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0,0 , 30, 0);
    [self initCollectionViewWithFrame:ControllerViewFrame(0, 0, ViewWidth, ViewHeigh) flowLayout:layout];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.left.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-20);
    }];
    [self steupCollectionView];
}

-(void)initData{
    
    [super initData];
    UserModel *user = [[UserManager shareUserManager]crrentUserInfomation];
    self.dataArray = [[MyInfomationStore shearMyInfomationStore] configurationMenuWithUserType:[user.user_type integerValue]];
    
    [UIManager sharedUIManager].backOffBolck = ^(id obj){
        
        [[UserManager shareUserManager]userInfomationWithUserType:[[UserManager shareUserManager] crrentUserType]];
        [UserManager shareUserManager].userInfoSuccess = ^(id obj){
            
        InfomationModel * info = [[InfomationModel alloc]initWithDictionary:obj error:nil];
            [[Global sharedSingleton]
             setUserDefaultsWithKey:INFOMATION_EDIT_MODEL([[UserManager shareUserManager]crrentUserId])
             andValue:[info toJSONString]];
            [self.collectionView reloadData];
        };
    };
}

-(void)steupCollectionView{
    
    CollectionViewCellConfigureBlock congfigureBlock = ^(MyInfomationCollectionViewCell*cell , MyInfomation *item, NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item];
        
    };
    
    CollectionViewCellHeaderConfigureBlock cellHeaderConfigureCellBlock = ^(UICollectionReusableView *headerView, NSIndexPath *indexPath){
        
        for (UIView *view in headerView.subviews) {
            
            if ([view isKindOfClass: [MyInfomationSectionHeaderView class]]) {
                
                [view removeFromSuperview];
            }
        }
        MyInfomationSectionHeaderView *infView = [[MyInfomationSectionHeaderView alloc] init];
        infView.sectionHeader = ^(){
            
            [self nextBaseInfomationVc];
            
        };
        infView.frame = headerView.bounds; //TODO
        [infView initMyInfoSubViewsWithSection:indexPath.section];
        infView.backgroundColor = UIColor.whiteColor;
        [headerView addSubview:infView];
        
    };
    self.myInfomationDataSource = [[MyInfomationDataSource alloc]initWithItems:self.dataArray cellIdentifier:MyInfomationCellIdentifier headerIdentifier:nil
                                                cellConfigureBlock:congfigureBlock
                                      cellHeaderConfigureCellBlock:cellHeaderConfigureCellBlock
                             ];
    [self steupCollectionViewWithDataSource:self.myInfomationDataSource
                             cellIdentifier:MyInfomationCellIdentifier
                                    nibName:@"MyInfomationCollectionViewCell"];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(ScreenWidth/4, 91);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return CGSizeMake(ScreenWidth, 260);
    }
    return CGSizeMake(ScreenWidth, 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyInfomation*info = [_myInfomationDataSource itemAtIndexPath:indexPath];
    
    if ([info.myInfoTitle isEqualToString:@"意见反馈"]){
        
        [UIManager customerServiceAndFeedbackWithTitle:info.myInfoTitle];
        
    }else if ([info.myInfoTitle isEqualToString:@"作品"]){
        
        [UIManager productViewControllerWithType:GetProductListTypeMyProduct];
    }else if ([info.myInfoTitle isEqualToString:@"分享"]){
        
        [[ShearViewManager sharedShearViewManager]addShearViewToView:self.view shearType:UMS_SHARE_TYPE_IMAGE_URL completion:^(NSInteger tag) {
            ShearInfo *sherInfo = [[ShearInfo alloc]init];
            sherInfo.shear_title = @"itop";
            sherInfo.shear_discrimination = @"H5内容制作";
            sherInfo.shear_thume_image = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
            sherInfo.shear_webLink = @"http://www.i-top.cn/Page/m/introduce.html ";
            [[ShearViewManager sharedShearViewManager]shareWebPageToPlatformType:tag parameter:sherInfo];
        } ];

    }
    else {
        
        [UIManager showVC:info.nextVcName];
    }
}

-(void)nextBaseInfomationVc{
  
    InfomationViewController *infoVc = [[InfomationViewController alloc]init];
    infoVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:infoVc animated:YES];
}

@end
