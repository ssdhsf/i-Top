//
//  HotDetailsViewController.m
//  itop
//
//  Created by huangli on 2018/1/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "HotDetailsViewController.h"
#import "HotDetailDataSource.h"
#import "HotDetailStore.h"
#import "HotDetailsCell.h"
#import "WebViewController.h"
#import <AVFoundation/AVFoundation.h>

static NSString *const HotDetailCellIdentifier = @"HotDetail";

@interface HotDetailsViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *browseLabel;
@property (weak, nonatomic) IBOutlet UILabel *praiseLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *focusButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *showImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) UITextView *commentTV;

/*---------------h5headerview--------------------*/
@property (strong, nonatomic) IBOutlet UIView *h5HeaderView;
@property (weak, nonatomic) IBOutlet UIView *h5View;
@property (weak, nonatomic) IBOutlet UIButton *h5FocusButton;
@property (weak, nonatomic) IBOutlet UILabel *h5UserNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *h5ImageView;
@property (weak, nonatomic) IBOutlet UILabel *h5BrowseLabel;
@property (weak, nonatomic) IBOutlet UILabel *h5PraiseLabel;
@property (weak, nonatomic) IBOutlet UILabel *h5CommentLabel;
@property (strong, nonatomic)WebViewController *webVc;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIButton *shearButton;

@property (nonatomic, strong)HotDetails *hotDetail;
@property (nonatomic, strong)HotDetailDataSource *hotDetailDataSource;
@property (nonatomic, strong)NSString *parent_id;
@property (nonatomic, assign)FocusType focusType;
@property (nonatomic, assign)CollectionType collectionType;


@end

@implementation HotDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigafindHairlineImageView:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    BOOL ok;
    NSError *setCategoryError = nil;
    ok = [audioSession setCategory:AVAudioSessionCategoryPlayback
                             error:&setCategoryError];
    if (!ok) {
        NSLog(@"%s setCategoryError=%@", __PRETTY_FUNCTION__, setCategoryError);
    }
}

-(void)initData{
    
    [super initData];
    [[UserManager shareUserManager]hotDetailWithHotDetailId:_hotDetail_id PageIndex:0 PageCount:0];
    [UserManager shareUserManager].hotDetailSuccess = ^(NSDictionary *dic){
      
        _hotDetail = [[HotDetails alloc]initWithDictionary:dic error:nil];
        self.page_no = 1;
        [self refreshData];
    };
}

-(void)refreshData{
    
    [[UserManager shareUserManager]hotCommentWithHotDetailId:_hotDetail.article.id PageIndex:self.page_no PageCount:10];
    [UserManager shareUserManager].hotCommentSuccess = ^ (NSArray *arr){
        
        [self listDataWithListArray:[[HotDetailStore shearHotDetailStore]configurationMenuWithMenu:arr] page:self.page_no];
        
            [self steupTableView];
        if (_itemDetailType == HotItemDetailType) { //热点头
            [self setupHeaderView];
            [self setHeaderViewSubViewData];

        } else { //H5头
            
            [self setupH5HeaderView];
            [self setH5HeaderViewSubViewData];
        }
    };
}

-(void)initView{
    
    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ScreenHeigh-50)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-50);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _commentTV = [[UITextView alloc]init];
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(HotDetailsCell *cell , HotComments *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item];
    };
    self.hotDetailDataSource = [[HotDetailDataSource alloc]initWithItems:self.dataArray cellIdentifier:HotDetailCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.hotDetailDataSource
                        cellIdentifier:HotDetailCellIdentifier
                               nibName:@"HotDetailsCell"];
    
    self.tableView.dataSource = self.hotDetailDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"HotDetailsCell"] forCellReuseIdentifier:HotDetailCellIdentifier];
}

-(void)setupHeaderView{
    
    _showImage.frame = CGRectMake(20, CGRectGetMaxY(_iconImage.frame)+20, ScreenWidth - 40, (ScreenWidth - 40)*0.448);
    CGFloat contentHeight = [Global heightWithString:_hotDetail.article.content width:ScreenWidth - 40 fontSize:16];
    _contentLabel.frame = CGRectMake(20, CGRectGetMaxY(_showImage.frame)+30, ScreenWidth - 40, contentHeight);
    _contentLabel.font = [UIFont systemFontOfSize:16];
    _headerView.frame = CGRectMake(0 , 0, ScreenWidth, CGRectGetMaxY(_contentLabel.frame)+60+21);
    self.tableView.tableHeaderView = _headerView;
    
    _iconImage.layer.masksToBounds = YES;
    _iconImage.layer.cornerRadius = _iconImage.frame.size.width/2;
    _focusType = [_hotDetail.follow integerValue];
    _collectionType = [_hotDetail.user_article.collection integerValue];
    [self setupFocusState];
    [self setupCollectionState];
    [self setupTextViewWithKeyboardShowAnimation:NO];
}

-(void)setupH5HeaderView{
    
    _h5HeaderView.frame = CGRectMake(0 , 0, ScreenWidth, ScreenHeigh/3*2);
    self.tableView.tableHeaderView = _h5HeaderView;
     _webVc = [[WebViewController alloc]init];
    _webVc.h5Url = _hotDetail.article.url;
    _webVc.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeigh/3*2-142);
    [_h5HeaderView addSubview:_webVc.view];
    
    _h5ImageView.layer.masksToBounds = YES;
    _h5ImageView.layer.cornerRadius = _h5ImageView.frame.size.width/2;
    _focusType = [_hotDetail.follow integerValue];
    _collectionType = [_hotDetail.user_article.collection integerValue];
    [self setupH5FocusState];
    [self setupCollectionState];
    [self setupTextViewWithKeyboardShowAnimation:NO];
}

-(void)setH5HeaderViewSubViewData{
    
    _h5BrowseLabel.text = _hotDetail.article.browse_count;
    _h5PraiseLabel.text = _hotDetail.article.praise_count;
    _h5CommentLabel.text = _hotDetail.article.commend;
    _h5UserNameLabel.text = _hotDetail.author_nickname;
    [_h5ImageView sd_setImageWithURL:[NSURL URLWithString:_hotDetail.author_head_img] placeholderImage:PlaceholderImage];
}

-(void)setHeaderViewSubViewData{
    
    _titleLabel.text = _hotDetail.article.title;
    _timeLabel.text =[[Global sharedSingleton]timestampTotimeStringWithtimestamp:_hotDetail.article.create_datetime pattern:TIME_PATTERN_minute];
    _browseLabel.text = _hotDetail.article.browse_count;
    _praiseLabel.text = _hotDetail.article.praise_count;
    _commentLabel.text = _hotDetail.article.comment_count;
    _contentLabel.text = _hotDetail.article.content;
    _userNameLabel.text = _hotDetail.author_nickname;
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:_hotDetail.author_head_img] placeholderImage:PlaceholderImage];
    [_showImage sd_setImageWithURL:[NSURL URLWithString:_hotDetail.article.cover_img] placeholderImage:nil];
}


#pragma mark 键盘弹出和收起设置
-(void)setupTextViewWithKeyboardShowAnimation:(BOOL)animation{
    
    if (animation) {
        _commentTV.frame = CGRectMake(20, ScreenHeigh-64-70, ScreenWidth-120, 60);
        _commentTV.layer.cornerRadius = 5;
        
    }else {
        
        _commentTV.frame = CGRectMake(20, ScreenHeigh-40-64, ScreenWidth-127, 30);
        _commentTV.layer.cornerRadius = _commentTV.frame.size.height/2;
        [_commentTV resignFirstResponder];
    }
    
    _sendButton.frame = CGRectMake(CGRectGetMaxX(_commentTV.frame)+20, 0, 25, 40);
    _sendButton.centerY = _commentTV.centerY;
    [self.view bringSubviewToFront:_sendButton];
    _commentTV.delegate = self;
    _commentTV.layer.masksToBounds = YES;
    _commentTV.backgroundColor = UIColorFromRGB(0xf5f7f9);
    [self.view addSubview:_commentTV];
    [self popKeyboardHiddenButtonAnimation:animation];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotComments *hot = [_hotDetailDataSource itemAtIndexPath:indexPath];
    CGFloat contentHeight = [Global heightWithString:hot.content width:ScreenWidth-85 fontSize:15];
    CGFloat replyHeight = [Global heightWithString:hot.replyString width:ScreenWidth-85 fontSize:15];
    return 65+21+contentHeight+replyHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    [_commentTV becomeFirstResponder];
    HotComments *comment = [self.hotDetailDataSource itemAtIndexPath:indexPath];
    _parent_id = comment.id;
}

- (IBAction)collection:(UIButton *)sender {
    
    [[UserManager shareUserManager] collectionOnHotWithHotId:_hotDetail.article.id CollectionType:_collectionType];
    [UserManager shareUserManager]. collectionOnHotSuccess = ^(id obj){
        
        _collectionType = !_collectionType;
        if (_collectionType == CollectionTypeCollection) {
            
            [[Global sharedSingleton]showToastInCenter:self.view withMessage:@"收藏成功"];
        } else {
            
            [[Global sharedSingleton]showToastInCenter:self.view withMessage:@"已取消收藏"];
        }
        [self setupCollectionState];
    };
}

- (IBAction)focus:(UIButton *)sender {
    
    if (_focusType == FocusTypeTypeCancelFocus) {
        
        [self focus];
    } else {
        
        [self alertOperation];
    }
    
}

#pragma mark 改变热点FocusButton状态
-(void)setupFocusState{
    
    if (_focusType == FocusTypeFocus) {
    
        _focusButton.frame = CGRectMake(ScreenWidth-75, CGRectGetMinY(_focusButton.frame), 55, 20);
        [_focusButton setTitle:FOCUSSTATETITLE_FOCUS forState:UIControlStateNormal];
    }else {
        
        _focusButton.frame = CGRectMake(ScreenWidth-70, CGRectGetMinY(_focusButton.frame), 50, 20);
        [_focusButton setTitle:FOCUSSTATETITLE_NOFOCUS forState:UIControlStateNormal];
    }
    _focusButton.centerY = _userNameLabel.centerY;
    [_focusButton.layer insertSublayer:[UIColor setGradualChangingColor:_focusButton fromColor:@"FFA5EC" toColor:@"DEA2FF"] atIndex:0];
    _focusButton.layer.masksToBounds = YES;
    _focusButton.layer.cornerRadius = 2;
}


#pragma mark 改变H5FocusButton状态
-(void)setupH5FocusState{
    
    if (_focusType == FocusTypeFocus) {
        
        _h5FocusButton.frame = CGRectMake(ScreenWidth-75, _h5HeaderView.height-90, 55, 20);
        [_h5FocusButton setTitle:FOCUSSTATETITLE_FOCUS forState:UIControlStateNormal];
        
    }else {
        
        _h5FocusButton.frame = CGRectMake(ScreenWidth-70, _h5HeaderView.height-90, 50, 20);
        [_h5FocusButton setTitle:FOCUSSTATETITLE_NOFOCUS forState:UIControlStateNormal];
    }
//    _h5FocusButton.centerY = _h5ImageView.centerY;
    [_h5FocusButton.layer insertSublayer:[UIColor setGradualChangingColor:_h5FocusButton fromColor:@"FFA5EC" toColor:@"DEA2FF"] atIndex:0];
    _h5FocusButton.layer.masksToBounds = YES;
    _h5FocusButton.layer.cornerRadius = 2;
}

#pragma mark 改变CollectionButton状态
-(void)setupCollectionState{
    
    if (_collectionType == CollectionTypeCollection) {
        
        [_collectionButton setImage:[UIImage imageNamed:@"hot_icon_havecollection" ] forState:UIControlStateNormal];

    }else {
        
        [_collectionButton setImage:[UIImage imageNamed:@"hot_icon_collect" ] forState:UIControlStateNormal];
    }
}

#pragma mark 键盘弹出
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    _parent_id = nil;
    [self setupTextViewWithKeyboardShowAnimation:YES];
    return YES;
}

//#pragma mark 键盘关闭
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
   
    [self setupTextViewWithKeyboardShowAnimation:NO];
    return YES;
}

- (IBAction)sendComment:(UIButton *)sender {

    [self setupTextViewWithKeyboardShowAnimation:NO];
    [[UserManager shareUserManager] commentHotWithHotArticleId:_hotDetail.article.id parentId:_parent_id content:_commentTV.text];
    [UserManager shareUserManager].commentHotSuccess = ^ (id obj){
        
        _commentTV.text = nil;
        [[Global sharedSingleton]showToastInCenter:self.view withMessage:@"评论成功"];
        [self refreshData];
    };
}

-(void)popKeyboardHiddenButtonAnimation:(BOOL)animation{
    
    _shearButton.hidden = animation;
    _collectionButton.hidden = animation;
    _sendButton.hidden = !animation;
}

- (IBAction)shear:(UIButton *)sender {
    
    NSLog(@"分享");
}


-(void)alertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否取消关注该用户" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self focus];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)focus{
    
    [[UserManager shareUserManager]focusOnUserWithUserId:_hotDetail.article.user_id focusType:_focusType];
    [UserManager shareUserManager].focusOnUserSuccess = ^ (id obj){
        
        _focusType = !_focusType;
        if (_focusType == FocusTypeFocus) {
            
            [[Global sharedSingleton]showToastInCenter:self.view withMessage:FOCUSSTATETITLE_SUCCESSFOCUS];
        } else {
            
            [[Global sharedSingleton]showToastInCenter:self.view withMessage:FOCUSSTATETITLE_CANCELFOCUS];
        }
        if (_itemDetailType == H5ItemDetailType) {
            
            [self setupH5FocusState];
        } else {
            [self setupFocusState];
        }
    };
}




@end
