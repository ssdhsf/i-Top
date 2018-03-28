//
//  SearchTableViewCell.h
//  itop
//
//  Created by huangli on 2018/3/23.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *searchTitle;
@property (weak, nonatomic) IBOutlet UILabel *searchBelongs;


-(void)setItmeOfModel:(SearchLocation *)searchLocation searchKey:(NSString *)searchKey;


@end
