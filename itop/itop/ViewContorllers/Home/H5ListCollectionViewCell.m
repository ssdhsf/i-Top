//
//  H5ListCollectionViewCell.m
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "H5ListCollectionViewCell.h"

@implementation H5ListCollectionViewCell

- (void)setItmeOfModel:(H5List*)h5Model{

    self.h5ListImage.frame = CGRectMake(43/2, 5, self.frame.size.width-43, (self.frame.size.width-43)*1.7);
//    UIImageView *imageView = [UIImageView new];
    [self.h5ListImage sd_setImageWithURL:[NSURL URLWithString:h5Model.cover_img] placeholderImage:H5PlaceholderImage];
//    self.h5ListImage.image = imageView.image;
//    self.h5ListImage.image = [UIImage imageNamed:h5Model.h5ImageUrl];
    self.h5ListTitleLabel.text = h5Model.title;
     self.h5ListTitleLabel.frame = CGRectMake(43/2, CGRectGetMaxY(self.h5ListImage.frame)+7, CGRectGetMaxX(self.h5ListImage.frame),16);
    self.h5ListMoneyLabel.text = [NSString stringWithFormat:@"￥%@",h5Model.price];
    
    self.h5ListMoneyLabel.frame = CGRectMake(43/2, CGRectGetMaxY(self.h5ListTitleLabel.frame)+9, CGRectGetMaxX(self.h5ListImage.frame),16);
    self.h5ListMoneyLabel.textColor  =UIColorFromRGB(0x61bef4);
    
//    NSLog(@"%f-----%f",(ScreenWidth/3-33)*1.7+32+5+7+9+5,(self.frame.size.width-43)*1.7+32+5+5+9+7);
//    [self homeLayoutSubviews];
}

- (void)setH5LietItmeOfModel:(H5List*)h5Model{

    self.h5ListImage.frame = CGRectMake(20/2, 5, self.frame.size.width-20, (self.frame.size.width-20)*1.69);
    UIImageView *imageView = [UIImageView new];
    [imageView sd_setImageWithURL:[NSURL URLWithString:h5Model.cover_img] placeholderImage:H5PlaceholderImage];
    self.h5ListImage.image = imageView.image;
    
//    self.h5ListImage.image = [UIImage imageNamed:h5Model.h5ImageUrl];
    self.h5ListTitleLabel.text = h5Model.title;
    self.h5ListTitleLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.h5ListImage.frame)+7, CGRectGetMaxX(self.h5ListImage.frame),16);
    self.h5ListMoneyLabel.text = [NSString stringWithFormat:@"￥%@",h5Model.price] ;
    self.h5ListMoneyLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.h5ListTitleLabel.frame)+7, CGRectGetMaxX(self.h5ListImage.frame),16);
    self.h5ListMoneyLabel.textColor  = UIColorFromRGB(0xeb6ea5);
}


- (void)setMyWorkLietItmeOfModel:(H5List*)h5Model{
    
//    self.h5ListImage.frame = CGRectMake(20/2, 5, self.frame.size.width-20, (self.frame.size.width-20)*1.69);
//    UIImageView *imageView = [UIImageView new];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:h5Model.cover_img] placeholderImage:nil];
//    self.h5ListImage.image = imageView.image;
//    
//    //    self.h5ListImage.image = [UIImage imageNamed:h5Model.h5ImageUrl];
//    self.h5ListTitleLabel.text = h5Model.title;
//    self.h5ListTitleLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.h5ListImage.frame)+7, CGRectGetMaxX(self.h5ListImage.frame),16);
//    self.h5ListMoneyLabel.text = [NSString stringWithFormat:@"￥%@",h5Model.praise_count] ;
//    self.h5ListMoneyLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.h5ListTitleLabel.frame)+7, CGRectGetMaxX(self.h5ListImage.frame),16);
//    self.h5ListMoneyLabel.textColor  = UIColorFromRGB(0xeb6ea5);
        self.h5ListImage.frame = CGRectMake(20/2, 5, self.frame.size.width-20, (self.frame.size.width-20)*1.69);
//        UIImageView *imageView = [UIImageView new];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:h5Model.cover_img] placeholderImage:nil];
        self.h5ListImage.image = [UIImage imageNamed:h5Model.h5ImageUrl];
    
        //    self.h5ListImage.image = [UIImage imageNamed:h5Model.h5ImageUrl];
        self.h5ListTitleLabel.text = h5Model.h5Title;
        self.h5ListTitleLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.h5ListImage.frame)+7, CGRectGetMaxX(self.h5ListImage.frame),16);
        self.h5ListMoneyLabel.text = h5Model.h5Money;
        self.h5ListMoneyLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.h5ListTitleLabel.frame)+7, CGRectGetMaxX(self.h5ListImage.frame),16);
        self.h5ListMoneyLabel.textColor  = UIColorFromRGB(0xeb6ea5);
}


@end
