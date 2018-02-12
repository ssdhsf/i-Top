//
//  TagView.h
//  itop
//
//  Created by huangli on 2018/2/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void (^FGGTagScrolledBlock)(NSInteger indexPath);

@interface TagView : UIView


@property (strong, nonatomic) UIImageView *iconImage;
@property (strong, nonatomic) UILabel *tagTitle;
//@property (nonatomic,copy) FGGTagScrolledBlock  tagDidScrolledBlock;

- (void)setItmeOfModel:(TagList*)tag tapTag:(NSInteger)tapTag;


@end
