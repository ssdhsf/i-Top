//
//  ShearView.h
//  itop
//
//  Created by huangli on 2018/3/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectShearItemBlock)(NSInteger tag);

@interface ShearView : UIView

-(void)setupShearItem;
@property (nonatomic, copy)SelectShearItemBlock selectShearItme;

@end
