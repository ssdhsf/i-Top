//
//  TradingListTableViewCell.m
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "TradingListTableViewCell.h"

@implementation TradingListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItmeOfEarningListModel:(EarningList*)earningList{
    
    self.tradingTypeLabel.text =  @"转发";
    self.tradingCountLabel.text = [NSString stringWithFormat:@"+%@",earningList.reward_price];
    self.tradingCountLabel.textColor = UIColorFromRGB(0xeb6ea5);
    
    self.tradingTime.text = earningList.create_datetime;
    switch ([earningList.reward_type integerValue]) {
        case 0:
            self.channelLabel.text = @"默认转发";
            break;
        case 1:
            self.channelLabel.text = @"微信转发";
            break;
        case 2:
            self.channelLabel.text = @"QQ转发";
            break;
        case 3:
            self.channelLabel.text = @"新浪微博转发";
            break;
            
        default:
            break;
    }
    
//    self.channelLabel.text = earningList.reward_type;
}

@end
