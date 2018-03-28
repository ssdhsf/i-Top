//
//  PopularizeTableViewCell.m
//  itop
//
//  Created by huangli on 2018/3/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "PopularizeTableViewCell.h"

@implementation PopularizeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.orderButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_orderButton)];
    self.orderButton.layer.masksToBounds = YES;
    self.orderButton.layer.cornerRadius = 3;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setItmeOfPopularizeModel:(Popularize *)popularize{
    
    self.titleLabel.text = popularize.name;
    switch ([popularize.order_status integerValue]) {
        case OrderStatusTypeReady:
            self.stateLabel.text = @"待接单";
            [self.orderButton setTitle:@"接单" forState:UIControlStateNormal];
            break;
        case OrderStatusTypeGoOn:
            self.stateLabel.text = @"进行中";
            [self.orderButton setTitle:@"完成" forState:UIControlStateNormal];
            break;
        case OrderStatusTypefail:
            self.stateLabel.text = @"已取消";
            [self.orderButton setTitle:@"删除" forState:UIControlStateNormal];
            break;
        case OrderStatusTypeSucess:
            self.stateLabel.text = @"已完成";
            [self.orderButton setTitle:@"评价" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    self.browseLabel.text = popularize.order_no;
    self.priceLabel.text = popularize.price;
    self.forwardLabel.text = popularize.price;
    
}

@end
