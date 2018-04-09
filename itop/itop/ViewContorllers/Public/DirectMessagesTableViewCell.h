//
//  DirectMessagesTableViewCell.h
//  itop
//
//  Created by huangli on 2018/3/28.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirectMessagesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *otherUserImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thisUserImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bubbleView;

-(void)setItmeOfModel:(DirectMessages *)messages;

@end
