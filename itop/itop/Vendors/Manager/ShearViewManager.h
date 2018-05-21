//
//  ShearViewManager.h
//  itop
//
//  Created by huangli on 2018/3/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SelectShearItemBlock)(NSInteger tag);
typedef void (^ShearSuccessBlock)(NSInteger tag);

@interface ShearViewManager : NSObject

@property (nonatomic, copy)SelectShearItemBlock selectShearItme;
@property (nonatomic, copy)ShearSuccessBlock shearSuccessBlock;
@property (nonatomic, strong,readonly)NSArray *shearTypeArray;
@property (nonatomic, assign)ShearType shearType;

+ (instancetype)sharedShearViewManager;

-(void)setupShearViewWithshearType:(ShearType)shearType;

- (void)addShearViewToView:(UIView*)view
                 shearType:(UMS_SHARE_TYPE)shear_type
                completion:(SelectShearItemBlock)completion;

//分享网页
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType parameter:(ShearInfo *)parameter;

//分享图片链接
- (void)shareImageURLToPlatformType:(UMSocialPlatformType)platformType
                          parameter:(ShearInfo *)parameter;

//分享Info
-(ShearInfo *)shearInfoWithProduct:(H5List *)h5;

@end
