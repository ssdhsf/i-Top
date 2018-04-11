//
//  LeaveDateilCell.h
//  itop
//
//  Created by huangli on 2018/2/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveDateilCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

-(void)setItmeOfModel:(Infomation *)leave;

@end
