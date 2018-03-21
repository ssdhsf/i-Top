//
//  CommentListViewController.m
//  itop
//
//  Created by huangli on 2018/3/14.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CommentListViewController.h"
//#import "HotDetailsViewController.h"
#import "LMJDropdownMenu.h"
#import "CommentListDataSource.h"
#import "MyWorksStore.h"
#import "HotDetailStore.h"
#import "HotDetailsCell.h"

static NSString *const CommentListCellIdentifier = @"CommentList";

@interface CommentListViewController ()<LMJDropdownMenuDelegate,UITextViewDelegate>

@property (strong, nonatomic)  CommentListDataSource *commentListDataSource;
@property(nonatomic, strong)NSArray *myProductArray; //我的作品
@property(nonatomic, strong)H5List *currentProduct; //当前的作品
@property(nonatomic, strong)NSArray *dropdownItme; //下拉分类
@property (weak, nonatomic) IBOutlet LMJDropdownMenu *dropdownMenu;

@property (strong, nonatomic) UITextView *commentTV;
@property (strong, nonatomic) UIView *commentTVBgView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (nonatomic, strong)NSString *parent_id;

@end

@implementation CommentListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self registeredkeyBoardNSNotificationCenter];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
    [IQKeyboardManager sharedManager].enable = NO;
}

-(void)initView{
    
    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ScreenHeigh-40)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(128);
        make.bottom.mas_equalTo(-40);
    }];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupkeyBoardDidShowView];
}

-(void)setupkeyBoardDidShowView{
    
    _commentTVBgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeigh-40-64, ScreenWidth, 40)];
    _commentTV = [[UITextView alloc]init];
    _commentTVBgView.backgroundColor = [UIColor whiteColor];
    _commentTV.placeholder = @"我来说两句";
//    _commentTV.frame = CGRectMake(20, 5, ScreenWidth-127, 30);
//    _sendButton.frame = CGRectMake(CGRectGetMaxX(_commentTV.frame)+((ScreenWidth - CGRectGetMaxX(_commentTV.frame))/2-20), 0, 25, 40);
//    _commentTV.layer.cornerRadius = _commentTV;
    [_commentTVBgView addSubview:_commentTV];
    [_commentTVBgView addSubview:_sendButton];
    _commentTV.delegate = self;
    _commentTV.layer.masksToBounds = YES;
    _commentTV.backgroundColor = UIColorFromRGB(0xf5f7f9);
    _commentTV.layer.cornerRadius = _commentTV.frame.size.height/2;
//    _sendButton.hidden = NO;
    [self.view addSubview:_commentTVBgView];
    [self setupTextViewWithKeyboardShowAnimation:NO];
}

-(void)initNavigationBarItems{

    self.title = @"评论";
}

-(void)initData{
    
    [super initData];
    
    [[UserManager shareUserManager]myProductListWithProductType:100  checkStatusType:CheckStatusTypeNoel isShow:1  PageIndex:1 PageCount:10];
    [UserManager shareUserManager].myProductListSuccess = ^(id obj){
      
        NSArray * array = (NSArray *)obj;
        if (array.count == 0) {
            
            self.noDataType = NoDataTypeProduct;
            self.originY = 150;
            [self setHasData:NO];
        }
        _myProductArray = [[MyWorksStore shearMyWorksStore]configurationMenuWithMenu:array];
        _dropdownItme = [[MyWorksStore shearMyWorksStore]commentsListDropdownMenuConfigurationMenuWithMenu:_myProductArray];
        [self steupDropdownMenu];
        self.page_no = 1;
        if (_myProductArray.count != 0) {
            _currentProduct = _myProductArray[0];
            [_dropdownMenu.mainBtn setTitle:_currentProduct.title forState:UIControlStateNormal];
            [self refreshData];
        }
        
        NSLog(@"%@",obj);
    };
}

-(void)refreshData{
  
    [self refreshProductCommentWithProductId:_currentProduct.id];
}

-(void)refreshProductCommentWithProductId:(NSString *)product_id{
    
    [[UserManager shareUserManager]commentListWithProductId:product_id PageIndex:self.page_no PageCount:100];

    [UserManager shareUserManager].commentListSuccess = ^ (NSArray *obj){
        
        if (obj.count == 0) {
            
            self.noDataType = NoDataTypeDefult;
            self.originY = 150;
        }
        [self listDataWithListArray:[[HotDetailStore shearHotDetailStore]configurationMenuWithMenu:obj] page:self.page_no];
        
        [self steupTableView];
    };
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(HotDetailsCell *cell , HotComments *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item];
    };
    self.commentListDataSource = [[CommentListDataSource alloc]initWithItems:self.dataArray cellIdentifier:CommentListCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.commentListDataSource
                        cellIdentifier:CommentListCellIdentifier
                               nibName:@"HotDetailsCell"];
    
    self.tableView.dataSource = self.commentListDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"HotDetailsCell"] forCellReuseIdentifier:CommentListCellIdentifier];
}

-(void)steupDropdownMenu{
    
    [_dropdownMenu setMenuTitles:self.dropdownItme rowHeight:44];
    _dropdownMenu.delegate = self;
}

- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
   
    H5List *product = _myProductArray[number];
    [self refreshProductCommentWithProductId:product.id];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotComments *hot = [_commentListDataSource itemAtIndexPath:indexPath];
    CGFloat contentHeight = [Global heightWithString:hot.content width:ScreenWidth-85 fontSize:15];
    CGFloat replyHeight = [Global heightWithString:hot.replyString width:ScreenWidth-85 fontSize:15];
    return 65+21+contentHeight+replyHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    [_commentTV becomeFirstResponder];
    HotComments *comment = [self.commentListDataSource itemAtIndexPath:indexPath];
    _parent_id = comment.id;
}

- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu{
    
    [self shutDownTableViewCellEventWithAnimation:NO];
}

- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu{
    
    [self shutDownTableViewCellEventWithAnimation:YES];
}

- (IBAction)sendComment:(UIButton *)sender {
    
    [self setupTextViewWithKeyboardShowAnimation:NO];
    [[UserManager shareUserManager] commentProductWithHotProductId:_currentProduct.id parentId:_parent_id content:_commentTV.text];
    [UserManager shareUserManager].commentSuccess = ^ (id obj){
        
        _commentTV.text = nil;
        [[Global sharedSingleton]showToastInCenter:self.view withMessage:@"评论成功"];
        [self refreshData];
    };
}

#pragma mark 键盘已经弹出
- (void)keyBoardDidShow:(NSNotification *)notification{
    
    //获取通知对象
    NSDictionary *userInfo = [notification userInfo];
    //获取键盘对象
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //获取键盘frame
    CGRect keyboardRect = [value CGRectValue];
    //获取键盘高度
    int height = keyboardRect.size.height;
    _commentTVBgView.frame = CGRectMake(0, ScreenHeigh-height-64-80, ScreenWidth, 80);
    [self setupTextViewWithKeyboardShowAnimation:YES];
    [self shutDownTableViewCellEventWithAnimation:NO];
}

#pragma mark 键盘将要收起
- (void)keyBoardWillHide:(NSNotification *)notification{
    
    [self setupTextViewWithKeyboardShowAnimation:NO];
}

#pragma mark 键盘已经收起
- (void)keyBoardDidHide:(NSNotification *)notification{
    
    [self shutDownTableViewCellEventWithAnimation:YES];
    
}

-(void)setupTextViewWithKeyboardShowAnimation:(BOOL)animation{
    
    if (animation) {
        
        _commentTV.frame = CGRectMake(20, 10, ScreenWidth-100, 60);
        _sendButton.frame = CGRectMake(CGRectGetMaxX(_commentTV.frame)+((ScreenWidth - CGRectGetMaxX(_commentTV.frame))/2-20), 0, 25, 40);
        _sendButton.centerY = _commentTV.centerY;
        _commentTV.layer.cornerRadius = 5;
        
    }else {
        
        _commentTVBgView.frame =  CGRectMake(0, ScreenHeigh-40-64, ScreenWidth, 40);
        _commentTV.frame = CGRectMake(20, 5, ScreenWidth-100, 30);
        _sendButton.frame = CGRectMake(CGRectGetMaxX(_commentTV.frame)+((ScreenWidth - CGRectGetMaxX(_commentTV.frame))/2-20), 0, 25, 40);
        _commentTV.layer.cornerRadius = _commentTV.frame.size.height/2;
        [_commentTV resignFirstResponder];
    }
}

-(void)shutDownTableViewCellEventWithAnimation:(BOOL)animation{
    
    self.tableView.scrollEnabled = animation;
    self.tableView.allowsSelection = animation;
}


@end
