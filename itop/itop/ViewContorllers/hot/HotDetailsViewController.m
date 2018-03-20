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

/*---------------Hotheaderview--------------------*/
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
@property (strong, nonatomic) UIView *commentTVBgView;

@property (weak, nonatomic) IBOutlet UIImageView *browseIcon;
@property (weak, nonatomic) IBOutlet UIImageView *praiseIcon;
@property (weak, nonatomic) IBOutlet UIImageView *commentIcon;

/*---------------h5headerview--------------------*/
@property (strong, nonatomic) IBOutlet UIView *h5HeaderView;
@property (weak, nonatomic) IBOutlet UIView *h5View;
@property (weak, nonatomic) IBOutlet UIButton *h5FocusButton;
@property (weak, nonatomic) IBOutlet UILabel *h5UserNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *h5ImageView;
@property (weak, nonatomic) IBOutlet UILabel *h5BrowseLabel;
@property (weak, nonatomic) IBOutlet UILabel *h5PraiseLabel;
@property (weak, nonatomic) IBOutlet UILabel *h5CommentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *h5BrowseIcon;
@property (weak, nonatomic) IBOutlet UIImageView *h5PraiseIcon;
@property (weak, nonatomic) IBOutlet UIImageView *h5CommentIcon;

/*---------------publicview--------------------*/
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIButton *shearButton;
@property (strong, nonatomic)WebViewController *webVc;
@property (nonatomic, strong)HotDetails *hotDetail;
@property (nonatomic, strong)HotDetailDataSource *hotDetailDataSource;
@property (nonatomic, strong)NSString *parent_id;
@property (nonatomic, assign)FocusType focusType;
@property (nonatomic, assign)CollectionType collectionType;

@end

@implementation HotDetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self registeredkeyBoardNSNotificationCenter];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigafindHairlineImageView:YES];
    [IQKeyboardManager sharedManager].enable = NO;
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

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [[ShearViewManager sharedShearViewManager]setupShearView];
    [ShearViewManager sharedShearViewManager].selectShearItme = ^(NSInteger tag){

    };
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
            [self loadingHeardView];
    };
}

-(void)loadingHeardView{
    
    switch (_itemDetailType) {
       
        case HotItemDetailType:
            
            [self setupHeaderView];
            [self setHeaderViewSubViewData];
            break;
            
        case H5ItemDetailType:
            
            [self setupH5HeaderView];
            [self setH5HeaderViewSubViewData];
            break;
        default:
            break;
    }
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
    [self setupkeyBoardDidShowView];
}

-(void)setupkeyBoardDidShowView{
    
    _commentTVBgView = [[UIView alloc]init];
    _commentTV = [[UITextView alloc]init];
        _commentTVBgView.backgroundColor = [UIColor whiteColor];
    _commentTV.frame = CGRectMake(20, ScreenHeigh-40-64, ScreenWidth-127, 30);
    _commentTV.layer.cornerRadius = 5;
    [self.view addSubview:_commentTV];
    _commentTV.delegate = self;
    _commentTV.layer.masksToBounds = YES;
    _commentTV.backgroundColor = UIColorFromRGB(0xf5f7f9);
    _sendButton.hidden = YES;
    [self.view addSubview:_commentTVBgView];
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
    
    NSInteger goodLabelTextWidth = [[Global sharedSingleton]widthForString:_hotDetail.article.praise_count fontSize:13 andHeight:15];
    NSInteger browseLabelTextWidth = [[Global sharedSingleton]widthForString:_hotDetail.article.browse_count fontSize:13 andHeight:15];
    NSInteger commentsLabelTextWidth = [[Global sharedSingleton]widthForString:_hotDetail.article.comment_count fontSize:13 andHeight:15];
    
    self.browseIcon.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame), 0, 14, 9);
    self.browseLabel.frame = CGRectMake(CGRectGetMaxX(self.browseIcon.frame)+10, 0, browseLabelTextWidth+5, 15);
    
    self.praiseIcon.frame = CGRectMake(CGRectGetMaxX(self.browseLabel.frame)+10, 0, 10, 9);
    self.praiseLabel.frame = CGRectMake(CGRectGetMaxX(self.praiseIcon.frame)+10, 0, goodLabelTextWidth+5, 15);
    
    self.commentIcon.frame = CGRectMake(CGRectGetMaxX(self.praiseLabel.frame)+10, 0, 10, 9);
    self.commentLabel.frame = CGRectMake(CGRectGetMaxX(self.commentIcon.frame)+10,0, commentsLabelTextWidth+5, 15);
    
    self.browseIcon.centerY = self.timeLabel.centerY;
    self.browseLabel.centerY = self.browseIcon.centerY;
    self.praiseIcon.centerY = self.browseIcon.centerY;
    self.praiseLabel.centerY = self.browseIcon.centerY;
    self.commentIcon.centerY = self.browseIcon.centerY;
    self.commentLabel.centerY = self.browseIcon.centerY;
    
    _showImage.frame = CGRectMake(20, CGRectGetMaxY(_iconImage.frame)+20, ScreenWidth - 40, (ScreenWidth - 40)*0.448);

    NSDictionary *optoins = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                              NSFontAttributeName:self.contentLabel.font};
    
    NSString *htmlString = _hotDetail.article.content;
    NSData *data = [htmlString dataUsingEncoding:NSUnicodeStringEncoding];
    NSAttributedString *attributeString = [[NSAttributedString alloc] initWithData:data
                                                                           options:optoins
                                                                documentAttributes:nil
                                                    error:nil];

    self.contentLabel.attributedText = attributeString;
    CGFloat contentHeight = [Global heightWithString: self.contentLabel.text width:ScreenWidth - 40 fontSize:16];

    _contentLabel.frame = CGRectMake(20, CGRectGetMaxY(_showImage.frame)+30, ScreenWidth - 40, contentHeight);
    _headerView.frame = CGRectMake(0 , 0, ScreenWidth, CGRectGetMaxY(_showImage.frame)+contentHeight+44+21);
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
    
    self.title = _hotDetail.article.title;
    _h5HeaderView.frame = CGRectMake(0 , 0, ScreenWidth, ScreenHeigh/3*2);
    self.tableView.tableHeaderView = _h5HeaderView;
    _webVc = [[WebViewController alloc]init];
    _webVc.h5Url = _hotDetail.article.url;
    _webVc.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeigh/3*2-142);
    [_h5HeaderView addSubview:_webVc.view];
    
    NSInteger goodLabelTextWidth = [[Global sharedSingleton]widthForString:_hotDetail.article.praise_count fontSize:13 andHeight:15];
    NSInteger browseLabelTextWidth = [[Global sharedSingleton]widthForString:_hotDetail.article.browse_count fontSize:13 andHeight:15];
    NSInteger commentsLabelTextWidth = [[Global sharedSingleton]widthForString:_hotDetail.article.comment_count fontSize:13 andHeight:15];
    NSInteger oringinY = CGRectGetMaxY(self.h5HeaderView.frame)-122;
    self.h5BrowseIcon.frame = CGRectMake(30, oringinY, 14, 9);
    self.h5BrowseLabel.frame = CGRectMake(CGRectGetMaxX(self.h5BrowseIcon.frame)+10, 0, browseLabelTextWidth+5, 15);
    
    self.h5PraiseIcon.frame = CGRectMake(CGRectGetMaxX(self.h5BrowseLabel.frame)+10, 0, 10, 9);
    self.h5PraiseLabel.frame = CGRectMake(CGRectGetMaxX(self.h5PraiseIcon.frame)+10, 0, goodLabelTextWidth+5, 15);
    
    self.h5CommentIcon.frame = CGRectMake(CGRectGetMaxX(self.h5PraiseLabel.frame)+10, 0, 10, 9);
    self.h5CommentLabel.frame = CGRectMake(CGRectGetMaxX(self.h5CommentIcon.frame)+10,0, commentsLabelTextWidth+5, 15);
    self.h5BrowseLabel.centerY = self.h5BrowseIcon.centerY;
    self.h5PraiseIcon.centerY = self.h5BrowseIcon.centerY;
    self.h5PraiseLabel.centerY = self.h5BrowseIcon.centerY;
    self.h5CommentIcon.centerY = self.h5BrowseIcon.centerY;
    self.h5CommentLabel.centerY = self.h5BrowseIcon.centerY;

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
    _timeLabel.text =[[Global sharedSingleton]timeFormatTotimeStringFormatWithtime:_hotDetail.article.create_datetime willPattern:TIME_PATTERN_second didPattern:TIME_PATTERN_day];
    _browseLabel.text = _hotDetail.article.browse_count;
    _praiseLabel.text = _hotDetail.article.praise_count;
    _commentLabel.text = _hotDetail.article.comment_count;
//    _contentLabel.text = _hotDetail.article.content;
    _userNameLabel.text = _hotDetail.author_nickname;
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:_hotDetail.author_head_img] placeholderImage:PlaceholderImage];
    [_showImage sd_setImageWithURL:[NSURL URLWithString:_hotDetail.article.cover_img] placeholderImage:nil];
    
    UIFont *font = [UIFont systemFontOfSize:16];
    self.contentLabel.font = font;
    NSDictionary *optoins = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                            NSFontAttributeName:font};
    
    NSString *htmlString = _hotDetail.article.content;
    NSData *data = [htmlString dataUsingEncoding:NSUnicodeStringEncoding];
    NSAttributedString *attributeString = [[NSAttributedString alloc] initWithData:data
                                                                         options:optoins
                                         documentAttributes:nil
                                                    error:nil];
    self.contentLabel.attributedText = attributeString;
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

//#pragma mark 键盘弹出
//-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//    
//    _parent_id = nil;
////    [self setupTextViewWithKeyboardShowAnimation:YES];
//    return YES;
//}
//
////#pragma mark 键盘关闭
//-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
//   
//    [self setupTextViewWithKeyboardShowAnimation:NO];
//    return YES;
//}

- (IBAction)sendComment:(UIButton *)sender {

    [self setupTextViewWithKeyboardShowAnimation:NO];
    [[UserManager shareUserManager] commentHotWithHotArticleId:_hotDetail.article.id parentId:_parent_id content:_commentTV.text];
    [UserManager shareUserManager].commentSuccess = ^ (id obj){
        
        _commentTV.text = nil;
        [[Global sharedSingleton]showToastInCenter:self.view withMessage:@"评论成功"];
        [self refreshData];
    };
}

- (IBAction)shear:(UIButton *)sender {
    
    ShearInfo * shear = [[ShearInfo alloc]init];
    shear.shear_title = _hotDetail.article.title;
    shear.shear_discrimination = _hotDetail.article.title;
    shear.shear_thume_image = _hotDetail.article.cover_img;
    shear.shear_webLink = _hotDetail.article.url;
    [[ShearViewManager sharedShearViewManager]addShearViewToView:self.view shearType:UMS_SHARE_TYPE_WEB_LINK completion:^(NSInteger tag) {
        
        [[ShearViewManager sharedShearViewManager] shareWebPageToPlatformType:[[ShearViewManager sharedShearViewManager].shearType[tag] integerValue] parameter:shear];
        
    } ];
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

#pragma mark 键盘弹出
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

-(void)shutDownTableViewCellEventWithAnimation:(BOOL)animation{
    
    self.tableView.scrollEnabled = animation;
    self.tableView.allowsSelection = animation;
}

#pragma mark 键盘弹出和收起设置
-(void)setupTextViewWithKeyboardShowAnimation:(BOOL)animation{
    
    if (animation) {
        _commentTV.frame = CGRectMake(20, 10, ScreenWidth-120, 60);
        _sendButton.frame = CGRectMake(CGRectGetMaxX(_commentTV.frame)+((ScreenWidth - CGRectGetMaxX(_commentTV.frame))/2-20), 0, 25, 40);
        _sendButton.centerY = _commentTV.centerY;
        _commentTV.layer.cornerRadius = 5;
        [_commentTVBgView addSubview:_commentTV];
        [_commentTVBgView addSubview:_sendButton];
        
    }else {
        
        _commentTV.frame = CGRectMake(20, ScreenHeigh-40-64, ScreenWidth-127, 30);
        _commentTV.layer.cornerRadius = _commentTV.frame.size.height/2;
        [_commentTV resignFirstResponder];
        [self.view addSubview:_commentTV];
    }
    
    _sendButton.hidden = !animation;
    _commentTVBgView.hidden = !animation;
}


@end
