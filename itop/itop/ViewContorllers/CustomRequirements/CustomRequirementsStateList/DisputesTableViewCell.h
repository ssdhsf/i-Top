//
//  DisputesTableViewCell.h
//  itop
//
//  Created by huangli on 2018/5/2.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisputesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *passableLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *noteTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *imageTitleLabel;

-(void)setItmeOfModel:(Disputes *)disputes;

@end
