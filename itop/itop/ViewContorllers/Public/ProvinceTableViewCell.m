//
//  ProvinceTableViewCell.m
//  itop
//
//  Created by huangli on 2018/4/1.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ProvinceTableViewCell.h"

@implementation ProvinceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setItmeOfModel:(City*)province{
    
    self.cityLabel.text = province.name;
}

@end
