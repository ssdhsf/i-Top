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
    
    if (info.isEdit && row == 0) { //头像
        self.iconImage.hidden = !info.isEdit;
        self.contentLabel.hidden = info.isEdit;
        self.editorImage.hidden = info.isEdit;
        
        if (self.iconImage.image == nil) {
            [self.iconImage sd_setImageWithURL:[NSURL URLWithString:info.content] placeholderImage:PlaceholderImage];
        }
        
        self.iconImage.layer.masksToBounds = YES;
        self.iconImage.layer.cornerRadius = self.iconImage.height/2;
    } else if(!info.isEdit){ //不能编辑项
        
        self.iconImage.hidden = !info.isEdit;
        self.editorImage.hidden = !info.isEdit;
        self.contentLabel.hidden = info.isEdit;
        self.contentLabel.text = info.content;
        
    }else{ //编辑项
        self.iconImage.hidden = info.isEdit;
        self.editorImage.hidden = !info.isEdit;
        self.contentLabel.hidden = !info.isEdit;
        self.contentLabel.text = info.content;
    }
    self.titleLabel.text = info.title;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
