//
//  CustomRequirementsStoreCell.m
//  itop
//
//  Created by huangli on 2018/4/19.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomRequirementsStoreCell.h"
#import "CompanySigningStore.h"

@implementation CustomRequirementsStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItmeOfModel:(CustomRequirements*)customRequirements{
    
    NSInteger titleHeigh = [Global heightWithString:customRequirements.title width:ScreenWidth - 130 fontSize:15];
    self.titleLabel.frame = CGRectMake(110, 30, ScreenWidth-130, titleHeigh + 10);
   
    self.priceLabel.frame = CGRectMake(110, CGRectGetMaxY(self.titleLabel.frame)+5, ScreenWidth-130, 21);
    
    NSInteger personWidth = [[Global sharedSingleton]widthForString:[NSString stringWithFormat:@"%@人投标",customRequirements.designer_count] fontSize:12 andHeight:21];
    self.personCountLabel.frame = CGRectMake(CGRectGetMinX(self.priceLabel.frame)+5, CGRectGetMinY(self.nameLabel.frame), personWidth+5, 21);

    NSInteger cityWidth = [[Global sharedSingleton]widthForString:[NSString stringWithFormat:@"%@",customRequirements.city] fontSize:12 andHeight:21];
    self.locationIcon.frame = CGRectMake(CGRectGetMaxX(self.personCountLabel.frame)+20, CGRectGetMinY(self.nameLabel.frame)+4, 10, 12);
    self.locationLabel.frame = CGRectMake(CGRectGetMaxX(self.locationIcon.frame)+5, CGRectGetMinY(self.nameLabel.frame), cityWidth+5, 21);
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:customRequirements.head_img] placeholderImage:PlaceholderImage options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    self.headImage.layer.cornerRadius = self.headImage.height/2;
    self.headImage.layer.masksToBounds = YES;
    
    self.nameLabel.text = customRequirements.nickname;
    self.titleLabel.text = customRequirements.title;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",customRequirements.price];
    self.personCountLabel.text = [NSString stringWithFormat:@"%@人投标",customRequirements.designer_count];
    
    Province *province = [[CompanySigningStore shearCompanySigningStore]cityWithCityCode:customRequirements.city provinceCode:customRequirements.province];
    self.locationLabel.text = province.address;

    [self.requirementButton.layer insertSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_requirementButton) atIndex:0];
    self.requirementButton.tag = _buttonTag;
    self.requirementButton.layer.cornerRadius = 2;
    self.requirementButton.layer.masksToBounds = YES;
}

@end
