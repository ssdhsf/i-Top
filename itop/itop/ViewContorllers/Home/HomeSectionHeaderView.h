//
//  HomeSectionHeaderView.h
//  itop
//
//  Created by huangli on 2018/2/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CilkOnSectionHeaderViewBlock)(NSInteger section);

@interface HomeSectionHeaderView : UIView

@property (strong, nonatomic) UILabel *titleLbl;

@property (nonatomic, copy)CilkOnSectionHeaderViewBlock sectionHeader;

-(void)initSubViewsWithSection:(NSInteger)section;

@end
