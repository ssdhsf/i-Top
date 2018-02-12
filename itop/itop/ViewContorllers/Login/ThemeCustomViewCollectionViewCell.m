//
//  ThemeCustomViewCollectionViewCell.m
//  itop
//
//  Created by huangli on 2018/1/19.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ThemeCustomViewCollectionViewCell.h"

@implementation ThemeCustomViewCollectionViewCell

- (void)setItmeOfModel:(ThemeCustom*)themeCustom{
    
    self.imageView.image = [UIImage imageNamed:themeCustom.imageUrl];
    self.title.text = themeCustom.title;
}

@end
