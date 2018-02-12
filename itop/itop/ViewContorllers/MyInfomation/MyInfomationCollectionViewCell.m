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
}

@end
