//
//  EditChannelListTCell.m
//  itop
//
//  Created by huangli on 2018/5/4.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "EditChannelListTCell.h"

@implementation EditChannelListTCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.nameContentTF.delegate = self;
    self.fensContentTF.delegate = self;
    self.linkContentTF.delegate = self;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItmeOfModel:(ChannelList *)channelList index:(NSInteger)index {
    
    self.nameTitleLabel.text = [NSString stringWithFormat:@"渠道名称%ld", index+1];
    
    if ([Global stringIsNullWithString:channelList.name]) {
        self.nameContentTF.placeholder = @"请输入渠道名称";
    } else{
        self.nameContentTF.text = channelList.name;
    }
    
    if ([Global stringIsNullWithString:channelList.fans_count]) {
        self.fensContentTF.placeholder = @"请输入粉丝数量";
    } else{
        self.fensContentTF.text = channelList.fans_count;
    }
    
    if ([Global stringIsNullWithString:channelList.index_url]) {
        self.linkContentTF.placeholder = @"请输入主页链接";
    } else{
        self.linkContentTF.text = channelList.index_url;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    _inputConfigureBlock(self,textField);
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
//    NSString *temp = [NSString stringWithFormat:@"%@",textField.text];
    _inputConfigureBlock(self,textField);
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
//    NSString *temp = [NSString stringWithFormat:@"%@",textField.text];
    _inputConfigureBlock(self,textField);
}


//- (BOOL)textFieldShouldClear:(UITextField *)textField{
//
//    return NO;
//}
// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    self.inputConfigureBlock(self,textField);
    return YES;
}


@end
