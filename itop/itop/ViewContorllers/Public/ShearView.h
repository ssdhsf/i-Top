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

@property (nonatomic, copy)SelectShearItemBlock selectShearItme;
@property (nonatomic, copy) void(^cancelBlock)(id obj);

-(void)setupShearItemWithshearTepy:(ShearType)shearType;
-(NSArray*)shearItemTitleArrayWithshearTepy:(ShearType)shearType;


@end
