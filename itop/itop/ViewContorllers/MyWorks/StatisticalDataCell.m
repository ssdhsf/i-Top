//
//  StatisticalDataCell.m
//  itop
//
//  Created by huangli on 2018/1/22.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "StatisticalDataCell.h"

@implementation StatisticalDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItmeOfModel:(StatisticalData*)statisticalData{
    
    self.titleLabel.text = statisticalData.title;
    self.contentLabel.text = statisticalData.content;
}

@end
