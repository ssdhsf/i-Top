//
//  CustomRequirementsDetailCell.m
//  itop
//
//  Created by huangli on 2018/4/20.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomRequirementsDetailCell.h"

@implementation CustomRequirementsDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItmeOfModel:(Infomation*)CustomRequirementsDetail{
    
    self.titleLabel.text = CustomRequirementsDetail.title;
    if ([CustomRequirementsDetail.title isEqualToString:@"参考图片"]) {
        
        self.contentLable.hidden = YES;
        NSArray *arr = [CustomRequirementsDetail.content componentsSeparatedByString:@"," ];

            self.imageViewsuperView.hidden = NO;
            for (int i = 0 ; i < arr.count; i++) {
                
                if (![Global stringIsNullWithString:arr[i]]) {
                   
                    NSString *url = arr[i];
                    
                    UIImageView *image = [[UIImageView alloc]init];
                    image.frame = CGRectMake((ScreenWidth - 120) - ((ScreenWidth - 120)/3*(arr.count - i)-10), 10, (ScreenWidth - 120)/3 -10, (ScreenWidth - 120)/3 -10);
                    [image sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:H5PlaceholderImage options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    }];
                    
                    [_imageViewsuperView addSubview:image];

                }
            }
    } else if ([CustomRequirementsDetail.title isEqualToString:@"预算"]){
        self.contentLable.text = [NSString stringWithFormat:@"¥%@",CustomRequirementsDetail.content];
        _imageViewsuperView.hidden = YES;
        
    } else {
        self.contentLable.text = CustomRequirementsDetail.content;
        _imageViewsuperView.hidden = YES;
    }
}

@end
