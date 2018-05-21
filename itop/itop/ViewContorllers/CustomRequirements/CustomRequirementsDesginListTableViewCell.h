//
//  CustomRequirementsDesginListTableViewCell.h
//  itop
//
//  Created by huangli on 2018/4/23.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectCooperationDesginer)(id obj); //选择的设计师

@interface CustomRequirementsDesginListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *disputesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *isBid;
@property (weak, nonatomic) IBOutlet UIButton *cooperationButton;
@property (copy, nonatomic) SelectCooperationDesginer selectCooperationDesginer;

-(void)setItmeOfModel:(CustomRequirementsDegsinList *)degsin;

@end
