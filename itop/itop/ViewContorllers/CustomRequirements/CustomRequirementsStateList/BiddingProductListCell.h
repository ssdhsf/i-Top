//
//  BiddingProductListCell.h
//  itop
//
//  Created by huangli on 2018/4/27.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BiddingProductListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

-(void)setItmeOfModel:(BiddingProduct *)biddingProduct;

@end
