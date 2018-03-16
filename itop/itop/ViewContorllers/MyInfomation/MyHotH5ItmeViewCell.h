//
//  MyHotH5ItmeViewCell.h
//  itop
//
//  Created by huangli on 2018/3/15.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHotH5ItmeViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *hotTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hotImage;
@property (weak, nonatomic) IBOutlet UILabel *browseLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;

@property (weak, nonatomic) IBOutlet UIImageView *browseIcon;
@property (weak, nonatomic) IBOutlet UIImageView *commentsIcon;
@property (weak, nonatomic) IBOutlet UIView *segmenView;


- (void)setMyHotListItmeOfModel:(H5List*)h5Model;//我的热点

@end
