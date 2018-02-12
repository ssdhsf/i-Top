//
//  HotTableViewCell.h
//  itop
//
//  Created by huangli on 2018/1/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotH5ItmeViewController;
@class RecommendedViewController;

@interface HotTableViewCell : UITableViewCell

-(void)setItmeWithItmeTitle:(NSString *)itmeTitle indexPath:(NSIndexPath *)indexPath;

@property (nonatomic ,strong)HotH5ItmeViewController *h5Vc;
@property (nonatomic ,strong)RecommendedViewController *RecommendedVc;

@end
