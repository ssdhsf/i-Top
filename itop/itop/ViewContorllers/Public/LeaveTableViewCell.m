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
    
    self.deleteButton.hidden = animation;
    self.deleteButton.layer.cornerRadius = self.deleteButton.size.height/2;
    self.deleteButton.layer.masksToBounds = YES;
    if (animation) {

        self.nameLabel.frame = CGRectMake(20, 21, ScreenWidth -80 , 21);
        self.timeLabel.frame = CGRectMake(20, CGRectGetMaxY(self.nameLabel.frame)+8, ScreenWidth-80 , 21);

    }else{
        
        self.nameLabel.frame = CGRectMake(CGRectGetMaxY(self.deleteButton.frame)+12, 21, ScreenWidth-100 , 21);
        self.timeLabel.frame = CGRectMake(CGRectGetMaxY(self.deleteButton.frame)+12, CGRectGetMaxY(self.nameLabel.frame)+8, ScreenWidth-100 , 21);
        [self setupDeleteButtonSelectWithAnimation:leave.select];
    }
    
    
    self.nameLabel.text = leave.name;
    self.timeLabel.text = leave.time;
}

- (IBAction)call:(UIButton *)sender {
    
    
}

- (IBAction)delete:(UIButton *)sender {
    
    [self setupDeleteButtonSelectWithAnimation:!sender.selected];
    _deleteIndex(self);
}

-(void)setupDeleteButtonSelectWithAnimation:(BOOL)animation{
    
    _deleteButton.selected = animation;
    if (_deleteButton.selected) {
        
        _deleteButton.backgroundColor = UIColorFromRGB(0xfda5ed);
    }else {
        _deleteButton.backgroundColor = UIColorFromRGB(0xe0e3e6);
    }
}



@end
