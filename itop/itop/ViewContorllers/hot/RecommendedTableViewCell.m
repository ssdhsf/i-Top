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

- (void)setItmeOfModel:(H5List*)recommended getArticleListType:(GetArticleListType)getArticleListType{
    
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
    
    [self setupStateLableWithGetArticleListType:getArticleListType recommended:recommended];
    self.hotImage.clipsToBounds = YES;
    self.hotImage.contentMode = UIViewContentModeScaleAspectFill;

}

-(void)setupStateLableWithGetArticleListType:(GetArticleListType)getArticleListType recommended:(H5List *)recommended{
    
    NSString *time = [[Global sharedSingleton]timeFormatTotimeStringFormatWithtime:recommended.create_datetime willPattern:TIME_PATTERN_second didPattern:TIME_PATTERN_day];
    NSInteger timeLabelTextWidth = [[Global sharedSingleton]widthForString:time fontSize:11 andHeight:15];

     NSInteger oringinY = CGRectGetMaxY(self.contentView.frame)-28;
    if (getArticleListType == GetArticleListTypeHot) {
        
        NSInteger timeLabelOriginX = CGRectGetMaxX(self.contentView.frame)-20-timeLabelTextWidth-5;
        self.timeLabel.frame = CGRectMake(timeLabelOriginX, oringinY, timeLabelTextWidth+5, 15);
        self.stateLabel.hidden = YES;
        
    } else {
        
        NSInteger stateLabelOriginX ;
        if ([recommended.check_status integerValue] == 3) {
            
            stateLabelOriginX = CGRectGetMaxX(self.contentView.frame)-85;
            self.stateLabel.frame = CGRectMake(stateLabelOriginX, oringinY, 65, 15);
            self.stateLabel.backgroundColor = UIColorFromRGB(0xffcde3);
        } else {
            
            stateLabelOriginX = CGRectGetMaxX(self.contentView.frame)-70;
            self.stateLabel.frame = CGRectMake(stateLabelOriginX, oringinY, 40, 15);
            self.stateLabel.backgroundColor = UIColorFromRGB(0xcbedfb);
        }
        
        NSInteger timeLabelOriginX = CGRectGetMaxX(self.commentsLabel.frame)+10;
        self.timeLabel.frame = CGRectMake(timeLabelOriginX, oringinY, timeLabelTextWidth+5, 15);
        switch ([recommended.check_status integerValue]) {
            case 0:
                self.stateLabel.text = @"未审核";
                break;
            case 1:
                self.stateLabel.text = @"审核中";
                break;
            case 2:
                self.stateLabel.text = @"通过";
                break;
            case 3:
                self.stateLabel.text = @"审核不通过";
                break;
            default:
                break;
        }
        self.stateLabel.layer.masksToBounds = YES;
        self.stateLabel.layer.cornerRadius = 3;
        self.stateLabel.textColor = UIColorFromRGB(0xffffff);

    }
    self.timeLabel.text = time;
}

@end
