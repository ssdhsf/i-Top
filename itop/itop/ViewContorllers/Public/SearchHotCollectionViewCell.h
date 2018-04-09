//
//  SearchHotCollectionViewCell.h
//  itop
//
//  Created by huangli on 2018/3/29.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHotCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *hotTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hotImage;
@property (weak, nonatomic) IBOutlet UILabel *browseLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *browseIcon;
@property (weak, nonatomic) IBOutlet UIImageView *goodIcon;
@property (weak, nonatomic) IBOutlet UIImageView *commentsIcon;

- (void)setItmeOfModel:(H5List*)recommended;

@end
