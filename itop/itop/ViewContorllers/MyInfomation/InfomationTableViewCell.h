//
//  InfomationTableViewCell.h
//  itop
//
//  Created by huangli on 2018/2/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfomationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *editorImage;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

-(void)setItmeOfModel:(Infomation *)leave row:(NSInteger)row;

@end
