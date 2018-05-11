//
//  AlertView.m
//  itop
//
//  Created by huangli on 2018/2/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "AlertView.h"
///alertView  宽
#define AlertW ScreenWidth-120
///各个栏目之间的距离
#define XLSpace 10.0

@interface AlertView()<UIPickerViewDelegate, UIPickerViewDataSource>
//弹窗
@property (nonatomic,retain) UIView *alertView;
//title
@property (nonatomic,retain) UILabel *titleLbl;
//内容
@property (nonatomic,retain) UIView *msgLbl;
//确认按钮
@property (nonatomic,retain) UIButton *sureBtn;
//取消按钮
@property (nonatomic,retain) UIButton *cancleBtn;
//横线线
@property (nonatomic,retain) UIView *lineView;
//竖线
@property (nonatomic,retain) UIView *verLineView;

@end

@implementation AlertView


- (instancetype)initWithTitle:(NSString *)title
                      message:(UIView *)messageView
                      sureBtn:(NSString *)sureTitle
                    cancleBtn:(NSString *)cancleTitle
                 pickViewType:(PickViewType)pickViewType
                   superArray:(NSArray *)superArray
                     subArray:(NSArray *)subArray{
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 5.0;
        
        self.alertView.frame = CGRectMake(0, 0, AlertW, 100);
        self.alertView.layer.position = self.center;
        
        if (title) {
            
            self.titleLbl = [self GetAdaptiveLable:CGRectMake(2*XLSpace, 2*XLSpace, AlertW-4*XLSpace, 20) AndText:title andIsTitle:YES];
            self.titleLbl.textAlignment = NSTextAlignmentCenter;
            
            [self.alertView addSubview:self.titleLbl];
            
            CGFloat titleW = self.titleLbl.bounds.size.width;
            CGFloat titleH = self.titleLbl.bounds.size.height;
            
            self.titleLbl.frame = CGRectMake((AlertW-titleW)/2, 2*XLSpace, titleW, titleH);
            
        }
        
        self.pickViewType = pickViewType;
        self.superArray = superArray;
        self.subArray = subArray;
        if (pickViewType == PickViewTypeEdit) {
               
            [self initInputNameTF];
        } else if(pickViewType == PickViewTypeDate){
            
            [self initDateView];
            
        } else {
            
            [self initPickView];
        }
        
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = self.msgLbl?CGRectMake(0, CGRectGetMaxY(self.msgLbl.frame)+2*XLSpace, AlertW, 1):CGRectMake(0, CGRectGetMaxY(self.titleLbl.frame)+2*XLSpace, AlertW, 1);
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:self.lineView];
        
        //两个按钮
        if (cancleTitle && sureTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2, 40);
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            //[self.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        if (cancleTitle && sureTitle) {
            self.verLineView = [[UIView alloc] init];
            self.verLineView.frame = CGRectMake(CGRectGetMaxX(self.cancleBtn.frame), CGRectGetMaxY(self.lineView.frame), 1, 40);
            self.verLineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
            [self.alertView addSubview:self.verLineView];
        }
        
        if(sureTitle && cancleTitle){
            
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureBtn.frame = CGRectMake(CGRectGetMaxX(self.verLineView.frame), CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2+1, 40);
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
            //[self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.sureBtn.tag = 2;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.sureBtn];
            
        }
        
        //只有取消按钮
        if (cancleTitle && !sureTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            //[self.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        //只有确定按钮
        if(sureTitle && !cancleTitle){
            
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
            //[self.sureBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.sureBtn.tag = 2;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.sureBtn];
            
        }
        
        //计算高度
        CGFloat alertHeight = cancleTitle?CGRectGetMaxY(self.cancleBtn.frame):CGRectGetMaxY(self.sureBtn.frame);
        self.alertView.frame = CGRectMake(0, 0, AlertW, alertHeight);
        self.alertView.layer.position = self.center;
        self.pickViewType = pickViewType;
        
        [self addSubview:self.alertView];
    }
    
    return self;
}

#pragma mark - 弹出 -
- (void)showXLAlertView
{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation{
    
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - 回调 -设置只有2  -- > 确定才回调
- (void)buttonEvent:(UIButton *)sender
{

//    if ([self anySubViewScrolling:_pickView]) {
    if (sender.tag == 2) {
        if (self.selectResult) {
            
            switch (_pickViewType) {
                case PickViewTypeAge:
                case PickViewTypeSex:
                case PickViewTypeCompnySize:
                  
                    self.selectResult(_tempSelectItme,nil) ;
                    break;
                    
                case PickViewTypeEdit:
                    
                    self.selectResult(_inputNameTF.text,nil) ;
                    break;
                    
                case PickViewTypeProvince:
                
                    self.selectResult(_province,_city) ;
                    break;
                    
                case PickViewTypeIndustry:
                  
                    self.selectResult(_superTag,_subTag) ;
                    break;
                case PickViewTypeField:
                    
                    self.selectResult(_superTag,nil) ;
                    break;
                case PickViewTypeDate:
                    
                    self.selectResult(_selectDate,nil) ;
                    break;
                case PickViewTypeDesginer:
                    
                    self.selectResult(_designer,nil) ;
                    break;
                case PickViewTypeProduct:
                    
                    self.selectResult(_h5,nil) ;
                    break;
            }
        }
    }
    [self removeFromSuperview];
//}

}

-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andIsTitle:(BOOL)isTitle
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.numberOfLines = 0;
    contentLbl.text = contentStr;
    contentLbl.textAlignment = NSTextAlignmentCenter;
    if (isTitle) {
        contentLbl.font = [UIFont boldSystemFontOfSize:16.0];
    }else{
        contentLbl.font = [UIFont systemFontOfSize:14.0];
    }
    
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
    mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [mParaStyle setLineSpacing:3.0];
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0,[contentStr length])];
    [contentLbl setAttributedText:mAttrStr];
    [contentLbl sizeToFit];
    
    return contentLbl;
}

-(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(void)initPickView{
    
    if (_pickViewType == PickViewTypeSex) {
        
        self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, 60)];
        
    } else {
        self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, 120)];
    }
    [self.alertView addSubview:self.pickView];
    self.pickView.backgroundColor = [UIColor whiteColor];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    self.pickView.showsSelectionIndicator = YES;
    [self.pickView reloadAllComponents];
    self.pickView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLbl.frame)+XLSpace, self.pickView.width, self.pickView.height);
    self.msgLbl = [[UIView alloc]initWithFrame:self.pickView.frame];
}

-(void)initDateView{
    
    _datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, 120)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    
    _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    _selectDate = _datePicker.date;
    [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [self.alertView addSubview:_datePicker];
    self.datePicker.frame = CGRectMake(0, CGRectGetMaxY(self.titleLbl.frame)+XLSpace, self.datePicker.width, self.datePicker.height);
    self.msgLbl = [[UIView alloc]initWithFrame:self.datePicker.frame];
}

- (void)dateChange:(UIDatePicker *)datePicker{
    
    _selectDate = datePicker.date;
}

-(void)initInputNameTF{
    
    self.inputNameTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth-160, 30)];
    [_inputNameTF becomeFirstResponder];
    _inputNameTF.textAlignment = UITextAlignmentCenter;
    _inputNameTF.font = [UIFont systemFontOfSize:15];
    [self.alertView addSubview:_inputNameTF];
    self.inputNameTF.frame = CGRectMake(20, CGRectGetMaxY(self.titleLbl.frame)+XLSpace, self.inputNameTF.width, self.inputNameTF.height);
    self.msgLbl = [[UIView alloc]initWithFrame:self.inputNameTF.frame];
}

#pragma mark 重新加载数据时将有数据的itme赋给输入框
-(void)setupInputNameTFWithPlaceholder:(NSString *)placeholder content:(NSString *)content{
    
    if ([Global stringIsNullWithString:content]) {
        self.inputNameTF.placeholder = [NSString stringWithFormat:@"请输入%@",placeholder];
    }  else {
        self.inputNameTF.text = content;
    }
}

#pragma mark 重新加载数据时将有数据的itme赋给已选择的temp
-(void)setupPickViewWithContent:(NSString *)content{

    NSInteger index ;
    if (![Global stringIsNullWithString:content]) {
        
        switch (_pickViewType) {
            case PickViewTypeAge:
            case PickViewTypeSex:
            case PickViewTypeCompnySize:
           
                index = [self.superArray indexOfObject: [content stringByReplacingOccurrencesOfString:@" " withString:@""]];//我们提交的数据后台不知道为什么加空格 所以要去掉
                [self.pickView selectRow:index inComponent:0 animated:NO];
                break;
            case PickViewTypeProvince:
                
                [self positioningProvinceWithindex:content];
                break;
                
            case PickViewTypeIndustry:

                [self positioningIndustryWithindex:content];
                break;
             case PickViewTypeField:
                
                [self positioningFieldWithindex:content];
                break;
            case PickViewTypeDesginer:
                
                [self positioningDesginerWithContent:content];
                break;
            case PickViewTypeProduct:
                
                [self positioningProductWithContent:content];
                break;
            default:
                break;
        }
    }
}

#pragma mark 选择数据时将有数据的城市赋给已选择的temp
-(void)positioningProvinceWithindex:(NSString *)content{
    
    NSArray *arr = [content componentsSeparatedByString:@","];
    NSInteger index = 0 ;
    NSInteger inde2 = 0 ;
    for (Province *province in self.superArray ) {
        
        if ([province.address isEqualToString:arr[0]]) {
            
            index = [self.superArray indexOfObject:province];
            _subArray = province.cityArray;
        }
    }
    [self.pickView selectRow:index inComponent:0 animated:NO];
    
    if (arr.count > 1) {
        
        for (Province *province in self.subArray ) {
            
            if ([province.address isEqualToString:arr[1]]) {
                
                inde2 = [self.subArray indexOfObject:province];
            }
        }
        [self.pickView selectRow:inde2 inComponent:1 animated:NO];
    }
}

#pragma mark 选择数据时将有数据的行业赋给已选择的temp
-(void)positioningIndustryWithindex:(NSString *)content{
    
    NSArray *arr = [content componentsSeparatedByString:@","];
    NSInteger index = 0 ;
    NSInteger inde2 = 0 ;
    for (TagList *industry in _superArray ) {
        
        if ([industry.name isEqualToString:arr[0]]) {
            
            index = [_superArray indexOfObject:industry];
            self.subArray = industry.subTagArray;
        }
    }
    [self.pickView selectRow:index inComponent:0 animated:NO];
    
    if (arr.count > 1) {
        
        for (TagList *industry in self.subArray ) {
            
            if ([industry.name isEqualToString:arr[1]]) {
                
                inde2 = [self.subArray indexOfObject:industry];
            }
        }
        [self.pickView selectRow:inde2 inComponent:1 animated:NO];
    }
}

#pragma mark 选择数据时将有数据的擅长领域赋给已选择的temp
-(void)positioningFieldWithindex:(NSString *)content{
    NSInteger index = 0 ;

    for (TagList *industry in _superArray ) {
        
        if ([industry.name isEqualToString:content]) {
            
            index = [_superArray indexOfObject:industry];
        }
    }
    [self.pickView selectRow:index inComponent:0 animated:NO];
}

#pragma mark 选择数据时将有数据的设计师赋给已选择的temp
-(void)positioningDesginerWithContent:(NSString *)content{
    NSInteger index = 0 ;
    
    for (DesignerList *desginer in _superArray ) {
        
        if ([desginer.nickname isEqualToString:content]) {
            
            index = [_superArray indexOfObject:desginer];
        }
    }
    [self.pickView selectRow:index inComponent:0 animated:NO];
}

#pragma mark 选择数据时将有数据的设计师作品H5赋给已选择的temp
-(void)positioningProductWithContent:(NSString *)content{
    NSInteger index = 0 ;
    
    for (H5List *h5 in _superArray ) {
        
        if ([h5.title isEqualToString:content]) {
            
            index = [_superArray indexOfObject:h5];
        }
    }
    [self.pickView selectRow:index inComponent:0 animated:NO];
}

#pragma mark 数据源 Method numberOfComponentsInPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return _pickViewType == PickViewTypeProvince || _pickViewType == PickViewTypeIndustry ? 2 : 1;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{

    UILabel *lbl = (UILabel *)view;

    if (lbl == nil) {

        lbl = [[UILabel alloc]init];
        //在这里设置字体相关属性
        lbl.adjustsFontSizeToFitWidth = YES;
        lbl.font = [UIFont systemFontOfSize:15];
        lbl.textColor = [UIColor blackColor];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setBackgroundColor:[UIColor clearColor]];
    }
    //重新加载lbl的文字内容
    if ([[self pickerView:pickerView titleForRow:row forComponent:component] isKindOfClass: [NSString class]]) {
        lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        
    } else if([[self pickerView:pickerView titleForRow:row forComponent:component] isKindOfClass: [Province class]]){
        
        Province *province = [self pickerView:pickerView titleForRow:row forComponent:component];
        lbl.text = province.address;
    }else if([[self pickerView:pickerView titleForRow:row forComponent:component] isKindOfClass: [TagList class]]){
        
        TagList *tag = [self pickerView:pickerView titleForRow:row forComponent:component];
        lbl.text = tag.name;
    }else if([[self pickerView:pickerView titleForRow:row forComponent:component] isKindOfClass: [DesignerList class]]){
        
        DesignerList *designer = [self pickerView:pickerView titleForRow:row forComponent:component];
        lbl.text = designer.nickname;
    }else if([[self pickerView:pickerView titleForRow:row forComponent:component] isKindOfClass: [H5List class]]){
        
        H5List *h5 = [self pickerView:pickerView titleForRow:row forComponent:component];
        lbl.text = h5.title;
    }
    
    return lbl;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if (component==0){
        
        return self.superArray.count;
        
    }else{
        
        return _subArray.count;
    }
    return 0;
}

#pragma mark delegate 显示信息的方法
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component==0){
    
        switch (_pickViewType) {
            case PickViewTypeAge:
            case PickViewTypeSex:
            case PickViewTypeCompnySize:
            
                _tempSelectItme = _superArray[row];
                
                break;
            case PickViewTypeProvince:
               _province = self.superArray[row];
                break;
            case PickViewTypeIndustry:
                
               _superTag = self.superArray[row];
                break;
            case PickViewTypeField:
                
               _superTag = self.superArray[row];
                break;
            case PickViewTypeDesginer:
                
                _designer = self.superArray[row];
                break;
            case PickViewTypeProduct:
                
                _h5 = self.superArray[row];
                break;
                
        }
        
        return self.superArray[row];
        
    }else{
        
        if (_pickViewType == PickViewTypeProvince) {
            
            _city = self.subArray[row];
        } else {
            
            _subTag = self.subArray[row];
        }
        
        return self.subArray[row];
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if (component==0){
        switch (_pickViewType) {
            case PickViewTypeAge:
            case PickViewTypeSex:
            case PickViewTypeCompnySize:
  
                _tempSelectItme = _superArray[row];
                break;
                
            case PickViewTypeProvince:
                _province = self.superArray[row];
                self.subArray =_province.cityArray;
                [self.pickView reloadComponent:1];
                break;
                
            case PickViewTypeIndustry:

                _superTag = self.superArray[row];
                _subArray = _superTag.subTagArray;;
                [self.pickView reloadComponent:1];
                break;
                
            case PickViewTypeField:
                _superTag = self.superArray[row];
                break;
                
            case PickViewTypeDesginer:
                
                _designer = self.superArray[row];
                break;
            case PickViewTypeProduct:
                
                _h5 = self.superArray[row];
                break;
        }
    }else{
        
        if (_pickViewType == PickViewTypeProvince) {

            _city = self.subArray[row];
        } else {

            _subTag = self.subArray[row];

        }
    }
}

- (BOOL)anySubViewScrolling:(UIView *)view{
    
    if ([view isKindOfClass:[UIScrollView class]]) {
        
        UIScrollView *scrollView = (UIScrollView *)view;
        
        if (scrollView.dragging || scrollView.decelerating) {
            
            return NO;
            
        } else {
            
            return YES;
        }
    }
    for (UIView *theSubView in view.subviews) {

        if ([self anySubViewScrolling:theSubView]) {

            return YES;
        }
    }
    return NO;
}


@end
