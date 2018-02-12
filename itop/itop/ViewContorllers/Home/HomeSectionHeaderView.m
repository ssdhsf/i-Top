//
//  HomeSectionHeaderView.m
//  itop
//
//  Created by huangli on 2018/2/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "HomeSectionHeaderView.h"

@implementation HomeSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        
        //        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.frame = rect;
}


-(void)initSubViewsWithSection:(NSInteger)section{
    
    UIView *mark = UIView.new;
    mark.backgroundColor = [UIColor redColor];
    [self addSubview:mark];
    [mark mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(35);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(2);
    }];
    
    UIButton *divisionView = UIButton.new;
    [divisionView setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
    //    divisionView.backgroundColor = [UIColor redColor];
    divisionView.tag = section;
    [divisionView addTarget:self action:@selector(pushListVc:) forControlEvents:UIControlEventTouchDown];
    //        divisionView.image = [UIImage imageNamed:@"icon_more"];
    [self addSubview:divisionView];
    [divisionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(35);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(7);
    }];
    
    _titleLbl = UILabel.new;
    [self addSubview:_titleLbl];
    _titleLbl.text = @"";
    _titleLbl.font = [UIFont systemFontOfSize:17];
    _titleLbl.textColor = [UIColor blackColor];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(27);
        make.top.mas_equalTo(32);
        make.height.mas_equalTo(21);
    }];
}


-(void)pushListVc:(UIButton *)button{
    
    _sectionHeader(button.tag);
}

@end
