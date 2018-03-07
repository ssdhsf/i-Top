//
//  ShearViewManager.m
//  itop
//
//  Created by huangli on 2018/3/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ShearViewManager.h"
#import "ShearView.h"

@interface ShearViewManager()<UIGestureRecognizerDelegate>{
    
    ShearView *shearView;
    UIView * bgView;
}

@end

@implementation ShearViewManager

+ (instancetype)sharedShearViewManager{
    
    static ShearViewManager *organization = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken ,^{
        organization  = [[ShearViewManager alloc]init];
    });
    
    return organization;
}

-(void)setupShearView{
    
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigh)];
    bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBgViewAndPickerView)];
    recognizer.delegate = self;
    [bgView addGestureRecognizer:recognizer];
    shearView = [[[NSBundle mainBundle] loadNibNamed:@"ShearView" owner:nil options:nil] lastObject];
    shearView.frame = CGRectMake(0, ScreenHeigh, ScreenWidth, 300*KadapterH);
    shearView.selectShearItme = ^(NSInteger tag){

        NSLog(@"%ld",tag);
    };
    
    [shearView setupShearItem];
    [bgView addSubview:shearView];
}

- (void)addTimeViewToView:(UIView*)view{
    
    [view.window addSubview:bgView];
    [self editoeViewWithAnimation:YES];
}

-(void)hiddenBgViewAndPickerView{
    
    [self editoeViewWithAnimation:NO];
}

-(void)editoeViewWithAnimation:(BOOL)animation{
    
    //添加滚动动画
    [UIView animateWithDuration:0.2 animations:^{
        
        if (animation) {
            shearView.frame = CGRectMake(0, ScreenHeigh-245*KadapterH, ScreenWidth, 245*KadapterH);
        }else {
            shearView.frame = CGRectMake(0, ScreenHeigh, ScreenWidth, 300*KadapterH);
        }
        
    } completion:^(BOOL finished) {
        
        bgView.hidden  = !animation;
    }];
}


@end
