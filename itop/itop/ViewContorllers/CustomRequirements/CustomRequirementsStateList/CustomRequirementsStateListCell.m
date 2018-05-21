//
//  CustomRequirementsStateListCell.m
//  itop
//
//  Created by huangli on 2018/4/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomRequirementsStateListCell.h"
#import "CustomRequirementsStore.h"

@implementation CustomRequirementsStateListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItmeOfModel:(CustomRequirementsList *)demandList demantType:(DemandType)demantType{
    
    self.titleLabel.text = demandList.title;
    
    if ([[UserManager shareUserManager] crrentUserType] == UserTypeDesigner && demantType == DemandTypeBidding) {
       
        self.statelabel.text = [[CustomRequirementsStore shearCustomRequirementsStore]showStateWithState:[demandList.designer_status integerValue]];
    } else {
        
         self.statelabel.text = [[CustomRequirementsStore shearCustomRequirementsStore]showStateWithState:[demandList.demand_status integerValue]];
    }
   

    NSString *date = [[Global sharedSingleton] timeFormatTotimeStringFormatWithtime:demandList.create_datetime willPattern:TIME_PATTERN_second didPattern:TIME_PATTERN_day];
    NSString *nickName = demandList.enterprise_nickname ? demandList.enterprise_nickname : @"姓名";
    NSString *price = demandList.price ? demandList.price : @"-";
    self.detailLabel.text = [NSString stringWithFormat:@"%@  预算 ¥%@  截稿时间 %@",nickName ,price, date];
    if (_tagList == nil) {
    
        CustomRequirementsType customRequirementsType ;
        
        if ([[UserManager shareUserManager] crrentUserType] == UserTypeDesigner && demantType == DemandTypeBidding) {
            
            [self addkeywordsViewWithkeywords:[demandList.designer_status integerValue] demantType:demantType] ;

        } else {
            [self addkeywordsViewWithkeywords:[demandList.demand_status integerValue] demantType:demantType] ;
        }
    }
}

-(void)addkeywordsViewWithkeywords:(CustomRequirementsType )customRequirementsType demantType:(DemandType)demantType{
    
    // 高度可以设置为0，会自动跟随标题计算
    self.tagList = [[YZTagList alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_detailLabel.frame), ScreenWidth-20, 0)];
    _tagList.tag = 1;
    _tagList.backgroundColor = [UIColor whiteColor];
    _tagList.tagCornerRadius = 3;
    _tagList.borderColor = UIColorFromRGB(0xc6c8ce);
    _tagList.borderWidth = 0;
    _tagList.tagFont = [UIFont systemFontOfSize:12] ;
    // 设置标签背景色
    _tagList.tagColor = [UIColor blackColor];
    [_tagList addOperationDemandListTag: [[CustomRequirementsStore shearCustomRequirementsStore]operationStateWithState:customRequirementsType demandType:demantType] action:@selector(operationDemandListTagTag:) ];
    _tagList.operationDemandListTagBlock = ^(NSString *buttonTitle){
        
        if (_operationDemandListTagBlock) {
            _operationDemandListTagBlock(buttonTitle, self);
        }
    };
    [self.contentView addSubview:_tagList];
}


@end
