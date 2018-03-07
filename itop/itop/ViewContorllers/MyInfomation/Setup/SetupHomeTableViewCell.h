//
//  SetupHomeTableViewCell.h
//  itop
//
//  Created by huangli on 2018/3/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetupHomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (void)setItmeOfModel:(MyInfomation*)myInfo;

@end
