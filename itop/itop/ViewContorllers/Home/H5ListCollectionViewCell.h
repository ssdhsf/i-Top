//
//  H5ListCollectionViewCell.h
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface H5ListCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *h5ListImage;
@property (weak, nonatomic) IBOutlet UILabel *h5ListTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *h5ListMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleLable;

- (void)setItmeOfModel:(H5List*)h5Model;
- (void)setH5LietItmeOfModel:(H5List*)h5Model;//热点H5
- (void)setMyWorkLietItmeOfModel:(H5List*)h5Model;//我的作品H5

//案例
- (void)setMyCaseListItmeOfModel:(EditCase*)editCase getCaseType:(GetCaseType)getCaseType;

@end
