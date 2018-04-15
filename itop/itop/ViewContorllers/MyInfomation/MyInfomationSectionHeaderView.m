//
//  MyInfomationSectionHeaderView.m
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MyInfomationSectionHeaderView.h"

@implementation MyInfomationSectionHeaderView

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


//-(void)initSubViewsWithSection:(NSInteger)section{
//    
//    UIView *mark = UIView.new;
//    mark.backgroundColor = [UIColor redColor];
//    [self addSubview:mark];
//    [mark mas_makeConstraints:^(MASConstraintMaker *make){
//        make.left.mas_equalTo(20);
//        make.top.mas_equalTo(35);
//        make.height.mas_equalTo(14);
//        make.width.mas_equalTo(2);
//    }];
//    
//    UIButton *divisionView = UIButton.new;
//    [divisionView setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
////    divisionView.backgroundColor = [UIColor redColor];
//    divisionView.tag = section;
//    [divisionView addTarget:self action:@selector(pushListVc:) forControlEvents:UIControlEventTouchDown];
//    //        divisionView.image = [UIImage imageNamed:@"icon_more"];
//    [self addSubview:divisionView];
//    [divisionView mas_makeConstraints:^(MASConstraintMaker *make){
//        make.right.mas_equalTo(-20);
//        make.top.mas_equalTo(35);
//        make.height.mas_equalTo(14);
//        make.width.mas_equalTo(7);
//    }];
//    
//    _titleLbl = UILabel.new;
//    [self addSubview:_titleLbl];
//    _titleLbl.text = @"";
//    _titleLbl.font = [UIFont systemFontOfSize:17];
//    _titleLbl.textColor = [UIColor blackColor];
//    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make){
//        make.left.mas_equalTo(27);
//        make.top.mas_equalTo(32);
//        make.height.mas_equalTo(21);
//    }];
//}

-(void)initMyInfoSubViewsWithSection:(NSInteger)section{
    
    
    if (section == 0 ) {
        
        UIButton *info = UIButton.new;
        [self addSubview:info];
        [info mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(self);
            make.height.width.mas_equalTo(80);
            make.top.mas_equalTo(73);
        }];
        info.layer.masksToBounds = YES;
        info.layer.cornerRadius = 40;
        
        UILabel *userNameLabel = [UILabel new];
        userNameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:userNameLabel];
        [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(ScreenWidth);
            make.height.mas_equalTo(21);
            make.top.mas_equalTo(163);
        }];
        userNameLabel.text = [[UserManager shareUserManager]crrentUserInfomation].user_info.nickname;
        if ([[UserManager shareUserManager]crrentInfomationModel] != nil) {
            
            NSString *headView = [[UserManager shareUserManager]crrentUserInfomation].user_info.head_img;
            [info.imageView sd_setImageWithURL:[NSURL URLWithString:headView] placeholderImage:[UIImage imageNamed:@"default_man"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                [info setImage:info.imageView.image forState:UIControlStateNormal];
            }];
            userNameLabel.text = [[UserManager shareUserManager]crrentInfomationModel].user_info.nickname;
        }else if ([[UserManager shareUserManager]crrentUserInfomation] != nil) {
            NSString *headView = [[UserManager shareUserManager]crrentUserInfomation].user_info.head_img;
            [info.imageView sd_setImageWithURL:[NSURL URLWithString:headView] placeholderImage:[UIImage imageNamed:@"default_man"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                [info setImage:info.imageView.image forState:UIControlStateNormal];
            }];
        } else {
            
             [info setImage:[UIImage imageNamed:@"default_man"] forState:UIControlStateNormal];
             userNameLabel.text = @"点击登陆";
        }
       
        [info addTarget:self action:@selector(nextInfomation:) forControlEvents:UIControlEventTouchDown];
        //        divisionView.image = [UIImage imageNamed:@"icon_more"];
        
    }
    _titleLbl = UILabel.new;
    [self addSubview:_titleLbl];
    _titleLbl.text = section == 0? @"我的" : @"i-Top";
    _titleLbl.font = [UIFont systemFontOfSize:16];
    _titleLbl.textColor = [UIColor blackColor];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(section == 0 ? 230 : 0);
        make.height.mas_equalTo(21);
    }];
    
    UIView *markt = UIView.new;
    markt.backgroundColor = UIColorFromRGB(0xe5e8ed);
    [self addSubview:markt];
    [markt mas_makeConstraints:^(MASConstraintMaker *maket){
        maket.left.mas_equalTo(0);
        maket.top.mas_equalTo(section == 0 ? 259 : 29);
        maket.height.mas_equalTo(1);
        maket.width.mas_equalTo(ScreenWidth);
    }];
}

-(void)nextInfomation:(UIButton *)button{
   
    _sectionHeader();
    NSLog(@"21");
}

@end
