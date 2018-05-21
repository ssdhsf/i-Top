//
//  EditChannelListTCell.h
//  itop
//
//  Created by huangli on 2018/5/4.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditChannelListTCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameContentTF;

@property (weak, nonatomic) IBOutlet UILabel *fensTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *fensContentTF;

@property (weak, nonatomic) IBOutlet UILabel *linkTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *linkContentTF;

@property (copy, nonatomic) void(^inputConfigureBlock )(id cell, id tag );

-(void)setItmeOfModel:(ChannelList *)channelList index:(NSInteger)index;

@end
