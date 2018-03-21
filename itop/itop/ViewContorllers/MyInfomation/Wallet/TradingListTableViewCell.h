//
//  TradingListTableViewCell.h
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradingListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tradingTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradingTime;
@property (weak, nonatomic) IBOutlet UILabel *channelLabel;

- (void)setItmeOfTradingListModel:(TradingList*)tradingList;
- (void)setItmeOfEarningListModel:(EarningList*)earningList;


@end
