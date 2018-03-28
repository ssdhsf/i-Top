//
//  ShearViewManager.h
//  itop
//
//  Created by huangli on 2018/3/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SelectShearItemBlock)(NSInteger tag);

@interface ShearViewManager : NSObject

@property (nonatomic, copy)SelectShearItemBlock selectShearItme;
@property (nonatomic, strong,readonly)NSArray *shearType;

+ (instancetype)sharedShearViewManager;


- (void)setupShearView;

- (void)addShearViewToView:(UIView*)view
                 shearType:(UMS_SHARE_TYPE)shear_type
                completion:(SelectShearItemBlock)completion;


//分享网页
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType parameter:(ShearInfo *)parameter;


//分享Info
-(ShearInfo *)shearInfoWithProduct:(H5List *)h5;
@end
