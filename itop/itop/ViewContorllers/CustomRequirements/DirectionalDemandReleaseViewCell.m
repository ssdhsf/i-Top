//
//  DirectionalDemandReleaseViewCell.m
//  itop
//
//  Created by huangli on 2018/4/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DirectionalDemandReleaseViewCell.h"

@implementation DirectionalDemandReleaseViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItmeOfModel:(DemandEdit *)demandEdit{
    
    self.titleLabel.text = demandEdit.title;
    
    switch (demandEdit.editType) {
        case EditTypeTextFied:
            
            self.contentTF.hidden = NO;
            self.contentTF.enabled = YES;
            self.contentTV.hidden = YES;
            self.selectImageButton.hidden = YES;
            self.purseIconImage.hidden = YES;
            self.contentTF.delegate = self;
            if ([Global stringIsNullWithString:demandEdit.content]) {
                
               
                self.contentTF.placeholder = [NSString stringWithFormat:@"请输入%@",demandEdit.title];
            }else {
                
                 self.contentTF.text = demandEdit.content;
            }
            break;
        case EditTypeTextView:
            
            self.contentTF.hidden = YES;
            self.contentTV.hidden = NO;
            self.selectImageButton.hidden = YES;
            self.purseIconImage.hidden = YES;
            self.contentTV.delegate = self;
            if ([Global stringIsNullWithString:demandEdit.content]) {
                
                self.contentTV.placeholder = [NSString stringWithFormat:@"请输入%@",demandEdit.title];
            }else {
                
                self.contentTV.text = demandEdit.content;
            }
            self.contentTV.layer.borderWidth = 1.0f;
            self.contentTV.layer.borderColor = UIColorFromRGB(0xDADEE4).CGColor;
            break;
            
        case EditTypeSelectImage:
            
            self.contentTF.hidden = YES;
            self.contentTV.hidden = YES;
            self.selectImageButton.hidden = NO;
            _selectImageButton.frame = CGRectMake(101, 10, 80, 60);
            if (demandEdit.inamge == nil) {
                
                if(demandEdit.content != nil){
                    
                    UIImageView *imageView = [[UIImageView alloc]init];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:demandEdit.content] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

                        [_selectImageButton setImage:imageView.image forState:UIControlStateNormal];
                    }];
                } else {
                    _lary = [[Global sharedSingleton] buttonSublayerWithButton:_selectImageButton];
                    [_selectImageButton.layer addSublayer: _lary];
                }
                
            } else {
                
                [_lary removeFromSuperlayer];
                [_selectImageButton setImage:demandEdit.inamge forState:UIControlStateNormal];;
            }
            
            self.lineView.hidden = YES;
             self.purseIconImage.hidden = YES;
            break;
        case EditTypeSelectItem:
        case EditTypeSelectTime:
            
            self.contentTF.hidden = NO;
            self.contentTF.enabled = NO;
            self.contentTV.hidden = YES;
            self.selectImageButton.hidden = YES;
            self.purseIconImage.hidden = NO;
            if ([Global stringIsNullWithString:demandEdit.content]) {
                
                 self.contentTF.text = nil;
                self.contentTF.placeholder = [NSString stringWithFormat:@"请选择%@",demandEdit.title];
            }else {
                
                self.contentTF.text = demandEdit.content;
            }
            break;

        default:
            break;
    }
}

- (IBAction)selectImageButton:(UIButton *)sender {
    
    if (_selectImageBlock) {
        
        self.selectImageBlock(sender, self);
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if (_selectImageBlock) {
        
        self.selectImageBlock(textView.text, self);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (_selectImageBlock) {
        
        self.selectImageBlock(textField.text, self);
    }
}


@end
