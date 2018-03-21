//
//  EarningDetailTableViewCell.h
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EarningDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *comtentLabel;

- (void)setItmeOfEarningDetailModel:(Infomation*)earningList indexPath:(NSIndexPath *)indexPath;

@end
