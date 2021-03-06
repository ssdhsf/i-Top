//
//  CustomRequirementsDesginListTableViewCell.m
//  itop
//
//  Created by huangli on 2018/4/23.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomRequirementsDesginListTableViewCell.h"

@implementation CustomRequirementsDesginListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_cooperationButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_cooperationButton)];
    _cooperationButton.layer.cornerRadius = 3;
    _cooperationButton.layer.masksToBounds = YES;
    
    self.headImage.layer.cornerRadius = self.headImage.width / 2;
    self.headImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItmeOfModel:(CustomRequirementsDegsinList *)degsin{
    
    
    if ([degsin.success_bid isEqualToNumber:@1]) {
        
        _isBid.hidden = NO;
        _cooperationButton.hidden = YES;
    } else {
        
        _isBid.hidden = YES;
        _cooperationButton.hidden = NO;
    }
    self.nameLabel.text = degsin.nickname;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:degsin.head_img] placeholderImage:H5PlaceholderImage options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    self.nameLabel.text = degsin.nickname;
    self.orderLabel.text = [NSString stringWithFormat:@"订单详情  %@",degsin.demand_count] ;
    self.commentLabel.text = [NSString stringWithFormat:@"评   分  %@",degsin.score_average];
    self.disputesLabel.text = [NSString stringWithFormat:@"纠  纷  率  %@",degsin.dispute];
}

- (IBAction)selectCooperationDesginer:(UIButton *)sender {
    
    if(_selectCooperationDesginer){
        
        self.selectCooperationDesginer(self);
    }
}


@end
