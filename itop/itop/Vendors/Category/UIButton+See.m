//
//  UIButton+see.m
//  itop
//
//  Created by huangli on 2018/4/4.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "UIButton+see.h"

@implementation UIButton (See)

-(void)seePassword{
    
    if (self.selected) {
        
        [self setImage:[UIImage imageNamed:@"icon_see"] forState:UIControlStateNormal];
        
    } else {
        [self setImage:[UIImage imageNamed:@"icon_unsee"] forState:UIControlStateNormal];
    }
}

@end
