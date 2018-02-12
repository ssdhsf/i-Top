//
//  designerInfoHeaderView.m
//  itop
//
//  Created by huangli on 2018/1/29.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DesignerInfoHeaderView.h"

@implementation DesignerInfoHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
      
        UIView *bgView = [UIView new];
        CGFloat proportion = ScreenWidth *0.285;
        [bgView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.right.top.mas_equalTo(self);
            make.height.mas_equalTo(proportion);
        }];
        [self addSubview:bgView];
        [bgView.layer addSublayer:[UIColor setGradualChangingColor:bgView fromColor:@"FFA5EC" toColor:@"DEA2FF"]];
        
        _iconImage = [UIImageView new];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(ScreenWidth *0.285 -20);
            make.height.mas_equalTo(make.width);
        }];
        
        _iconImage.image = [UIImage imageNamed:@"default_man"];
        [self addSubview:_iconImage];
        
    }
    
    return self;
}

@end
