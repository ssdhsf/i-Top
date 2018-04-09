//
//  LeaveTableViewCell.h
//  itop
//
//  Created by huangli on 2018/2/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeaveTableViewCell;

typedef void (^SelectDeleteButtonBlock)(LeaveTableViewCell *selectIndex);

@interface LeaveTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *selectStateView;
@property (nonatomic ,copy)SelectDeleteButtonBlock deleteIndex;

-(void)setItmeOfModel:(Leave *)leave animation:(BOOL)animation;

@end
