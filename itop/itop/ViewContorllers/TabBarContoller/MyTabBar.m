//
//  MyTabBar.m
//  xixun
//
//  Created by huangli on 2017/10/12.
//  Copyright © 2017年 Vanber. All rights reserved.
//

#import "MyTabBar.h"

#define AddButtonMargin 10
#define tabBarHeight [UIManager getTabBarHeight]
#define standOutHeight 12

@interface MyTabBar ()

@property (nonatomic, weak)UIButton *signlnButton;
@property (nonatomic, weak)UILabel  *signlnLabel;

@end

@implementation MyTabBar


-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame])
    {
//        //创建中间“+”按钮
//        UIButton *addBtn = [[UIButton alloc] init];
//        //设置默认背景图片
//        [addBtn setBackgroundImage:[UIImage imageNamed:@"ic_tab_signin"] forState:UIControlStateNormal];
//        //设置按下时背景图片
//        [addBtn setBackgroundImage:[UIImage imageNamed:@"ic_tab_signin_select"] forState:UIControlStateHighlighted];
//        //添加响应事件
//        [addBtn addTarget:self action:@selector(addBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
//        //将按钮添加到TabBar
//        [self addSubview:addBtn];
        [self insertSubview:[self drawTabbarBgImageView]  atIndex:0];
//        self.backgroundColor = [UIColor whiteColor];
        
//        self.signlnButton = addBtn;
    }
    return self;
}

//-(void)addBtnDidClick{
//    
//    if([self.myTabBarDelegate respondsToSelector:@selector(addButtonClick:)]){
//        [self.myTabBarDelegate addButtonClick:self];
//    }
//}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    //去掉TabBar上部的横线
    for (UIView  * view in  self .subviews ){
        
        if ([view isKindOfClass :[UIImageView class]] &&view.bounds .size .height  <=  1 ){
            UIImageView  * ima =(UIImageView*)view;
            ima.hidden  =  YES ;
        }
    }
//
//    //设置“+”按钮的位置
////    NSLog(@"%f",self.centerX);
////    self.signlnButton.centerX = self.centerX;
////    self.signlnButton.centerY = self.height * 0.5 - 1.5 * AddButtonMargin;
//    //设置“+”按钮的大小为图片的大小
//    self.signlnButton.size = CGSizeMake(self.signlnButton.currentBackgroundImage.size.width, self.signlnButton.currentBackgroundImage.size.height);
//    CGFloat y = [self drawTabbarBgImageView].frame.size.height;
//    CGFloat x = self.frame.size.width;
//    CGFloat h = self.signlnButton.currentBackgroundImage.size.height;
//    self.signlnButton.center = CGPointMake(x/2, y/2-(h/2));
//    
//    //创建并设置“+”按钮下方的文本为“添加”
//    UILabel *addLbl = [[UILabel alloc] init];
//    addLbl.text = @"签到";
//    addLbl.font = [UIFont systemFontOfSize:10];
//    addLbl.textColor = [UIColor grayColor];
//    [addLbl sizeToFit];
//    
//    //设置“添加”label的位置
//    addLbl.centerX = self.signlnButton.centerX;
//    addLbl.centerY = CGRectGetMaxY(self.signlnButton.frame) + 0.5 * AddButtonMargin + 0.5+6;
//    
//    [self addSubview:addLbl];
//    
//    self.signlnLabel = addLbl;
//    
//    int btnIndex = 0;
//    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
//    Class class = NSClassFromString(@"UITabBarButton");
//    for (UIView *btn in self.subviews) {//遍历TabBar的子控件
//        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
//            //每一个按钮的宽度等于TabBar的三分之一
//            btn.width = self.width / 5;
//            
//            btn.x = btn.width * btnIndex;
//            
//            btnIndex++;
//            //如果索引是1(即“+”按钮)，直接让索引加一
//            if (btnIndex == 2) {
//                btnIndex++;
//            }
//            
//        }
//    }
//    //将“+”按钮放到视图层次最前面
//    [self bringSubviewToFront:self.signlnButton];
}

//重写hitTest方法，去监听"+"按钮和“添加”标签的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击“+”按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有TabBar的，那么肯定是在根控制器页面
    //在根控制器页面，那么我们就需要判断手指点击的位置是否在“+”按钮或“添加”标签上
    //是的话让“+”按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO){
        
        //将当前TabBar的触摸点转换坐标系，转换到“+”按钮的身上，生成一个新的点
        CGPoint newA = [self convertPoint:point toView:self.signlnButton];
        //将当前TabBar的触摸点转换坐标系，转换到“添加”标签的身上，生成一个新的点
        CGPoint newL = [self convertPoint:point toView:self.signlnLabel];
        
        //判断如果这个新的点是在“+”按钮身上，那么处理点击事件最合适的view就是“+”按钮
        if ( [self.signlnButton pointInside:newA withEvent:event])
        {
            return self.signlnButton;
        }
        //判断如果这个新的点是在“添加”标签身上，那么也让“+”按钮处理事件
        else if([self.signlnLabel pointInside:newL withEvent:event])
        {
            return self.signlnButton;
        }
        else
        {//如果点不在“+”按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    else{
        //TabBar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

- (UIImageView *)drawTabbarBgImageView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [view.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(view)];
    
//    NSLog(@"tabBarHeight：  %f" , tabBarHeight);// 设备tabBar高度 一般49
//    CGFloat radius = 30;// 圆半径
//    CGFloat allFloat= (pow(radius, 2)-pow((radius-standOutHeight), 2));// standOutHeight 突出高度 12
//    CGFloat ww = sqrtf(allFloat);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , kDevice_Is_iPhoneX ? 83 : 49 )];// ScreenW设备的宽
    imageView.backgroundColor = [UIColor whiteColor];
//    CGSize size = imageView.frame.size;
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(size.width/2 - ww, standOutHeight)];
//    NSLog(@"ww: %f", ww);
//    NSLog(@"ww11: %f", 0.5*((radius-ww)/radius));
//    CGFloat angleH = 0.5*((radius-standOutHeight)/radius);
//    NSLog(@"angleH：%f", angleH);
//    CGFloat startAngle = (1+angleH)*((float)M_PI); // 开始弧度
//    CGFloat endAngle = (2-angleH)*((float)M_PI);//结束弧度
    // 开始画弧：CGPointMake：弧的圆心  radius：弧半径 startAngle：开始弧度 endAngle：介绍弧度 clockwise：YES为顺时针，No为逆时针
//    [path addArcWithCenter:CGPointMake((size.width)/2, radius) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
//    // 开始画弧以外的部分
//    [path addLineToPoint:CGPointMake(size.width/2+ww, standOutHeight)];
//    [path addLineToPoint:CGPointMake(size.width, standOutHeight)];
//    [path addLineToPoint:CGPointMake(size.width,size.height)];
//    [path addLineToPoint:CGPointMake(0,size.height)];
//    [path addLineToPoint:CGPointMake(0,standOutHeight)];
//    [path addLineToPoint:CGPointMake(size.width/2-ww, standOutHeight)];
//    layer.path = path.CGPath;
//    layer.fillColor = [UIColor whiteColor].CGColor;// 整个背景的颜色
//    layer.strokeColor = [UIColor colorWithWhite:0.765 alpha:1.000].CGColor;//边框线条的颜色
//    layer.lineWidth = 1.0;//边框线条的宽
    // 在要画背景的view上 addSublayer:
    [imageView addSubview:view];
    return imageView;
}

@end
