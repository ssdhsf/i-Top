//
//  AlertView.h
//  itop
//
//  Created by huangli on 2018/2/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PickViewType) { //选择个人信息Type
    PickViewTypeNone = 0, //
    PickViewTypeEdit = 1, //
    PickViewTypeSex , //性别
    PickViewTypeAge ,//年龄
    PickViewTypeProvince,//选择城市
    PickViewTypeCompnySize, //选择企业规模
    PickViewTypeIndustry , //选择所属行业
    PickViewTypeField , //选择擅长
};

typedef NS_ENUM(NSInteger, SignPickViewType) { //选择个人信息Type
    SignPickViewTypeIndustry = 1, //选择所属行业
    SignPickViewTypeCompnySize = 2, //选择企业规模
    SignPickViewTypeProvince , //选择城市
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
