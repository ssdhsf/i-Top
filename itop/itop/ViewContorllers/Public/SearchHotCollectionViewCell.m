//
//  SearchHotCollectionViewCell.m
//  itop
//
//  Created by huangli on 2018/3/29.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SearchHotCollectionViewCell.h"

@implementation SearchHotCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItmeOfModel:(H5List*)recommended{
    
    NSInteger goodLabelTextWidth = [[Global sharedSingleton]widthForString:recommended.praise_count fontSize:11 andHeight:15];
    NSInteger browseLabelTextWidth = [[Global sharedSingleton]widthForString:recommended.browse_count fontSize:11 andHeight:15];
    NSInteger commentsLabelTextWidth = [[Global sharedSingleton]widthForString:recommended.comment_count fontSize:11 andHeight:15];
    
    NSInteger oringinY = CGRectGetMaxY(self.contentView.frame)-28;
    self.browseIcon.frame = CGRectMake(20, oringinY, 19, 14);
    self.browseLabel.frame = CGRectMake(CGRectGetMaxX(self.browseIcon.frame)+10, oringinY, browseLabelTextWidth+5, 15);
    
    self.goodIcon.frame = CGRectMake(CGRectGetMaxX(self.browseLabel.frame)+10, oringinY, 14, 13);
    self.goodLabel.frame = CGRectMake(CGRectGetMaxX(self.goodIcon.frame)+10, oringinY, goodLabelTextWidth+5, 15);
    
    self.commentsIcon.frame = CGRectMake(CGRectGetMaxX(self.goodLabel.frame)+10, oringinY, 14, 13);
    self.commentsLabel.frame = CGRectMake(CGRectGetMaxX(self.commentsIcon.frame)+10,oringinY, commentsLabelTextWidth+5, 15);
    
    self.goodLabel.text = recommended.praise_count;
    self.browseLabel.text = recommended.browse_count;
    self.hotTitleLabel.text = recommended.title;
    self.commentsLabel.text = recommended.comment_count;
    [self.hotImage sd_setImageWithURL:[NSURL URLWithString:recommended.cover_img] placeholderImage:nil];
    
    [self.hotImage sd_setImageWithURL:[NSURL URLWithString:recommended.cover_img] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"%f--%f",self.hotImage.image.size.width,self.hotImage.image.size.height);
    }];    
    NSString *time = [[Global sharedSingleton]timeFormatTotimeStringFormatWithtime:recommended.create_datetime willPattern:TIME_PATTERN_second didPattern:TIME_PATTERN_day];
    self.timeLabel.text = time;
    self.hotImage.clipsToBounds = YES;
    self.hotImage.contentMode = UIViewContentModeScaleAspectFill;
    
}


@end
