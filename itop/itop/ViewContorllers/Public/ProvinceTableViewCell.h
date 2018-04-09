//
//  ProvinceTableViewCell.h
//  itop
//
//  Created by huangli on 2018/4/1.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProvinceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

-(void)setItmeOfModel:(Province*)province;

@end
