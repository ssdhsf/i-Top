//
//  MyInfomationCollectionViewCell.m
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MyInfomationCollectionViewCell.h"

@implementation MyInfomationCollectionViewCell

- (void)setItmeOfModel:(MyInfomation*)myInfo{
    
    self.itemImage.image = [UIImage imageNamed:myInfo.myInfoImageUrl];
    self.itemTitle.text = myInfo.myInfoTitle;
    
    CGFloat titleWidth = [[Global sharedSingleton]widthForString:myInfo.myInfoTitle fontSize:15 andHeight:21];
    self.itemTitle.frame = CGRectMake(0, 70, titleWidth +5, 21);
    self.itemTitle.centerX = ScreenWidth/4/2;
   
    if ([myInfo.myInfoTitle isEqualToString:@"通知"] && [[UserManager shareUserManager] crrentMessageCount] != nil) {
         _badgeView.hidden = NO;
        [self setupBadgeViewWithCount:[[UserManager shareUserManager] crrentMessageCount]];

    }
    if ([myInfo.myInfoTitle isEqualToString:@"关注"] && [[UserManager shareUserManager] crrentFollowCount] != nil ) {
        
        _badgeView.hidden = NO;
         [self setupBadgeViewWithCount:[[UserManager shareUserManager] crrentFollowCount]];
    }else if ([myInfo.myInfoTitle isEqualToString:@"评论"] && [[UserManager shareUserManager] crrentCommentCount] != nil) {
        
        _badgeView.hidden = NO;
         [self setupBadgeViewWithCount:[[UserManager shareUserManager] crrentCommentCount]];

    } else {
        _badgeView.hidden = YES;
        
    }
}

-(void)setupBadgeViewWithCount:(NSNumber *)count{
    
    self.badgeView = [[JSBadgeView alloc] initWithParentView:self.itemTitle alignment:JSBadgeViewAlignmentTopRight];
    self.badgeView.badgeTextFont = [UIFont systemFontOfSize:9];
    self.badgeView.badgeText = [NSString stringWithFormat:@"%@",count] ;
    self.badgeView.size = CGSizeMake(10, 10);
    self.badgeView.badgeBackgroundColor = UIColorFromRGB(0xf9a5ee);
}

@end
