//
//  SearchViewController.m
//  itop
//
//  Created by huangli on 2018/3/9.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SearchViewController.h"
#import "CarouselScrollView.h"
#import "H5ListStore.h"
#import "DesignerListStore.h"
#import "HomeStore.h"
#import "DesignerListViewCollectionViewCell.h"
#import "H5ListCollectionViewCell.h"
#import "SearchListDataSource.h"
#import "HomeSectionHeaderView.h"
#import "SearchHotCollectionViewCell.h"
#import "HomeHeaderView.h"

static NSString *const SearchHotIdentifier = @"SearchHot";
static NSString *const H5ListCellIdentifier = @"H5List";
static NSString *const DesignerListCellIdentifier = @"DesignerList";

@interface SearchViewController ()<UISearchBarDelegate>

@property (nonatomic,strong) UISearchBar * searchBar;
@property (strong, nonatomic) YZTagList *tagList;
@property (weak, nonatomic) IBOutlet UIButton *deleteSearchListButton;
@property (weak, nonatomic) IBOutlet UILabel *searchListLabel;

@property (nonatomic, strong)CarouselScrollView *h5bannerView;
@property (nonatomic, strong)CarouselScrollView *designerbannerView;
@property (nonatomic, strong)SearchListDataSource *searchListDataSource;
@property (nonatomic, assign)NSInteger searchListCount;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigafindHairlineImageView:YES];
}

-(void)initView{
    
    [super initView];
    [self setupSearchBar];
    [self loadSearchList];
    [self initCollectionView];
}

-(void)initCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    [self initCollectionViewWithFrame:ControllerViewFrame(0, 0, ViewWidth, ViewHeigh) flowLayout:layout];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(40);
    }];
    
    [self steupCollectionView];
    self.collectionView.hidden = YES;
}

-(void)initData{
    
    [super initData];
    _searchListCount = 0;
}

-(void)setupSearchBar{
    
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0,8,ScreenWidth-100,28)]; //
    [titleView setBackgroundColor:[UIColor whiteColor]];
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.frame = CGRectMake(0,0,ScreenWidth-100,28);
    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.layer.cornerRadius = 14;
    _searchBar.layer.masksToBounds = YES;
    _searchBar.placeholder = @"搜索感兴趣的H5/设计师/热点";
    [titleView addSubview:_searchBar];
    
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    
    if (searchField) {
        
        [searchField setBackgroundColor:RGB(250, 250, 250)];
        
        searchField.layer.cornerRadius = 14.0f;
        
        searchField.layer.borderColor = [UIColor clearColor].CGColor;
        
        searchField.layer.borderWidth = 1;
        
        searchField.layer.masksToBounds = YES;
        [searchField setValue:UIColorFromRGB(0x9b9fa8) forKeyPath:@"_placeholderLabel.textColor"];
        [searchField setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    }
    //设置为titleView
    self.navigationItem.titleView = titleView;
}

-(void)initNavigationBarItems{
    
    [self setRightBarItemString:@"搜索" action:@selector(search)];
}

-(void)search{
    
    _searchListCount = 0;
    [self sendSearchKey];
}

-(void)loadingH5List{
    
    [[UserManager shareUserManager]homeH5ListWithType:H5ProductTypeNoel PageIndex:1 PageCount:3 tagList:nil searchKey:_searchBar.text];
    [UserManager shareUserManager].homeH5ListSuccess = ^ (NSArray *arr){
        
        _searchListCount = _searchListCount+arr.count;
        if (arr.count != 0) {
            NSArray* itemArray =[[H5ListStore shearH5ListStore] configurationMenuWithMenu:arr];
            Home *home = [[Home alloc]init];
            home.itemKey =Type_H5;
            home.itemArray = itemArray;
            home.itemHeader = @"H5";
            [self.dataArray addObject: home];
        }
        [self loadingDesignerList];
    };
}

-(void)loadingDesignerList{
    
    [[UserManager shareUserManager]designerlistWithPageIndex:1 PageCount:3 designerListType:DesignerListTypeHome searchKey:_searchBar.text];
    [UserManager shareUserManager].designerlistSuccess = ^(NSArray * arr){
       
         _searchListCount = _searchListCount+arr.count;
        if (arr.count != 0) {
            
            NSArray *itemArray = [[DesignerListStore shearDesignerListStore]configurationMenuWithMenu:arr];
            Home *home = [[Home alloc]init];
            home.itemKey =Type_Designer;
            home.itemArray = itemArray;
            home.itemHeader = @"设计师";
            [self.dataArray addObject: home];
        }
        
        [self loadingHotList];
    };
}

-(void)loadingHotList{
    
    [[UserManager shareUserManager]hotListWithType:ArticleTypeDefault
                                         PageIndex:1
                                         PageCount:3
                                getArticleListType: GetArticleListTypeHot
                                         searchKey:nil];
    [UserManager shareUserManager].hotlistSuccess = ^(NSArray * arr){
        
        _searchListCount = _searchListCount+arr.count;
        
        if (arr.count != 0) {
           
            NSArray* itemArray =[[H5ListStore shearH5ListStore] configurationMenuWithMenu:arr];
            Home *home = [[Home alloc]init];
            home.itemKey = Type_SearchHot;
            home.itemArray = itemArray;
            home.itemHeader = @"热点";
            [self.dataArray addObject: home];
        }
        _searchListLabel.text = [NSString stringWithFormat:@"为你找到相关结果%ld个", _searchListCount];
        _deleteSearchListButton.hidden = YES;
        [self.collectionView reloadData];
    };
}

-(void)steupCollectionView{
    
//    __weak typeof(self) weakSelf = self;
    CollectionViewCellConfigureBlock congfigureBlock = ^(id cell , id item, NSIndexPath *indexPath){

        if ([cell isKindOfClass:[DesignerListViewCollectionViewCell class]]) {
            [cell setItmeOfModel:item
        DesignerListType:DesignerListTypeHome
                           index:indexPath.row];
        } else {
            [cell setItmeOfModel:item];
        }
    };
    
    CollectionViewCellHeaderConfigureBlock cellHeaderConfigureCellBlock = ^(UICollectionReusableView *headerView, NSIndexPath *indexPath){
        
        Home *home = [_searchListDataSource itemAtIndexPath:indexPath.section];
        for (UIView *view in headerView.subviews) {
            
            if ([view isKindOfClass: [HomeSectionHeaderView class]]) {
                
                [view removeFromSuperview];
            }
        }
        HomeSectionHeaderView *infView = [[HomeSectionHeaderView alloc] init];
        infView.frame = headerView.bounds;
        [infView initSubViewsWithSection:indexPath.section];
        infView.sectionHeader = ^(NSInteger section){
            
            //                if (section == 2) {
            //
            //                    [UIManager designerListWithDesignerListType:DesignerListTypeHome];
            //
            //                }else {
            //
            //                    [self loadinH5ListWithH5Type:GetH5ListTypeProduct index:section title:home.itemHeader];
            //                }
        };
        infView.titleLbl.text = home.itemHeader;
        infView.backgroundColor = UIColor.whiteColor;
        
        [headerView addSubview:infView];
        //        }
        
    };
    self.searchListDataSource = [[SearchListDataSource alloc]initWithItems:self.dataArray cellIdentifier:SearchHotIdentifier headerIdentifier:nil
                                            cellConfigureBlock:congfigureBlock
                                  cellHeaderConfigureCellBlock:cellHeaderConfigureCellBlock
                           ];
    [self.collectionView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"H5ListCollectionViewCell"] forCellWithReuseIdentifier:H5ListCellIdentifier];
    [self.collectionView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"DesignerListViewCollectionViewCell"] forCellWithReuseIdentifier:DesignerListCellIdentifier];
    [self.collectionView registerClass:[HomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self steupCollectionViewWithDataSource:self.searchListDataSource
                             cellIdentifier:SearchHotIdentifier
                                nibName:@"SearchHotCollectionViewCell"];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return  [self sizeForItemAtIndex:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(ScreenWidth, 57);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return [self minimumInteritemSpacingForSectionAtIndex:section];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section > 2) {
        
        Home *home = [_searchListDataSource itemAtIndexPath:indexPath.section];
        H5List *h5 = home.itemArray[indexPath.row];
        [UIManager pushTemplateDetailViewControllerWithTemplateId:h5.id];
    }
    
    NSLog(@"23");
}

-(CGSize)sizeForItemAtIndex:(NSIndexPath *)indexPath{
    
    Home *home = [_searchListDataSource itemAtIndexPath:indexPath.section];
        if ([home.itemKey isEqualToString:Type_Designer]) {
            
             return CGSizeMake(ScreenWidth/3, (ScreenWidth/3-35)+5+18+5+8+16+5+32+16);
            
        } else if ([home.itemKey isEqualToString:Type_H5]){
            return CGSizeMake(ScreenWidth/3, (ScreenWidth/3-33)*1.7+32+5+5+7+9-17);
        }else {
            
             return CGSizeMake(ScreenWidth, (ScreenHeigh-65)/3);
        }
}

-(CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    CGFloat spaceX = 0;
    return spaceX;
}

-(void)loadSearchList{
    
    NSDictionary *dic = (NSDictionary *)[[Global sharedSingleton]getUserDefaultsWithKey:SEARCH_LIST];
    NSMutableArray *key = [NSMutableArray array];
    if (dic != nil) {
        
        [key addObjectsFromArray:[dic allKeys]];
        for (int i = 0; i<key.count; i++) {
            
            for (int j = 0; j<key.count-1; j++) {
                
                
                if ([dic[key[j]] integerValue] < [dic[key[j+1]] integerValue] ) {
                    
                    NSString *temp = key[j];
                    key[j] = key[j+1];
                    key[j+1] = temp;
                }
            }
        }
        //TODO
    }
    [self addkeywordsViewWithkeywords:key];
}

-(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
}

-(void)addkeywordsViewWithkeywords:(NSArray *)keywords{
    
    // 高度可以设置为0，会自动跟随标题计算
    
    __weak typeof(self) WeakSelf = self;
    _tagList = [[YZTagList alloc] initWithFrame:CGRectMake(60, 46, ScreenWidth-120, 0)];
    _tagList.backgroundColor = [UIColor whiteColor];
    _tagList.tagCornerRadius = 3;
    _tagList.borderWidth = 0;
    _tagList.tagFont = [UIFont systemFontOfSize:15] ;
    _tagList.tagBackgroundColor =  UIColorFromRGB(0xeeeeee);
    // 设置标签背景色
    _tagList.tagColor = [UIColor blackColor];
    [_tagList addSearchListTag: keywords action:@selector(searchListTag:)];
    [self.view addSubview:_tagList];
    _tagList.searchListTagBlock = ^ (NSString *tag){

        _searchListCount = 0;
        WeakSelf.searchBar.text = tag;
        [WeakSelf sendSearchKey];
        NSLog(@"%@",tag);
    };
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
     _searchListCount = 0;
    [self sendSearchKey];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ([Global stringIsNullWithString:searchBar.text]) {
        
        [self.dataArray removeAllObjects];
        self.collectionView.hidden = YES;
        _searchListLabel.text = [NSString stringWithFormat:@"搜索历史"];
        _deleteSearchListButton.hidden = NO;
        [self loadSearchList];
    }
}

-(void)sendSearchKey{
  
    [self.dataArray removeAllObjects];
    NSDictionary *dic = (NSDictionary *)[[Global sharedSingleton]getUserDefaultsWithKey:SEARCH_LIST];
    NSString *currentDate = [self getNowTimeTimestamp];
    NSMutableDictionary *mutable = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mutable setObject:currentDate forKey:_searchBar.text];
    [[Global sharedSingleton]setUserDefaultsWithKey:SEARCH_LIST andValue:mutable];
    
    NSMutableArray *key = [NSMutableArray array];
    [key addObjectsFromArray:[mutable allKeys]];
    for (int i = 0; i<key.count; i++) {
        
        for (int j = 0; j<key.count-1; j++) {
            
            
            if ([mutable[key[j]] integerValue] < [mutable[key[j+1]] integerValue] ) {
                
                NSString *temp = key[j];
                key[j] = key[j+1];
                key[j+1] = temp;
            }
        }
    }
    [self setTaglistViewNil];
    self.collectionView.hidden = NO;
    [self loadingH5List];
    [_searchBar resignFirstResponder];
}

-(void)setTaglistViewNil{
    
    [_tagList removeFromSuperview];
    _tagList = nil;
}

- (IBAction)deleteSearchList:(UIButton *)sender {
    
    [self alertOperation];
}

-(void)alertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除搜索历史不可恢复，确定要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[Global sharedSingleton]delUserDefaultsWithKey:SEARCH_LIST];
        [self setTaglistViewNil];
        [self loadSearchList];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)back{
    
    [self.searchBar resignFirstResponder];
    [super back];
}

@end
