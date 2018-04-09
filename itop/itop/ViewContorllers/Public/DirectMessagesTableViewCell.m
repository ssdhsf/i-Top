//
//  DirectMessagesTableViewCell.m
//  itop
//
//  Created by huangli on 2018/3/28.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DirectMessagesTableViewCell.h"

@implementation DirectMessagesTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.otherUserImageView.layer.cornerRadius = self.otherUserImageView.width/2;
    self.otherUserImageView.layer.masksToBounds = YES;
    
    self.thisUserImageView.layer.cornerRadius = self.thisUserImageView.width/2;
    self.thisUserImageView.layer.masksToBounds = YES;
}

-(void)setItmeOfModel:(DirectMessages *)messages{
   
    NSLog(@"%@",[[UserManager shareUserManager]crrentUserId]);
    
    CGFloat messageLong = [[Global sharedSingleton]widthForString:messages.message fontSize:15 andHeight:21];
    
    CGFloat messageHeigth = 21;
    if (messageLong > ScreenWidth-170) {
        
         messageLong = ScreenWidth-170;
         messageHeigth = [Global heightWithString:messages.message width:ScreenWidth-170 fontSize:15];
    }

    if ([messages.sender_user_id isEqualToNumber:[[UserManager shareUserManager]crrentUserId]]) {
        
        UIImage * backImage;
        
        backImage = [UIImage imageNamed:@"messageblue"];
        backImage = [backImage resizableImageWithCapInsets:UIEdgeInsetsMake(35, 22, 10, 10)];
        _bubbleView.image = backImage;
        _bubbleView.frame = CGRectMake(ScreenWidth-90-messageLong, 10, messageLong+30,messageHeigth+20);
        NSLog(@"%f",ScreenWidth);
        self.messageLabel.frame = CGRectMake(CGRectGetMinX(_bubbleView.frame) +10, CGRectGetMinY(_bubbleView.frame)+10, CGRectGetWidth(_bubbleView.frame)-25, CGRectGetHeight(_bubbleView.frame)-20);
        self.otherUserImageView.hidden = YES;
        self.thisUserImageView.hidden = NO;
        [self.thisUserImageView sd_setImageWithURL:[NSURL URLWithString:messages.sender_head_img] placeholderImage:PlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        self.messageLabel.textColor = UIColorFromRGB(0xffffff);
    } else {
        
        UIImage * backImage;
    
        backImage = [UIImage imageNamed:@"messagegrey"];
        backImage = [backImage resizableImageWithCapInsets:UIEdgeInsetsMake(35, 22, 10, 10)];
        _bubbleView.image = backImage;
        _bubbleView.frame = CGRectMake(CGRectGetMaxX(self.otherUserImageView.frame)+10, 10, messageLong+30,messageHeigth+20);

        self.messageLabel.frame = CGRectMake(CGRectGetMinX(_bubbleView.frame) +20, CGRectGetMinY(_bubbleView.frame)+10, CGRectGetWidth(_bubbleView.frame)-25, CGRectGetHeight(_bubbleView.frame)-20);
        self.thisUserImageView.hidden = YES;
        self.otherUserImageView.hidden = NO;
//        self.messageLabel.backgroundColor = UIColorFromRGB(0xf5f7f9);
        [self.otherUserImageView sd_setImageWithURL:[NSURL URLWithString:messages.sender_head_img] placeholderImage:PlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        self.messageLabel.textColor = UIColorFromRGB(0x434a5c);
    }
    self.messageLabel.backgroundColor = [UIColor clearColor];
    self.messageLabel.text = messages.message;
//    self.messageLabel.textAlignment = NSTextAlignmentCenter;
}

@end
