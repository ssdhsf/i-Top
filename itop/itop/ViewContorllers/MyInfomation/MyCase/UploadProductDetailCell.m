//
//  UploadProductDetailCell.m
//  itop
//
//  Created by huangli on 2018/5/8.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "UploadProductDetailCell.h"

@implementation UploadProductDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)showProductDedailItmeOfModel:(DemandEdit *)demandEdit{
    
    self.titleLabel.text = demandEdit.title;
    if (demandEdit.editType == EditTypeSelectImage) {
        
        self.coveImage.hidden = NO;
        self.contentLabel.hidden = YES;
        self.fuzhiButton.hidden = YES;
        
        [self.coveImage sd_setImageWithURL:[NSURL URLWithString:demandEdit.content] placeholderImage:H5PlaceholderImage];
    } else {
        
        self.coveImage.hidden = YES;
        self.contentLabel.hidden = NO;
        CGFloat contentHeight ;
        if ([demandEdit.title isEqualToString: @"作品链接"] || [demandEdit.title isEqualToString: @"网盘地址"]) {
            
            if ([Global stringIsNullWithString:demandEdit.content]) {
                
                self.fuzhiButton.hidden = YES;
            } else {
                self.fuzhiButton.hidden = NO;
                [self.fuzhiButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_fuzhiButton)];
                self.fuzhiButton.layer.cornerRadius = 3;
                self.fuzhiButton.layer.masksToBounds = YES;
            }
            contentHeight = [Global heightWithString:demandEdit.content width:ScreenWidth - 161 fontSize:15];
            self.contentLabel.frame = CGRectMake(101, 10, ScreenWidth - 161, contentHeight);
            
        } else {
            self.fuzhiButton.hidden = YES;
            contentHeight = [Global heightWithString:demandEdit.content width:ScreenWidth - 121 fontSize:15];
            self.contentLabel.frame = CGRectMake(101, 10, ScreenWidth - 121, contentHeight);
        }

        self.contentLabel.text = demandEdit.content;
    }
}

- (IBAction)fuzhi:(UIButton *)sender {
    
     [[Global sharedSingleton] copyTheLinkWithLinkUrl:self.contentLabel.text];
}

@end
