//
//  SetupHomeTableViewCell.m
//  itop
//
//  Created by huangli on 2018/3/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SetupHomeTableViewCell.h"

@implementation SetupHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItmeOfModel:(MyInfomation*)myInfo{
    
    self.titleLabel.text = myInfo.myInfoTitle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
