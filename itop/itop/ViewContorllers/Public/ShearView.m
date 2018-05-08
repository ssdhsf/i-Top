//
//  ShearView.m
//  itop
//
//  Created by huangli on 2018/3/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ShearView.h"

@implementation ShearView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
       
//        [self setupShearItemWithshearTepy:<#(ShearType)#>];
    }
    
    return self;
}


-(NSDictionary*)shearItemArrayWithshearTepy:(ShearType)shearType{
    
    NSDictionary *shearItem = [NSDictionary dictionary];
    if (shearType == ShearTypeMyhome) {
        
        shearItem = @{ @"朋友圈":@"share_icon_friendcircle",
                       @"微信好友":@"share_icon_wxfriend",
                       @"QQ好友":@"share_icon_qqfriend",
                       @"新浪微博":@"share_icon_xinlan"};
    } else {
        shearItem = @{ @"朋友圈":@"share_icon_friendcircle",
                       @"微信好友":@"share_icon_wxfriend",
                       @"QQ空间":@"share_icon_qqzone",
                       @"QQ好友":@"share_icon_qqfriend",
                       @"新浪微博":@"share_icon_xinlan",
                       @"复制链接":@"share_icon_link",
                       @"二维码":@"share_icon_code" };
    }
   
    return shearItem;
}

-(NSArray*)shearItemTitleArrayWithshearTepy:(ShearType)shearType{
    
    NSArray *shearItem= [NSArray array];
    if (shearType == ShearTypeMyhome) {
        
        shearItem = @[@"朋友圈",@"微信好友",@"QQ好友",@"新浪微博"];
    } else {
        shearItem = @[@"朋友圈",@"微信好友",@"QQ空间",@"QQ好友",@"新浪微博",@"复制链接",@"二维码"];
    }
    return shearItem;
}

-(void)setupShearItemWithshearTepy:(ShearType)shearType{
    
    for (int i = 0; i < [self shearItemTitleArrayWithshearTepy:shearType].count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UILabel *label = [[UILabel alloc]init];
        if (i < 4) {
            button.frame = CGRectMake(28+i*48+(((ScreenWidth-(48*4))/4)*i), 58, ((ScreenWidth-(48*4))/4), ((ScreenWidth-(48*4))/4));
            
            label.frame = CGRectMake(10+i*10+(((ScreenWidth-(10*5))/4)*i), CGRectGetMaxY(button.frame)+5, ((ScreenWidth-(10*5))/4),19);
            
        } else {
            button.frame = CGRectMake(24+(i-4)*48+(((ScreenWidth-(48*4))/4)*(i-4)), 58+((ScreenWidth-(48*4))/4)+27+24, ((ScreenWidth-(48*4))/4), ((ScreenWidth-(48*4))/4));
            
            label.frame = CGRectMake(10+(i-4)*10+(((ScreenWidth-(10*5))/4)*(i-4)), CGRectGetMaxY(button.frame)+5,((ScreenWidth-(10*5))/4),19);
        }
        
        [button addTarget:self action:@selector(shear:) forControlEvents:UIControlEventTouchDown];
        label.centerX = button.centerX;
        
        //        NSLog(@"%f--%f--%f--%f",button.frame.origin.x,button.frame.origin.y,button.frame.size.height,button.frame.size.width);
        //        button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.frame.size.height+5, -button.imageView.bounds.size.width, 0,0);
        //        // button图片的偏移量
        //        button.imageEdgeInsets = UIEdgeInsetsMake(0, button.titleLabel.frame.size.width/2,button.titleLabel.frame.size.height+5, -button.titleLabel.frame.size.width/2);
        
        NSString *string = [self shearItemTitleArrayWithshearTepy:shearType][i];
        [button setImage:[UIImage imageNamed:[self shearItemArrayWithshearTepy:shearType][string]] forState:UIControlStateNormal];
        label.text = string;
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        button.tag = i;
        [self addSubview:button];
        [self addSubview:label];
    }
}


-(void)shear:(UIButton *)sender{
    
    _selectShearItme(sender.tag);
}

- (IBAction)cancel:(UIButton *)sender {
    
    self.cancelBlock(nil);
}



@end
