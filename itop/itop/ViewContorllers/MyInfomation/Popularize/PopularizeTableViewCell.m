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
    
    [self.refusedButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_refusedButton)];
    self.refusedButton.layer.masksToBounds = YES;
    self.refusedButton.layer.cornerRadius = 3;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setItmeOfPopularizeModel:(Popularize *)popularize{
    
    self.titleLabel.text = popularize.product_name;
    switch ([popularize.order_status integerValue]) {
        case OrderStatusTypeReady:
            self.stateLabel.text = @"待接单";
            [self.orderButton setTitle:@"接单" forState:UIControlStateNormal];
            [self.refusedButton setTitle:@"拒绝" forState:UIControlStateNormal];
            self.refusedButton.hidden = NO;
            break;
        case OrderStatusTypeGoOn:
            self.stateLabel.text = @"进行中";
            [self.orderButton setTitle:@"完成" forState:UIControlStateNormal];
            self.refusedButton.hidden = YES;
            break;
        case OrderStatusTypefail:
            self.stateLabel.text = @"已取消";
            [self.orderButton setTitle:@"删除" forState:UIControlStateNormal];
            self.refusedButton.hidden = YES;
            break;
        case OrderStatusTypeSucess:
            self.stateLabel.text = @"已完成";
            [self.orderButton setTitle:@"评价" forState:UIControlStateNormal];
            self.refusedButton.hidden = YES;
            break;
        default:
            break;
    }
    
    NSInteger browseLabelTextWidth = [[Global sharedSingleton]widthForString:[NSString stringWithFormat:@"浏览  %@",[Global stringIsNullWithString:popularize.browse_count]? @"0" : popularize.browse_count] fontSize:12 andHeight:15];
    NSInteger priceLabelTextWidth = [[Global sharedSingleton]widthForString:[NSString stringWithFormat:@"浏览  %@",[Global stringIsNullWithString:popularize.price]? @"0" :popularize.price] fontSize:12 andHeight:15];
    NSInteger forwardLabelTextWidth = [[Global sharedSingleton]widthForString:[NSString stringWithFormat:@"转发  %@",[Global stringIsNullWithString:popularize.share_count]? @"0" : popularize.share_count] fontSize:12 andHeight:15];

    self.browseLabel.frame = CGRectMake(20, 39, browseLabelTextWidth+5, 16);
    self.forwardLabel.frame = CGRectMake(CGRectGetMaxX(self.browseLabel.frame)+10, 39, forwardLabelTextWidth+8, 16);
    self.priceLabel.frame = CGRectMake(CGRectGetMaxX(self.forwardLabel.frame)+10, 39, priceLabelTextWidth+8, 16);
    
    self.browseLabel.text = [NSString stringWithFormat:@"浏览  %@",[Global stringIsNullWithString:popularize.browse_count]? @"0" : popularize.browse_count];
    self.priceLabel.text = [NSString stringWithFormat:@"价格  %@",[Global stringIsNullWithString:popularize.price]? @"0" : popularize.price];
    self.forwardLabel.text = [NSString stringWithFormat:@"转发  %@",[Global stringIsNullWithString:popularize.share_count]? @"0" : popularize.share_count];
}


- (IBAction)orderManagement:(UIButton *)sender {
    
    _orderManagementBolck(self,sender);
    
}

@end
