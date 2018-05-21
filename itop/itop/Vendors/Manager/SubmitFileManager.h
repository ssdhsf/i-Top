//
//  SubmitFileManager.h
//  xixun
//
//  Created by huangli on 16/5/12.
//  Copyright © 2016年 3N. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessagePhotoView;

@protocol SubmitFileManagerDelegate <NSObject>

@optional
/**
 *   提交图片成功的协议方法
 *
 *  @param PictureUrls 成功后delegate获取图片的url
 */
-(void)submitPicturesDidFinishGetPictureUrlsWithUrlString:(NSString*)PictureUrls;

/**
 *   提交图片失败的协议方法
 *
 *  @param  buttonIndex 为确认与取消的的判断项
 */
-(void)submitPicturesDidFinishBedefeatedOperationAgenTodelegateWithButtonIndex:(NSInteger)buttonIndex;

/**
 *  上传图片方法
 *
 * 部分页面选择照片直接自动上传
 */
- (void)compressionAndTransferPicturesWithArray:(NSArray*)array;


@end

@interface SubmitFileManager : NSObject

+(instancetype)sheardSubmitFileManager;

/**
 *  上传图片方法
 *
 *  @param showView 如果提交图片有错误信息  显示错误信息到视图控制器
 */
- (void)compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:(UIViewController*)showView andType:(NSString *)type;

/**
 *  提交压缩好的图片
 *
 *  @param image 需要提交的图片
 */
-(void)submitImageWithImage:(UIImage *)image;


/**
 *  添加选择图片的View到当前的View
 *
 *  @param  view 调用该方法添加MessagePhotoView到View
 */
- (void)addPictrueViewToViewController:(UIView*)view;

/**
 *  弹出选择照片／拍照
 *
 *  调用该方法添加MessagePhotoView到View
 */
- (void)popupsSelectPhotoTipsView;

/**
 *  再一次编辑
 *
 *  @param urls 原有图片的url 用户可以增 删 改查
 */
- (void)writingAgainAddImageToMessagePhotoViewWithUrls:(NSArray*)urls;

/**
 *  没有更新照片就直接将原有的url输出
 *
 *  @param stringArr 内部调用  外部传入空
 *
 *  @return 原有图片的url
 */
- (NSString *)mosaicString:(NSArray *)stringArr;
/**
 *  选择的图片
 *
 *  @return 获取选择的图片
 */
- (NSArray*)getSelectedPicktures;

/**
 *  清空选择的图片
 */
-(void)emptyThePictureArray;

/**
 *  浏览图片
 *
 *  @param PictureArray 需要浏览的图片
 */
- (void)browsePicturesWithPictureArray:(NSArray*)PictureArray;
    
@property (nonatomic,weak) id <SubmitFileManagerDelegate>delegate;
@property (nonatomic, strong) MessagePhotoView *photoView; //添加图片

/**
 *  photoView 的frame
 */
@property (nonatomic, assign) CGRect photoViewFrame; //添加图片

@end
