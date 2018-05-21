//
//  AlertView.h
//  itop
//
//  Created by huangli on 2018/2/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Province;
@class TagList;
typedef NS_ENUM(NSInteger, PickViewType) { //选择个人信息Type
    PickViewTypeNone = 0, //
    PickViewTypeEdit = 1, //
    PickViewTypeSex , //性别
    PickViewTypeAge ,//年龄
    PickViewTypeProvince,//选择城市
    PickViewTypeCompnySize, //选择企业规模
    PickViewTypeIndustry , //选择所属行业
    PickViewTypeField , //选择擅长
    PickViewTypePicture , //选择图片
    PickViewTypeScope , //选择范围
    PickViewTypeChannel ,//修改渠道列表
    PickViewTypeDate, //选择时间
    PickViewTypeDesginer, //选择设计师 （定制需求）
    PickViewTypeProduct,//选择设计师作品 （定制需求）
    PickViewTypeIntroduction //简介
};

//typedef NS_ENUM(NSInteger, SignPickViewType) { //入驻Type
//    SignPickViewTypeIndustry = 1, //选择所属行业
//    SignPickViewTypeCompnySize = 2, //选择企业规模
//    SignPickViewTypeProvince , //选择城市
//};

//typedef NS_ENUM(NSInteger, DemandReleasePickViewType) { //入驻Type
//    SignPickViewTypeIndustry = 0, //选择所属行业
//    SignPickViewTypeCompnySize = 1, //选择企业规模
//    SignPickViewTypeProvince , //选择城市
//};

typedef void(^AlertResult)(id index,id pickViewType);
typedef void(^SelectResult)(id superResult,id subResult);
//typedef void(^AlertSuperResult)(NSString *result, PickViewType pickViewType);
//typedef void(^AlertSubResult)(NSString *result, PickViewType pickViewType);

@interface AlertView : UIView

//@property (nonatomic, strong)NSMutableArray *provinceArray;
//@property (nonatomic, strong)NSMutableArray *cityArray;
@property (nonatomic, copy) AlertResult resultIndex;
@property (nonatomic, copy) AlertResult alertCancel;

@property (nonatomic, copy) SelectResult selectResult;
@property (nonatomic, strong)UIPickerView *pickView;
@property (nonatomic, strong)UITextField *inputNameTF; //输入
@property (nonatomic, strong)UIDatePicker *datePicker;//时间选择器
@property (nonatomic, strong)NSDate *selectDate; //选择的时间

@property (nonatomic, assign)PickViewType pickViewType; //选择类型
@property (nonatomic, strong)NSArray *superArray; //一级
@property (nonatomic, strong)NSArray *subArray;//二级列表

@property (nonatomic, strong)Province *province; //选择省份
@property (nonatomic, strong)Province *city; //选择的城市

@property (nonatomic, strong)TagList *superTag; //选择行业父级
@property (nonatomic, strong)TagList *subTag; //选择的行业子级

@property (nonatomic, strong)DesignerList *designer; //选择的设计师
@property (nonatomic, strong)EditCase *editCase; //选择设计师的作品

@property (nonatomic, strong)NSString *tempSelectItme; // 输入的内容

- (instancetype)initWithTitle:(NSString *)title
                      message:(UIView *)messageView
                      sureBtn:(NSString *)sureTitle
                    cancleBtn:(NSString *)cancleTitle
                 pickViewType:(PickViewType)pickViewType
                   superArray:(NSArray *)superArray
                     subArray:(NSArray *)subArray;
- (void)showXLAlertView;
- (UIPickerView *)setPickView;

-(void)setupPickViewWithContent:(NSString *)content;
-(void)setupInputNameTFWithPlaceholder:(NSString *)placeholder content:(NSString *)content;
@end
