//
//  ZBShareMenuView.h
//  MessageDisplay
//
//  Created by zhoubin@moshi on 14-5-13.
//  Copyright (c) 2014年 Crius_ZB. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>
#import "ZYQAssetPickerController.h"
#import "ShowBigViewController.h"

#define kZBMessageShareMenuPageControlHeight 30

@protocol MessagePhotoViewDelegate <NSObject>

@optional

-(void)addPicker:(ZYQAssetPickerController *)picker;          //UIImagePickerController
-(void)pushViewController:(UIViewController*)photo;
-(void)addUIImagePicker:(UIImagePickerController *)picker;
-(void)transferPictures:(NSArray*)picturesArray;

-(void)introductionPhoto:(ZYQAssetPickerController *)photo;
-(void)introductionCamera:(UIImagePickerController *)camera;

@end

@interface MessagePhotoView : UIView<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,ZYQAssetPickerControllerDelegate>{
    //下拉菜单
//    UIActionSheet *myActionSheet;
    
    //图片2进制路径
    NSString* filePath;
}
//@property(nonatomic,strong) UIScrollView *scrollview;

/**
 *  第三方功能Models
 */
@property (nonatomic, strong, readonly) NSMutableArray *photoMenuItems;

/**
 *  获取重新编辑已提交的图片数组
 */
@property (nonatomic, strong) NSMutableArray *urlImage;

/**
 *  浏览的图片
 */
@property (nonatomic, strong) NSMutableArray *browsePicturesArray;

@property(nonatomic, strong) NSMutableArray *itemArray;

/**
 *  是否是浏览图片
 */
@property(nonatomic, assign) BOOL isBrowsePictures;

@property (nonatomic, assign) id <MessagePhotoViewDelegate> delegate;
/**
 *  根据外来参数判断可以选择多少张照片
 */
@property(nonatomic,strong) NSString*howMany;

-(void)reloadDataWithImage:(UIImage *)image;

/**
 *  刷新collectionView
 *
 */
-(void)collectionViewReloadData;

/**
 *  浏览图片
 *
 *  @param pictureArray 需要浏览的图片
 */
-(void)browsePicturesWithPictureArray:(NSArray *)pictureArray;

/**
 *  打开选择图片提示（相册和拍摄 取消）
 */
-(void)openMenu;

@end
