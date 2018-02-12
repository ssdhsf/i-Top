//
//  HomeCollectionViewCell.h
//  itop
//
//  Created by huangli on 2018/1/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *homeTitle;
@property (weak, nonatomic) IBOutlet UIImageView *homeImage;

- (void)setItmeOfModel:(TagList*)tag;

@end
