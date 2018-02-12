//
//  ThemeCustomViewCollectionViewCell.h
//  itop
//
//  Created by huangli on 2018/1/19.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeCustomViewCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;

- (void)setItmeOfModel:(ThemeCustom*)themeCustom;

@end
