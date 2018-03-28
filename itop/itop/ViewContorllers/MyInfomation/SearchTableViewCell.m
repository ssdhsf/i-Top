//
//  SearchTableViewCell.m
//  itop
//
//  Created by huangli on 2018/3/23.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setItmeOfModel:(SearchLocation *)searchLocation searchKey:(NSString *)searchKey{
    
    NSLog(@"%@",searchKey);
    
    NSString *temp = nil;
    
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:searchLocation.searchLocation];
    for(int i =0; i < [searchKey length]; i++){
        
        temp = [searchKey substringWithRange:NSMakeRange(i, 1)];

        NSRange range;
        range = [searchLocation.searchLocation rangeOfString:temp];
        
        if (range.location != NSNotFound) {
            NSLog(@"found at location = %lu, length = %lu",(unsigned long)range.location,(unsigned long)range.length);
            
            [textColor addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x54c3f1) range:range];
            [textColor addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
        }else{
            NSLog(@"Not Found");
        }
    }
    self.searchTitle.attributedText = textColor;
    self.searchBelongs.text = searchLocation.searchBelongs;
}

@end
