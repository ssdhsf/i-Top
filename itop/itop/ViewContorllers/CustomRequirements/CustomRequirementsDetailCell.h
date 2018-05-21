//
//  CustomRequirementsDetailCell.h
//  itop
//
//  Created by huangli on 2018/4/20.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomRequirementsDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UIView *imageViewsuperView;

- (void)setItmeOfModel:(Infomation*)CustomRequirementsDetail;

@end
