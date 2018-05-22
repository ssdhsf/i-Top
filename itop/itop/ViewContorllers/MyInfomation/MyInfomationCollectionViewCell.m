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
    
    if ([myInfo.myInfoTitle isEqualToString:@"通知"] && [[UserManager shareUserManager] crrentMessageCount] != nil) {
        JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:self.itemImage alignment:JSBadgeViewAlignmentTopRight];
            badgeView.badgeTextFont = [UIFont systemFontOfSize:9];
            badgeView.badgeText = [NSString stringWithFormat:@"%@",[[UserManager shareUserManager] crrentMessageCount]] ;
            badgeView.size = CGSizeMake(10, 10);
        badgeView.badgeBackgroundColor = UIColorFromRGB(0xf9a5ee);
    }
    if ([myInfo.myInfoTitle isEqualToString:@"关注"] && [[UserManager shareUserManager] crrentFollowCount] != nil ) {
        JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:self.itemImage alignment:JSBadgeViewAlignmentTopRight];
        badgeView.badgeTextFont = [UIFont systemFontOfSize:9];
        badgeView.badgeText = [NSString stringWithFormat:@"%@",[[UserManager shareUserManager] crrentFollowCount]] ;
        badgeView.size = CGSizeMake(10, 10);
        badgeView.badgeBackgroundColor = UIColorFromRGB(0xf9a5ee);
    }
    
    if ([myInfo.myInfoTitle isEqualToString:@"评论"]) {
        
        JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:self.itemTitle alignment:JSBadgeViewAlignmentTopRight];
        badgeView.badgeTextFont = [UIFont systemFontOfSize:9];
        badgeView.badgeText = [NSString stringWithFormat:@"%@",[[UserManager shareUserManager] crrentCommentCount]] ;
        badgeView.size = CGSizeMake(10, 10);
        badgeView.badgeBackgroundColor = UIColorFromRGB(0xf9a5ee);
    }
}

@end
