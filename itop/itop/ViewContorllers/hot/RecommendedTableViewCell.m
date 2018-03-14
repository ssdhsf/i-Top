//
//  RecommendedTableViewCell.m
//  itop
//
//  Created by huangli on 2018/1/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "RecommendedTableViewCell.h"

@implementation RecommendedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItmeOfModel:(H5List*)recommended{
    
    self.timeLabel.text = recommended.nickname;
    self.goodLabel.text = recommended.praise_count;
    self.browseLabel.text = recommended.browse_count;
    self.hotTitleLabel.text = recommended.title;
    self.commentsLabel.text = recommended.comment_count;
    
    UIImageView *view = [UIImageView new];
    [self.hotImage sd_setImageWithURL:[NSURL URLWithString:recommended.cover_img] placeholderImage:nil];
//    self.hotImage.image = view.image;
//    self.hotImage.image = [UIImage imageNamed:recommended.cover_img];
}

@end
