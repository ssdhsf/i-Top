//
//  UploadProductDetailCell.h
//  itop
//
//  Created by huangli on 2018/5/8.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadProductDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coveImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *fuzhiButton;

-(void)showProductDedailItmeOfModel:(DemandEdit *)biddingProduct;

@end
