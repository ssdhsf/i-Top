//
//  MessageTableViewCell.m
//  itop
//
//  Created by huangli on 2018/3/11.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setItmeOfModel:(UserMessege *)messege{
   
    self.iconImage.layer.cornerRadius = self.iconImage.width/2;
    self.iconImage.layer.masksToBounds = YES;
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:messege.head_img] placeholderImage:PlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    self.nameLabel.text = messege.nickname;
    self.dateLabel.text = [[Global sharedSingleton]timeFormatTotimeStringFormatWithtime:messege.create_datetime willPattern:TIME_PATTERN_second didPattern:TIME_PATTERN_day];
    self.instructionsLabel.text = messege.message;
}

@end
