//
//  AlertView.h
//  itop
//
//  Created by huangli on 2018/2/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PickViewType) { //首页Tag类型
    PickViewTypeNickName = 2, //
    PickViewTypeName = 3, //
    PickViewTypeSex , //默认
    PickViewTypeAge ,//作品
    PickViewTypeProvince,//热点
};

typedef void(^AlertResult)(NSInteger index , PickViewType pickViewType);

@interface AlertView : UIView

@property (nonatomic, strong)NSMutableArray *provinceArray;
@property (nonatomic, strong)NSMutableArray *cityArray;
@property (nonatomic, copy) AlertResult resultIndex;
@property (nonatomic, strong)UIPickerView *pickView;
@property (nonatomic, assign)PickViewType pickViewType; //选择类型

- (instancetype)initWithTitle:(NSString *)title
                      message:(UIView *)messageView
                      sureBtn:(NSString *)sureTitle
                    cancleBtn:(NSString *)cancleTitle
                 pickViewType:(PickViewType)pickViewType;
- (void)showXLAlertView;
- (UIPickerView *)setPickView;
@end
