//
//  TagView.m
//  itop
//
//  Created by huangli on 2018/2/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "TagView.h"

@implementation TagView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _iconImage = [[UIImageView alloc]init];
        [self addSubview: _iconImage];
        
        _tagTitle = [[UILabel alloc]init];
        [self addSubview:_tagTitle];
    }
    return self;
}

- (void)setItmeOfModel:(TagList*)tag tapTag:(NSInteger)tapTag{
    

    self.iconImage.tag = tapTag;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:tag.icon] placeholderImage:[UIImage imageNamed:@"活动推广"] options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGFloat proportion = self.iconImage.image.size.height/self.iconImage.image.size.width;
        
        NSLog(@"%f-%f---%f",self.frame.size.width,self.frame.size.height,self.frame.origin.x);
        if ((ScreenWidth/3-102) < 22) {
            
            self.iconImage.frame = CGRectMake((self.frame.size.width-self.iconImage.image.size.width)/2, 5, self.iconImage.image.size.width, self.iconImage.image.size.height);
            
            NSLog(@"%f====%f",self.iconImage.frame.origin.x,self.iconImage.frame.origin.y);

        } else {

            self.iconImage.frame = CGRectMake(self.frame.size.width-102+self.iconImage.image.size.width, 5, self.frame.size.width-102, (self.frame.size.width-102)*proportion);
            NSLog(@"%f====%f",self.iconImage.frame.origin.x,self.iconImage.frame.origin.y);
        }
        
        
        //        tap.numberOfTapsRequired = i;
//        [self.iconImage addGestureRecognizer:tap];

        self.tagTitle.frame = CGRectMake(5, CGRectGetMaxY(self.iconImage.frame) +5, self.frame.size.width-10, 19);
    }];
    
    self.tagTitle.font = [UIFont systemFontOfSize:12];
    self.tagTitle.text = tag.name;
    self.tagTitle.textAlignment = NSTextAlignmentCenter;
}




@end
