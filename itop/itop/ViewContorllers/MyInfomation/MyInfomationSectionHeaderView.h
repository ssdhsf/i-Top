//
//  MyInfomationSectionHeaderView.h
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CilkOnSectionHeaderViewBlock)();

@interface MyInfomationSectionHeaderView : UIView

@property (strong, nonatomic) UILabel *titleLbl;
@property (strong, nonatomic) UIImageView*iconImageView;

@property (nonatomic, copy)CilkOnSectionHeaderViewBlock sectionHeader;

-(void)initMyInfoSubViewsWithSection:(NSInteger)section;

@end
