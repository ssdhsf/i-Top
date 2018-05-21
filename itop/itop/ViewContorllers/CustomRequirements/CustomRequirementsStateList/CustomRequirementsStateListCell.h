//
//  CustomRequirementsStateListCell.h
//  itop
//
//  Created by huangli on 2018/4/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomRequirementsStateListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *statelabel;
@property (weak, nonatomic) IBOutlet UIView *tempView;
@property (strong, nonatomic) YZTagList *tagList;

/**
 *  点击操作标签，执行Block
 */
@property (nonatomic, strong) void(^operationDemandListTagBlock)(id tag , id cell);

-(void)setItmeOfModel:(CustomRequirementsList *)demandList demantType:(DemandType)demantType;

@end
