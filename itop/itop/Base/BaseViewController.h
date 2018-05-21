//
//  BaseViewController.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NoDataType) { //无数据类型
    NoDataTypeDefult = 0,  //默认
    NoDataTypeProduct = 1, //作品
    NoDataTypeMessage ,//消息
    NoDataTypeBusiness,//业务
    NoDataTypeLacation//位置
};

@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL hasData;
@property (nonatomic, assign) NSInteger showViewType;
//@property (nonatomic, strong) UIView *hideView;
@property (nonatomic, strong) UIImageView *showImg;
@property (nonatomic, strong) UILabel *tipsLab;
@property (nonatomic, assign) NSInteger originY;
@property (nonatomic, strong) NSString *tipsMessage;
@property (nonatomic, assign) NoDataType noDataType;


- (void)initView;
- (void)initNavigationBarItems;
- (void)initData;
- (void)back;
- (void)hiddenNavigationController:(BOOL)animated;
- (void)hiddenNavigafindHairlineImageView:(BOOL)animated;


- (void)registeredkeyBoardNSNotificationCenter;
- (void)registeredpushNotification;

#pragma mark 键盘已经弹出
- (void)keyBoardDidShow:(NSNotification *)notification;
#pragma mark 键盘将要收起
- (void)keyBoardWillHide:(NSNotification *)notification;
#pragma mark 键盘已经收起
- (void)keyBoardDidHide:(NSNotification *)notification;
#pragma mark 键盘将要弹出
- (void)keyBoardWillShow:(NSNotification *)notification;
//-(UIImageView *)findHairlineImageViewUnder:(UIView *)view;

-(void)fontReceivePushNotificationAlert:(NSNotification *)notification;
-(void)backgroundReceiveClickPushNotificationAlert:(NSNotification *)notification;
@end
