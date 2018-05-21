//
//  DisputesTableViewCell.m
//  itop
//
//  Created by huangli on 2018/5/2.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DisputesTableViewCell.h"

@implementation DisputesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItmeOfModel:(Disputes *)disputes{
    
    CGFloat passableHeight = [Global heightWithString:disputes.question width:ScreenWidth-100 fontSize:15];
    CGFloat remarkleHeight = [Global heightWithString:disputes.remark width:ScreenWidth-100 fontSize:15];
    self.passableLabel.frame = CGRectMake(80, 11, ScreenWidth-100, passableHeight);
    _image.frame = CGRectMake(80, CGRectGetMaxY(_passableLabel.frame)+20, 80, 80);
    _imageTitleLabel.frame = CGRectMake(20, 0, 42, 21);
    _imageTitleLabel.centerY = _image.centerY;
    
    self.noteTitleLabel.frame = CGRectMake(20, CGRectGetMaxY(_passableLabel.frame) +120, 42, 21);
    self.noteContentLabel.frame = CGRectMake(80, CGRectGetMaxY(_passableLabel.frame)+120, ScreenWidth-100, remarkleHeight);

    self.passableLabel.text = disputes.question;
    [self.image sd_setImageWithURL:[NSURL URLWithString:disputes.img] placeholderImage:H5PlaceholderImage];
    self.noteContentLabel.text = disputes.remark;
}

@end
