//
//  BiddingProductListCell.m
//  itop
//
//  Created by huangli on 2018/4/27.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BiddingProductListCell.h"

@implementation BiddingProductListCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [_deleteButton .layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_deleteButton)];
    _deleteButton.layer.cornerRadius = 3;
    _deleteButton.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItmeOfModel:(BiddingProduct *)biddingProduct{
    
    self.titleLabel.text = biddingProduct.name;
    self.timeLabel.text = [[Global sharedSingleton]timeFormatTotimeStringFormatWithtime:biddingProduct.create_datetime willPattern:TIME_PATTERN_second didPattern:TIME_PATTERN_day];
}

- (IBAction)delete:(UIButton *)sender {
    
}

@end
