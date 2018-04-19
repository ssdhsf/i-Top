//
//  DesignerListCell.m
//  itop
//
//  Created by huangli on 2018/1/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DesignerListViewCollectionViewCell.h"

@implementation DesignerListViewCollectionViewCell

- (void)setItmeOfModel:(DesignerList*)designerList DesignerListType:(DesignerListType )designerListType index:(NSInteger)index{
    
    self.designerImage.frame = CGRectMake(47/2, 5,  self.frame.size.width-47, self.frame.size.width-47);
    self.designerNameLabel.frame = CGRectMake(5, CGRectGetMaxY(self.designerImage.frame)+10,self.frame.size.width-10, 16);
    self.designerProfessionalLabel.frame = CGRectMake(5, CGRectGetMaxY(self.designerNameLabel.frame)+4,self.frame.size.width-10, 28);
    
    if ([designerList.follow integerValue] == 0) {
        
        self.focusButton.frame = CGRectMake((self.frame.size.width/2-20), CGRectGetMaxY(self.designerProfessionalLabel.frame)+6,40, 16);
    } else {
        
        self.focusButton.frame = CGRectMake((self.frame.size.width/2-25), CGRectGetMaxY(self.designerProfessionalLabel.frame)+6,50, 16);
    }
    
    [self.designerImage sd_setImageWithURL:[NSURL URLWithString:designerList.head_img] placeholderImage:PlaceholderImage options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    self.designerImage.layer.cornerRadius =  self.designerImage.frame.size.height/2;
    
    self.designerImage.layer.masksToBounds = YES;
    
    self.designerNameLabel.text = designerList.nickname;

    [self.focusButton addTarget:self action:@selector(focus:) forControlEvents:UIControlEventTouchDown];
    [self.focusButton.layer insertSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_focusButton) atIndex:0];
    self.focusButton.tag = index;
    self.focusButton.layer.cornerRadius = 2;
    self.focusButton.layer.masksToBounds = YES;
    
    if (designerListType == DesignerListTypeFocus) {
       
        [self.focusButton setTitle:FOCUSSTATETITLE_FOCUS forState:UIControlStateNormal];
        
    
        switch ([designerList.user_type integerValue]) {
            case 0:
                self.designerProfessionalLabel.text = @"一般用户";
                break;
            case 1:
                self.designerProfessionalLabel.text = @"设计师";
                break;
            case 2:
                self.designerProfessionalLabel.text = @"企业";
                break;
            case 3:
                self.designerProfessionalLabel.text = @"自营销人";
                break;
                
            default:
                break;
        }
        
    } else {
        
        [self.focusButton setTitle:[designerList.follow integerValue] == FocusTypeTypeCancelFocus ? FOCUSSTATETITLE_NOFOCUS : FOCUSSTATETITLE_FOCUS forState:UIControlStateNormal];
        self.designerProfessionalLabel.text = designerList.field;
    }
}

-(void)focus:(UIButton *)button{
    
    _focusUserBlock(button.tag, self);
}

#pragma mark 改变热点FocusButton状态
-(void)setupFocusStateWithhFocus:(BOOL)animation{
    
    if (animation) {
        
        _focusButton.frame = CGRectMake(CGRectGetMinX(_focusButton.frame)-5, CGRectGetMinY(_focusButton.frame), 50,16);
        [_focusButton setTitle:FOCUSSTATETITLE_FOCUS forState:UIControlStateNormal];
    }else {
        
        _focusButton.frame = CGRectMake(CGRectGetMinX(_focusButton.frame)+5, CGRectGetMinY(_focusButton.frame), 40,16);
        [_focusButton setTitle:FOCUSSTATETITLE_NOFOCUS forState:UIControlStateNormal];
        
    }
    [_focusButton.layer insertSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_focusButton) atIndex:0];
    _focusButton.layer.masksToBounds = YES;
    _focusButton.layer.cornerRadius = 2;
}


@end
