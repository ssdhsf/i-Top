//
//  PopularizeTableViewCell.h
//  itop
//
//  Created by huangli on 2018/3/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OrderManagementBolck)(id parameter, id selectButton); //

@interface PopularizeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (weak, nonatomic) IBOutlet UILabel *browseLabel;
@property (weak, nonatomic) IBOutlet UILabel *forwardLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *refusedButton;
@property (copy, nonatomic)  OrderManagementBolck orderManagementBolck;

-(void)setItmeOfPopularizeModel:(Popularize *)popularize;

@end
