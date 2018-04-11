//
//  MyHotH5ItmeViewCell.m
//  itop
//
//  Created by huangli on 2018/3/15.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MyHotH5ItmeViewCell.h"

@implementation MyHotH5ItmeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMyHotListItmeOfModel:(H5List*)h5Model{
    
    self.hotImage.frame = CGRectMake(20/2, 5, self.frame.size.width-20, (self.frame.size.width-20)*1.69);
    [self.hotImage sd_setImageWithURL:[NSURL URLWithString:h5Model.cover_img] placeholderImage:H5PlaceholderImage];
    self.hotTitleLabel.text = h5Model.title;
    self.hotTitleLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.hotImage.frame)+7, CGRectGetMaxX(self.hotImage.frame),16);
    
    if ([h5Model.check_status integerValue] == CheckStatusTypeUnPass) {
        
        self.stateLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.hotTitleLabel.frame)+9, 65,16);
        self.stateLabel.backgroundColor = UIColorFromRGB(0xffcde3);

    } else {
        
        self.stateLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.hotTitleLabel.frame)+9, 45,16);
        self.stateLabel.backgroundColor = UIColorFromRGB(0xcbedfb);
    }
    
    
    switch ([h5Model.check_status integerValue]) {
        case 0:
            self.stateLabel.text = @" 未审核";
            [self hiddenViewsWithState:YES];
            break;
        case 1:
            self.stateLabel.text = @" 审核中";
            [self hiddenViewsWithState:YES];
            break;

        case 2:
            self.stateLabel.text = @" 已通过";
            [self hiddenViewsWithState:NO];
            break;

        case 3:
            self.stateLabel.text = @" 不通过";
            [self hiddenViewsWithState:YES];
            break;

        default:
            break;
    }
    self.stateLabel.layer.cornerRadius = 3;
    self.stateLabel.layer.masksToBounds = YES;
    
    self.stateLabel.textColor  = UIColorFromRGB(0xffffff);
    self.segmenView.frame = CGRectMake(CGRectGetMinX(self.hotImage.frame), CGRectGetMaxY(self.hotImage.frame)-18, CGRectGetWidth(self.hotImage.frame), 18);
    
    self.browseIcon.frame =  CGRectMake(CGRectGetMinX(self.hotImage.frame), CGRectGetMaxY(self.hotImage.frame)-16, 19, 13);
    self.browseLabel.frame =  CGRectMake(CGRectGetMaxX(self.browseIcon.frame), CGRectGetMaxY(self.hotImage.frame)-16, CGRectGetWidth(self.hotImage.frame)/2-19, 15);
    
    self.commentsIcon.frame =  CGRectMake(CGRectGetMaxX(self.browseLabel.frame), CGRectGetMaxY(self.hotImage.frame)-16, 14, 13);
    self.commentsLabel.frame =  CGRectMake(CGRectGetMaxX(self.commentsIcon.frame), CGRectGetMaxY(self.hotImage.frame)-16, CGRectGetWidth(self.hotImage.frame)/2-14, 15);
}

-(void)hiddenViewsWithState:(BOOL)animation{
    
    self.browseIcon.hidden = animation;
    self.browseLabel.hidden = animation;
    self.commentsIcon.hidden = animation;
    self.commentsLabel.hidden = animation;
}

@end
