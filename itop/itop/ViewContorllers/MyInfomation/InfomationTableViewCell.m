//
//  InfomationTableViewCell.m
//  itop
//
//  Created by huangli on 2018/2/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "InfomationTableViewCell.h"

@implementation InfomationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setItmeOfModel:(Infomation *)info row:(NSInteger)row{
    
    if (!info.isEdit && row == 0) {
        self.contentLabel.hidden = !info.isEdit;
        self.editorImage.hidden = !info.isEdit;
        
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:info.content] placeholderImage:PlaceholderImage];
        self.iconImage.layer.masksToBounds = YES;
        self.iconImage.layer.cornerRadius = self.iconImage.height/2;
    }
//    else if (!info.isEdit && row == 1){
//        self.editorImage.hidden = !info.isEdit;
//        self.iconImage.hidden = !info.isEdit;
//        self.contentLabel.text = info.content;
//    }
    else{
        self.iconImage.hidden = !info.isEdit;
        self.editorImage.hidden = !info.isEdit;
        self.contentLabel.text = info.content;
    }
    self.titleLabel.text = info.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
