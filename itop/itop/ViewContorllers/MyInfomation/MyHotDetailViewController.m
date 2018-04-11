//
//  MyHotDetailViewController.m
//  itop
//
//  Created by huangli on 2018/4/10.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MyHotDetailViewController.h"
#import "HotDetailDataSource.h"
#import "HotDetailStore.h"
#import "HotDetailsCell.h"
#import "WebViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ReleaseHotViewController.h"

static NSString *const HotDetailCellIdentifier = @"HotDetail";

@interface MyHotDetailViewController ()<UITextViewDelegate>

/*---------------Hotheaderview--------------------*/
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *browseLabel;
@property (weak, nonatomic) IBOutlet UILabel *praiseLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *showImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) UITextView *commentTV;
@property (strong, nonatomic) UIView *commentTVBgView;

@property (weak, nonatomic) IBOutlet UIImageView *browseIcon;
@property (weak, nonatomic) IBOutlet UIImageView *praiseIcon;
@property (weak, nonatomic) IBOutlet UIImageView *commentIcon;
@property (weak, nonatomic) IBOutlet UILabel *hotCheckStateLabel;

/*---------------h5headerview--------------------*/
@property (strong, nonatomic) IBOutlet UIView *h5HeaderView;
@property (weak, nonatomic) IBOutlet UIView *h5View;

@property (weak, nonatomic) IBOutlet UILabel *h5UserNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *h5ImageView;
@property (weak, nonatomic) IBOutlet UILabel *h5BrowseLabel;
@property (weak, nonatomic) IBOutlet UILabel *h5PraiseLabel;
@property (weak, nonatomic) IBOutlet UILabel *h5CommentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *h5BrowseIcon;
@property (weak, nonatomic) IBOutlet UIImageView *h5PraiseIcon;
@property (weak, nonatomic) IBOutlet UIImageView *h5CommentIcon;
@property (weak, nonatomic) IBOutlet UILabel *h5CheckStateLabel;

/*---------------publicview--------------------*/
@property (weak, nonatomic) IBOutlet UIButton *shelvesButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic)WebViewController *webVc;
@property (nonatomic, strong)HotDetails *hotDetail;
@property (nonatomic, strong)HotDetailDataSource *hotDetailDataSource;
@property (nonatomic, strong)NSString *parent_id;

@end

@implementation MyHotDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registeredkeyBoardNSNotificationCenter];
    // Do any additional setup after loading the view from its nib.
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

-(void)initData{
    
    [super initData];
    [[UserManager shareUserManager]hotDetailWithHotDetailId:_hotDetail_id PageIndex:0 PageCount:0];
    [UserManager shareUserManager].hotDetailSuccess = ^(NSDictionary *dic){
        
        _hotDetail = [[HotDetails alloc]initWithDictionary:dic error:nil];
        self.page_no = 1;
        
        if (_checkStatusType == CheckStatusTypeOK) {
            
             [self refreshData];
            
        } else {
            [self steupTableView];
            [self loadingHeardView];

        }
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
        make.bottom.mas_equalTo(_checkStatusType == CheckStatusTypeOK || CheckStatusTypeUnPass ? -51 : 0);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (_checkStatusType == CheckStatusTypeUnPass) {
        
        [_shelvesButton setImage:[UIImage imageNamed:@"zuo_icon_delete"] forState:UIControlStateNormal];
        [_shelvesButton setTitle:@"删除" forState:UIControlStateNormal];
        _shelvesButton.tag = 2;
    }
    [self setupkeyBoardDidShowView];
}

-(void)setupkeyBoardDidShowView{
    
    _commentTVBgView = [[UIView alloc]init];
    _commentTV = [[UITextView alloc]init];
    _commentTVBgView.backgroundColor = [UIColor whiteColor];
    _commentTV.layer.cornerRadius = 5;
    _commentTV.delegate = self;
    _commentTV.layer.masksToBounds = YES;
    _commentTV.backgroundColor = UIColorFromRGB(0xf5f7f9);
    _commentTV.frame = CGRectMake(20, 10, ScreenWidth-120, 60);
    _sendButton.frame = CGRectMake(CGRectGetMaxX(_commentTV.frame)+((ScreenWidth - CGRectGetMaxX(_commentTV.frame))/2-20), 0, 25, 40);
    _sendButton.centerY = _commentTV.centerY;
    [_commentTVBgView addSubview:_commentTV];
    [_commentTVBgView addSubview:_sendButton];
    [self.view addSubview:_commentTVBgView];
    
    [self setupTextViewWithKeyboardShowAnimation:NO];
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

-(void)setupH5HeaderView{
    
    self.title = _hotDetail.article.title;
    _h5HeaderView.frame = CGRectMake(0 , 0, ScreenWidth, ScreenHeigh/3*2);
    self.tableView.tableHeaderView = _h5HeaderView;
    _webVc = [[WebViewController alloc]init];
//    _webVc.h5Url = _hotDetail.article.url;
    _webVc.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeigh/3*2-142);
//    [_h5HeaderView addSubview:_webVc.view];
    
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
    self.h5CheckStateLabel.frame = CGRectMake(ScreenWidth-20-42, 0, 42, 15);
    
    self.h5BrowseLabel.centerY = self.h5BrowseIcon.centerY;
    self.h5PraiseIcon.centerY = self.h5BrowseIcon.centerY;
    self.h5PraiseLabel.centerY = self.h5BrowseIcon.centerY;
    self.h5CommentIcon.centerY = self.h5BrowseIcon.centerY;
    self.h5CommentLabel.centerY = self.h5BrowseIcon.centerY;
    self.h5CheckStateLabel.centerY = self.h5BrowseIcon.centerY;
    
    _h5ImageView.layer.masksToBounds = YES;
    _h5ImageView.layer.cornerRadius = _h5ImageView.frame.size.width/2;
    
    self.h5CheckStateLabel.layer.masksToBounds = YES;
    self.h5CheckStateLabel.layer.cornerRadius = 3;
    [self setupTextViewWithKeyboardShowAnimation:NO];
}

-(void)setH5HeaderViewSubViewData{
    
    _h5BrowseLabel.text = _hotDetail.article.browse_count;
    _h5PraiseLabel.text = _hotDetail.article.praise_count;
    _h5CommentLabel.text = _hotDetail.article.commend;
    _h5UserNameLabel.text = _hotDetail.author_nickname;
    [_h5ImageView sd_setImageWithURL:[NSURL URLWithString:_hotDetail.author_head_img] placeholderImage:PlaceholderImage];
    if ([_hotDetail.article.check_status integerValue] == CheckStatusTypeUnPass) {
        
        //        self.hotCheckStateLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.hotTitleLabel.frame)+9, 65,16);
        self.h5CheckStateLabel.backgroundColor = UIColorFromRGB(0xffcde3);
        
    } else {
        
        //        self.hotCheckStateLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.hotTitleLabel.frame)+9, 45,16);
        self.h5CheckStateLabel.backgroundColor = UIColorFromRGB(0xcbedfb);
    }
    switch ([_hotDetail.article.check_status integerValue]) {
        case CheckStatusTypeNoel:
        case CheckStatusTypeOnCheck:
            self.h5CheckStateLabel.text = @"审核中";
            break;
        case CheckStatusTypeOK:
            self.h5CheckStateLabel.text = @"已通过";
            break;
        case CheckStatusTypeUnPass:
            self.h5CheckStateLabel.text = @"未通过";
            break;
        default:
            break;
    }
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
    self.hotCheckStateLabel.frame = CGRectMake(ScreenWidth-20-42, 0, 42, 15);
    
    self.browseIcon.centerY = self.timeLabel.centerY;
    self.browseLabel.centerY = self.browseIcon.centerY;
    self.praiseIcon.centerY = self.browseIcon.centerY;
    self.praiseLabel.centerY = self.browseIcon.centerY;
    self.commentIcon.centerY = self.browseIcon.centerY;
    self.commentLabel.centerY = self.browseIcon.centerY;
    self.hotCheckStateLabel.centerY = self.browseIcon.centerY;
    
    _showImage.frame = CGRectMake(20, CGRectGetMaxY(_iconImage.frame)+20, ScreenWidth - 40, (ScreenWidth - 40)*0.448);
    
    
    self.hotCheckStateLabel.layer.masksToBounds = YES;
    self.hotCheckStateLabel.layer.cornerRadius = 3;
    
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
    [self setupTextViewWithKeyboardShowAnimation:NO];
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
    if ([_hotDetail.article.check_status integerValue] == CheckStatusTypeUnPass) {
        
//        self.hotCheckStateLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.hotTitleLabel.frame)+9, 65,16);
        self.hotCheckStateLabel.backgroundColor = UIColorFromRGB(0xffcde3);
        
    } else {
        
//        self.hotCheckStateLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.hotTitleLabel.frame)+9, 45,16);
        self.hotCheckStateLabel.backgroundColor = UIColorFromRGB(0xcbedfb);
    }
    switch ([_hotDetail.article.check_status integerValue]) {
        case CheckStatusTypeNoel:
        case CheckStatusTypeOnCheck:
            self.hotCheckStateLabel.text = @"审核中";
            
            break;
        case CheckStatusTypeOK:
            self.hotCheckStateLabel.text = @"已通过";
            break;
        case CheckStatusTypeUnPass:
            self.hotCheckStateLabel.text = @"未通过";
            break;
        default:
            break;
    }
}

#pragma mark 键盘弹出和收起设置
-(void)setupTextViewWithKeyboardShowAnimation:(BOOL)animation{

    _commentTV.hidden = !animation;
    _sendButton.hidden = !animation;
    _commentTVBgView.hidden = !animation;
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

- (IBAction)sendComment:(UIButton *)sender {
    
    [self setupTextViewWithKeyboardShowAnimation:NO];
    [[UserManager shareUserManager] commentHotWithHotArticleId:_hotDetail.article.id parentId:_parent_id content:_commentTV.text];
    [UserManager shareUserManager].commentSuccess = ^ (id obj){
        
        _commentTV.text = nil;
        [[Global sharedSingleton]showToastInCenter:self.view withMessage:@"评论成功"];
        [self refreshData];
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

-(void)shutDownTableViewCellEventWithAnimation:(BOOL)animation{
    
    self.tableView.scrollEnabled = animation;
    self.tableView.allowsSelection = animation;
}

#pragma mark 键盘将要收起
- (void)keyBoardWillHide:(NSNotification *)notification{
    
    [self setupTextViewWithKeyboardShowAnimation:NO];
}

#pragma mark 键盘已经收起
- (void)keyBoardDidHide:(NSNotification *)notification{
    
    [self shutDownTableViewCellEventWithAnimation:YES];
}

- (IBAction)edit:(UIButton *)sender {
    
    ReleaseHotViewController *vc = [[ReleaseHotViewController alloc]init];
    vc.hotDetail = _hotDetail;
    vc.itemDetailType = _itemDetailType;
    vc.releaseHotType = ReleaseHotTypeUpdata;
    [UIManager pushVC:vc];
}

- (IBAction)soldOut:(UIButton *)sender {
   
    
    if (sender.tag == 1) {
        
        [[UserManager shareUserManager] soldOutMyHotWithHotId:_hotDetail.article.id isShow:@0];

    } else {
        
        [[UserManager shareUserManager] soldOutMyHotWithHotId:_hotDetail.article.id isShow:@0];
    }
    
    [UserManager shareUserManager].hotStareSuccess = ^ (id obj){
        
        [UIManager sharedUIManager].updateHotBackOffBolck (@(_itemDetailType));
        [self back];
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
