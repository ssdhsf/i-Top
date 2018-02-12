//
//  HomeCollectionViewCell.m
//  itop
//
//  Created by huangli on 2018/1/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (void)setItmeOfModel:(TagList*)tag{
    
//    self.homeImage.image = [UIImage imageNamed:tag.icon];
    
    [self.homeImage sd_setImageWithURL:[NSURL URLWithString:tag.icon] placeholderImage:[UIImage imageNamed:@"活动推广"] options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGFloat proportion = self.homeImage.image.size.height/self.homeImage.image.size.width;
        
        if ((ScreenWidth/3-102) < 22) {
            self.homeImage.frame = CGRectMake(self.homeImage.frame.origin.x, self.homeImage.frame.origin.y, self.homeImage.image.size.width, self.homeImage.image.size.height);
        } else {
            
            NSLog(@"%f====%f",ScreenWidth/3-102,(ScreenWidth/3-102)*proportion);
            self.homeImage.frame = CGRectMake(self.homeImage.frame.origin.x, self.homeImage.frame.origin.y, ScreenWidth/3-102, (ScreenWidth/3-102)*proportion);
        }
        
    }];
//    NSLog(@"%f---%f",self.homeImage.frame.origin.x,self.homeImage.frame.origin.y);
//    NSLog(@"%f",ScreenWidth/3-102);
    self.homeTitle.text = tag.name;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
//    self.homeImage = [[UIImageView alloc]initWithFrame: CGRectMake(self.homeImage.frame.origin.x, self.homeImage.frame.origin.y, self.homeImage.image.size.width, self.homeImage.image.size.height)];
    
//    if ((ScreenWidth/3-102) < 22) {
//        self.homeImage.frame = CGRectMake(self.homeImage.frame.origin.x, self.homeImage.frame.origin.y, self.homeImage.image.size.width, self.homeImage.image.size.height);
//    } else {
//        
//        NSLog(@"%f====%f",ScreenWidth/3-102,(ScreenWidth/3-102)*proportion);
//        self.homeImage.frame = CGRectMake(self.homeImage.frame.origin.x, self.homeImage.frame.origin.y, ScreenWidth/3-102, (ScreenWidth/3-102)*proportion);
//    }

//    NSLog(@"ew");
}

@end
