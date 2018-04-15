//
//  MarketingTableViewCell.m
//  itop
//
//  Created by huangli on 2018/2/28.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MarketingTableViewCell.h"

@implementation MarketingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setItmeOfModel:(Marketing *)info{
    
    self.titleLabel.text = info.title;
    
    if ([Global stringIsNullWithString:info.content]) {
        
        self.ContentTF.placeholder = info.placeholder;
    }else {
        self.ContentTF.text = info.content;
    }
    self.ContentTF.delegate = self;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
//    NSString *temp ;
//    if(range.length == 0){
//        temp = [NSString stringWithFormat:@"%@%@",textField.text,string];
//    } else if(range.length == 1) {
//        temp = [textField.text substringWithRange:NSMakeRange(0,textField.text.length-1)];
//    }
    
    self.inputConfigureBlock(textField.text,self);
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSString *temp = [NSString stringWithFormat:@"%@",textField.text];
    self.inputConfigureBlock(temp,self);
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSString *temp = [NSString stringWithFormat:@"%@",textField.text];
    self.inputConfigureBlock(temp,self);
}


//- (BOOL)textFieldShouldClear:(UITextField *)textField{
//    
//    return NO;
//}
// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    self.inputConfigureBlock(textField.text,self);
    return YES;
}

@end
