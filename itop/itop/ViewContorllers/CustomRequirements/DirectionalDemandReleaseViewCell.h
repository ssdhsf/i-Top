//
//  DirectionalDemandReleaseViewCell.h
//  itop
//
//  Created by huangli on 2018/4/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectImageBlock)(id obj1, id obj2);

@interface DirectionalDemandReleaseViewCell : UITableViewCell<UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *contentTF;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UIButton *selectImageButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *purseIconImage;

@property (strong, nonatomic) CAShapeLayer *lary;

@property (copy, nonatomic) SelectImageBlock selectImageBlock;

-(void)setItmeOfModel:(DemandEdit *)demandEdit;

@end
