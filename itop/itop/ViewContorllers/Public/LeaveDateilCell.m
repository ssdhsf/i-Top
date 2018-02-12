//
//  LeaveDateilCell.m
//  itop
//
//  Created by huangli on 2018/2/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "LeaveDateilCell.h"

@implementation LeaveDateilCell


-(void)setItmeOfModel:(LeaveDetail *)leave{
    
    self.titleLabel.text = leave.title;
    self.contentLabel.text = leave.content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
