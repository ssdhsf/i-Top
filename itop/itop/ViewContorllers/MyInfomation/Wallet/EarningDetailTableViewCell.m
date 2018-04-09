//
//  EarningDetailTableViewCell.m
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "EarningDetailTableViewCell.h"

@implementation EarningDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItmeOfEarningDetailModel:(Infomation*)earningList indexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        self.comtentLabel.textColor = UIColorFromRGB(0xeb6ea5);
        self.comtentLabel.font = [UIFont systemFontOfSize:30];
        
    }else{
        
        self.comtentLabel.textColor = UIColorFromRGB(0x7a8296);
        self.comtentLabel.font = [UIFont systemFontOfSize:15];
    }
    self.titleLabel.text = earningList.title;
    self.comtentLabel.text = earningList.content;
}

@end
