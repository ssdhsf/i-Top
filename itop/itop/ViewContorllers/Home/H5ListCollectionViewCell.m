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
    
    NSString *price = [NSString stringWithFormat:@"￥%@",h5Model.price];
    self.h5ListMoneyLabel.attributedText = [self.h5ListMoneyLabel.text setupAttributedString:9 color:UIColorFromRGB(0xeb6ea5) string:price] ;
    
    self.h5ListMoneyLabel.frame = CGRectMake(43/2, CGRectGetMaxY(self.h5ListTitleLabel.frame)+9, CGRectGetMaxX(self.h5ListImage.frame),16);
    self.h5ListMoneyLabel.textColor  = UIColorFromRGB(0xeb6ea5);
    
    NSInteger saleLabelWith = [[Global sharedSingleton]widthForString:[NSString stringWithFormat:@"  %@人使用",[Global stringIsNullWithString:h5Model.sale_count] ? @"0" : h5Model.sale_count] fontSize:7 andHeight:10];
    
    self.saleLable.frame = CGRectMake(CGRectGetMinX(self.h5ListImage.frame)+7, CGRectGetMaxY(self.h5ListImage.frame)-15, saleLabelWith+10, 10);
    
    self.saleLable.text = [NSString stringWithFormat:@"  %@人使用",[Global stringIsNullWithString:h5Model.sale_count] ? @"0" : h5Model.sale_count];
    self.saleLable.backgroundColor = [UIColor colorWithRed:((float)((0xcbe8f3 & 0xFF0000) >> 16))/255.0 green:((float)((0xcbe8f3 & 0xFF00) >> 8))/255.0 blue:((float)(0xcbe8f3 & 0xFF))/255.0 alpha:0.5];
    self.saleLable.layer.cornerRadius = 5;
    self.saleLable.layer.masksToBounds = YES;
    
//    NSLog(@"%f-----%f",(ScreenWidth/3-33)*1.7+32+5+7+9+5,(self.frame.size.width-43)*1.7+32+5+5+9+7);
//    [self homeLayoutSubviews];
}

- (void)setH5LietItmeOfModel:(H5List*)h5Model{

    self.h5ListImage.frame = CGRectMake(20/2, 5, self.frame.size.width-20, (self.frame.size.width-20)*1.69);
//    UIImageView *imageView = [UIImageView new];
    [self.h5ListImage sd_setImageWithURL:[NSURL URLWithString:h5Model.cover_img] placeholderImage:H5PlaceholderImage];
//    self.h5ListImage.image = imageView.image;
    
//    self.h5ListImage.image = [UIImage imageNamed:h5Model.h5ImageUrl];
    self.h5ListTitleLabel.text = h5Model.title;
    self.h5ListTitleLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.h5ListImage.frame)+7, CGRectGetMaxX(self.h5ListImage.frame),16);
//    self.h5ListMoneyLabel.text = [NSString stringWithFormat:@"￥%@",h5Model.price] ;
    self.h5ListMoneyLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.h5ListTitleLabel.frame)+7, CGRectGetMaxX(self.h5ListImage.frame),16);
//    self.h5ListMoneyLabel.textColor  = UIColorFromRGB(0xeb6ea5);
    
    NSString *price = [NSString stringWithFormat:@"￥%@",h5Model.price];
    self.h5ListMoneyLabel.attributedText = [self.h5ListMoneyLabel.text setupAttributedString:9 color:UIColorFromRGB(0xeb6ea5) string:price];
    
    NSInteger saleLabelWith = [[Global sharedSingleton]widthForString:[NSString stringWithFormat:@"  %@人使用",[Global stringIsNullWithString:h5Model.sale_count] ? @"0" : h5Model.sale_count] fontSize:7 andHeight:10];
    
    self.saleLable.frame = CGRectMake(CGRectGetMinX(self.h5ListImage.frame)+7, CGRectGetMaxY(self.h5ListImage.frame)-15, saleLabelWith+10, 10);
    
    
    self.saleLable.text = [NSString stringWithFormat:@"  %@人使用",[Global stringIsNullWithString:h5Model.sale_count] ? @"0" : h5Model.sale_count];
    self.saleLable.backgroundColor = [UIColor colorWithRed:((float)((0xcbe8f3 & 0xFF0000) >> 16))/255.0 green:((float)((0xcbe8f3 & 0xFF00) >> 8))/255.0 blue:((float)(0xcbe8f3 & 0xFF))/255.0 alpha:0.5];
    self.saleLable.layer.cornerRadius = 5;
    self.saleLable.layer.masksToBounds = YES;
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
//    UIImageView *imageView = [UIImageView new];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:h5Model.cover_img] placeholderImage:nil];
    
    [self.h5ListImage sd_setImageWithURL:[NSURL URLWithString:h5Model.cover_img] placeholderImage:H5PlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
//        self.h5ListImage.image = image;
        
    }];
    
//    self.h5ListImage.image = imageView.image;
    self.h5ListTitleLabel.text = h5Model.title;
    self.h5ListTitleLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.h5ListImage.frame)+7, CGRectGetMaxX(self.h5ListImage.frame),16);
//    self.h5ListMoneyLabel.text = [NSString stringWithFormat:@"¥%@",h5Model.price];
    self.h5ListMoneyLabel.frame = CGRectMake(20/2, CGRectGetMaxY(self.h5ListTitleLabel.frame)+7, CGRectGetMaxX(self.h5ListImage.frame),16);
    self.h5ListMoneyLabel.textColor  = UIColorFromRGB(0xeb6ea5);
    NSString *price = [NSString stringWithFormat:@"￥%@",h5Model.price];
    self.h5ListMoneyLabel.attributedText = [self.h5ListMoneyLabel.text setupAttributedString:9 color:UIColorFromRGB(0xeb6ea5) string:price] ;

    NSInteger saleLabelWith = [[Global sharedSingleton]widthForString:[NSString stringWithFormat:@"  %@人使用",[Global stringIsNullWithString:h5Model.sale_count] ? @"0" : h5Model.sale_count] fontSize:7 andHeight:10];
    
    self.saleLable.frame = CGRectMake(CGRectGetMinX(self.h5ListImage.frame)+7, CGRectGetMaxY(self.h5ListImage.frame)-15, saleLabelWith+10, 10);
    
    
    self.saleLable.text = [NSString stringWithFormat:@"  %@人使用",[Global stringIsNullWithString:h5Model.sale_count] ? @"0" : h5Model.sale_count];
    self.saleLable.backgroundColor = [UIColor colorWithRed:((float)((0xcbe8f3 & 0xFF0000) >> 16))/255.0 green:((float)((0xcbe8f3 & 0xFF00) >> 8))/255.0 blue:((float)(0xcbe8f3 & 0xFF))/255.0 alpha:0.5];
    self.saleLable.layer.cornerRadius = 5;
    self.saleLable.layer.masksToBounds = YES;

}

- (void)setMyCaseListItmeOfModel:(EditCase*)editCase getCaseType:(GetCaseType)getCaseType{
    
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
    
    CGFloat origeX = getCaseType == GetCaseTypeHome ? 43 : 20;
    self.h5ListImage.frame = CGRectMake(origeX/2, 5, self.frame.size.width-origeX, (self.frame.size.width-origeX)*1.69);
    //    UIImageView *imageView = [UIImageView new];
    //    [imageView sd_setImageWithURL:[NSURL URLWithString:h5Model.cover_img] placeholderImage:nil];
    
    [self.h5ListImage sd_setImageWithURL:[NSURL URLWithString:editCase.cover_img] placeholderImage:H5PlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        //        self.h5ListImage.image = image;
        
    }];
    
    //    self.h5ListImage.image = imageView.image;
    self.h5ListTitleLabel.text = editCase.title;
    self.h5ListTitleLabel.frame = CGRectMake(origeX/2, CGRectGetMaxY(self.h5ListImage.frame)+7, CGRectGetMaxX(self.h5ListImage.frame),16);
//    self.h5ListMoneyLabel.text = [NSString stringWithFormat:@"¥%@",editCase.price];
    self.h5ListMoneyLabel.frame = CGRectMake(origeX/2, CGRectGetMaxY(self.h5ListTitleLabel.frame)+7, CGRectGetMaxX(self.h5ListImage.frame),16);
    self.h5ListMoneyLabel.textColor  = UIColorFromRGB(0xeb6ea5);
    NSString *price = [NSString stringWithFormat:@"￥%@",editCase.price];
    self.h5ListMoneyLabel.attributedText = [self.h5ListMoneyLabel.text setupAttributedString:9 color:UIColorFromRGB(0xeb6ea5) string:price] ;
    if (getCaseType == GetCaseTypeHome) {
        NSInteger saleLabelWith = [[Global sharedSingleton]widthForString:[NSString stringWithFormat:@"  %@人使用",[Global stringIsNullWithString:editCase.demand_count] ? @"0" : editCase.demand_count] fontSize:7 andHeight:10];
        self.saleLable.frame = CGRectMake(CGRectGetMinX(self.h5ListImage.frame)+7, CGRectGetMaxY(self.h5ListImage.frame)-15, saleLabelWith+10, 10);
        self.saleLable.text = [NSString stringWithFormat:@"  %@人使用",[Global stringIsNullWithString:editCase.demand_count] ? @"0" : editCase.demand_count];
        self.saleLable.backgroundColor = [UIColor colorWithRed:((float)((0xcbe8f3 & 0xFF0000) >> 16))/255.0 green:((float)((0xcbe8f3 & 0xFF00) >> 8))/255.0 blue:((float)(0xcbe8f3 & 0xFF))/255.0 alpha:0.5];
        self.saleLable.layer.cornerRadius = 5;
        self.saleLable.layer.masksToBounds = YES;
        self.saleLable.hidden = NO;

    } else {
        self.saleLable.hidden = YES;
    }
}

@end
