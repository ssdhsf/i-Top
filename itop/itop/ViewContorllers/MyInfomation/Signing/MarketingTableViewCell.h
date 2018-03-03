//
//  MarketingTableViewCell.h
//  itop
//
//  Created by huangli on 2018/2/28.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarketingTableViewCell;

typedef void(^InputConfigureBlock )(NSString *text ,MarketingTableViewCell *cell );

@interface MarketingTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *ContentTF;
@property (copy, nonatomic) InputConfigureBlock inputConfigureBlock;

-(void)setItmeOfModel:(Marketing *)info;

@end
