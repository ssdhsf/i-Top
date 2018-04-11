//
//  LeaveTableViewCell.m
//  itop
//
//  Created by huangli on 2018/2/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "LeaveTableViewCell.h"

@implementation LeaveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setItmeOfModel:(Leave *)leave animation:(BOOL)animation{
    
    self.selectStateView.hidden = animation;
    self.selectStateView.layer.cornerRadius = self.selectStateView.size.height/2;
    self.selectStateView.layer.masksToBounds = YES;
    if (animation) {

        self.nameLabel.frame = CGRectMake(20, 21, ScreenWidth -80 , 21);
        self.timeLabel.frame = CGRectMake(20, CGRectGetMaxY(self.nameLabel.frame)+8, ScreenWidth-80 , 21);

    }else{
        
        self.nameLabel.frame = CGRectMake(CGRectGetMaxY(self.selectStateView.frame)+12, 21, ScreenWidth-100 , 21);
        self.timeLabel.frame = CGRectMake(CGRectGetMaxY(self.selectStateView.frame)+12, CGRectGetMaxY(self.nameLabel.frame)+8, ScreenWidth-100 , 21);
        [self setupDeleteSelectViewWithAnimation:[leave.select integerValue]];
    }
    
    self.nameLabel.text = leave.json_result.name;
    self.timeLabel.text = leave.create_datetime;
}

- (IBAction)call:(UIButton *)sender {
    
//    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",@"10086"];
//    CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
//    
    
    self.callButtonBlock(self);
//    if (version >= 10.0) {
//        /// 大于等于10.0系统使用此openURL方法
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
//    } else {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
//    }
}


-(void)setupDeleteSelectViewWithAnimation:(BOOL)animation{
    
    if (animation) {
       
       _selectStateView.backgroundColor = UIColorFromRGB(0xfda5ed);
        
    }else {
        
         _selectStateView.backgroundColor = UIColorFromRGB(0xe0e3e6);
    }
}



@end
