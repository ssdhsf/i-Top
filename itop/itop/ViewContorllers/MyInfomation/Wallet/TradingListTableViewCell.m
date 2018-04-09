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
- (void)setItmeOfTradingListModel:(TradingList*)tradingList{
    
    
//    self.tradingTypeLabel.text =  @"转发";
    self.tradingCountLabel.text = [NSString stringWithFormat:@"-%@",tradingList.price];
    self.tradingCountLabel.textColor = [UIColor blackColor];
    
    self.tradingTime.text = tradingList.create_datetime;
    self.channelLabel.text = @"Apple内购";
    switch ([tradingList.pay_scene integerValue]) {
        case 0:
            self.tradingTypeLabel.text = @"未知";
            break;
        case 1:
            self.tradingTypeLabel.text = @"文章支付";
            break;
        case 2:
            self.tradingTypeLabel.text = @"作品支付";
            break;
        case 3:
            self.tradingTypeLabel.text = @"充值";
            self.tradingCountLabel.text = [NSString stringWithFormat:@"+%@",tradingList.price];
            self.tradingCountLabel.textColor = UIColorFromRGB(0xeb6ea5);
            break;
        case 4:
            self.tradingTypeLabel.text = @"企业服务";
            break;
            
        default:
            break;
    }
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
