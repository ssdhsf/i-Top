//
//  DirectMessagesViewController.m
//  itop
//
//  Created by huangli on 2018/3/28.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DirectMessagesViewController.h"
#import "DirectMessagesStore.h"
#import "DirectMessagesDataSource.h"
#import "DirectMessagesTableViewCell.h"

@interface DirectMessagesViewController ()<UITextViewDelegate,UITextFieldDelegate>

@property(strong, nonatomic)DirectMessagesDataSource *directMessagesDataSource;
@property (strong, nonatomic) UITextView *messageTV;
//@property (strong, nonatomic) UIView *commentTVBgView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;


@end

static NSString *const DirectMessagesCellIdentifier = @"DirectMessages";

@implementation DirectMessagesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self registeredkeyBoardNSNotificationCenter];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
     [IQKeyboardManager sharedManager].enable = NO;
}

-(void)initView{
    
    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ViewHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(0);
        make.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-40);
    }];
    
    [self setupkeyBoardDidShowView];
}

-(void)initData{
    
    [super initData];
    
    [[UserManager shareUserManager]userMessageListWithId:_otherUser_id];
    [UserManager shareUserManager].messageListSuccess = ^(NSArray *arr){
      
        if (arr.count == 0) {
           
            self.noDataType = NoDataTypeMessage;
            [self setHasData:NO];
        }
        self.dataArray = [[DirectMessagesStore shearDirectMessagesStore]configurationDirectMessagesMenuWithMenu:arr];
         [self steupTableView];
    };
}

-(void)initNavigationBarItems{
    
    self.title = _otherUser_name;
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(DirectMessagesTableViewCell *cell , DirectMessages *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item];
        
    };
    self.directMessagesDataSource = [[DirectMessagesDataSource alloc]initWithItems:self.dataArray cellIdentifier:DirectMessagesCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.directMessagesDataSource
                        cellIdentifier:DirectMessagesCellIdentifier
                               nibName:@"DirectMessagesTableViewCell"];
    
    self.tableView.dataSource = self.directMessagesDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"DirectMessagesTableViewCell"] forCellReuseIdentifier:DirectMessagesCellIdentifier];
    NSIndexPath * index  = [NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    DirectMessages*message = [self.directMessagesDataSource itemAtIndexPath:indexPath];
    CGFloat messageHeigh = [Global heightWithString:message.message width:ScreenWidth-170 fontSize:15];
    
    if (messageHeigh < 21) {
        messageHeigh = 21;
    }
    return messageHeigh+40;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (indexPath.row == ((NSIndexPath *)[tableView indexPathsForVisibleRows].lastObject).row ) {
        
        NSLog(@"%ld",((NSIndexPath *)[tableView indexPathsForVisibleRows].lastObject).row );
    }
}

-(void)setupkeyBoardDidShowView{
    
    _messageTV = [[UITextView alloc]initWithFrame:CGRectMake(20, ScreenHeigh-40-64, ScreenWidth-100, 30)];
    _messageTV.placeholder = @"回复";
    [self.view addSubview:_messageTV];
    [self.view addSubview:_sendButton];
    _messageTV.delegate = self;
    _messageTV.layer.masksToBounds = YES;
    _messageTV.backgroundColor = UIColorFromRGB(0xf5f7f9);
    _messageTV.layer.cornerRadius = 5;
    _sendButton.frame = CGRectMake(CGRectGetMaxX(_messageTV.frame)+((ScreenWidth - CGRectGetMaxX(_messageTV.frame))/2-10), 0, 25, 40);
    _sendButton.centerY = _messageTV.centerY;
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
    self.view.frame = CGRectMake(0, -height+64, ScreenWidth, ScreenHeigh-64);
}

#pragma mark 键盘将要收起
- (void)keyBoardWillHide:(NSNotification *)notification{
    
    self.view.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeigh-64);
}

- (IBAction)sendMessage:(UIButton *)sender {
    
    
    if ([Global stringIsNullWithString:_messageTV.text]) {
        
        [self showToastWithMessage:@"请输入内容"];
        return;
    }
    [[UserManager shareUserManager]sendMessageWithUserId:_otherUser_id messageContent:_messageTV.text];
    [UserManager shareUserManager].messageListSuccess = ^(id obj){
        
        NSLog(@"%@",obj);
    };
    
    [_messageTV resignFirstResponder];
    for (DirectMessages * message in self.dataArray) {
        
        if ([message.sender_user_id isEqualToNumber:[[UserManager shareUserManager] crrentUserId]]) {
            
            DirectMessages * messageNew = [[DirectMessages alloc]init];
            messageNew.message = _messageTV.text;
            messageNew.sender_head_img = message.sender_head_img;
            messageNew.sender_user_id = message.sender_user_id;
            [self.dataArray addObject:messageNew];
            NSLog(@"内存地址1：%p",message);
            NSLog(@"内存地址2：%p",messageNew);
            _messageTV.text = nil;
            [self steupTableView];
            return;
        }
    }
}

#pragma mark 键盘已经收起
//- (void)keyBoardDidHide:(NSNotification *)notification{
//   
//    self.view.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeigh);
////    [self shutDownTableViewCellEventWithAnimation:YES];
//}

//- (void)keyBoardWillShow:(NSNotification *)notification{
//    
//    self.navigationController.navigationBar.translucent = YES;
//}

//-(void)shutDownTableViewCellEventWithAnimation:(BOOL)animation{
//    
//    self.tableView.scrollEnabled = animation;
//    self.tableView.allowsSelection = animation;
//}

@end
