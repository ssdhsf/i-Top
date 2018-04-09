//
//  ShowBigViewController.m
//  testKeywordDemo
//
//  Created by mei on 14-8-18.
//  Copyright (c) 2014年 Bluewave. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "ShowBigViewController.h"
#import "CDRTranslucentSideBar.h"
#define IOS7LATER  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
@interface ShowBigViewController ()<UIGestureRecognizerDelegate, UIScrollViewDelegate>{
    UIPageControl *  pageControl;
    CGFloat itemWidth;
    
    CGFloat scrollerViewWidth;
    CGFloat scrollerViewHight;
    
    CGFloat lastScale;
}

@end

@implementation ShowBigViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置导航栏的rightButton
//    rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightbtn.frame=CGRectMake(0, 0, 22, 22);
//    [rightbtn setImage:[UIImage imageNamed:@"delete_show.png"] forState:UIControlStateNormal];
//    [rightbtn addTarget:self action:@selector(delete:)forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
//    if (!_isEditor) {
//        rightbtn.hidden=YES;
//    }
     //设置导航栏的leftButton
//    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftbtn.frame=CGRectMake(0, 0, 11, 20);
//    
//    [leftbtn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
//    [leftbtn addTarget:self action:@selector(dismiss)forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
//    if([[[UIDevice currentDevice]systemVersion] doubleValue]>=7.0){
//        [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
//    }else{
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//    }
//    [self layOut];
//    
//    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _scrollerview.size.height-50, ViewWidth, 20)];
//    [pageControl setBackgroundColor:[UIColor clearColor]];
//    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
//    pageControl.pageIndicatorTintColor = XFontC6GrayColor;
//    pageControl.currentPage = 0;
//    pageControl.numberOfPages = _arrayOK.count;
//    [self.view addSubview:pageControl];
//    self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld",(long)_index+1,(long)_arrayOK.count];
//
}

//
//-(void)layOut{
//    self.view.backgroundColor = [UIColor grayColor];
//            //arrayOK里存放选中的图片
//   
//    //CGFloat YHeight=([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)?(64.0f):(44.0f);
//    
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
//    if (IOS7LATER)
//    {
//          _scrollerview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50)];
//         _btnOK = [[UIButton alloc]initWithFrame:CGRectMake(244,  _scrollerview.frame.size.height + 9, 61, 32)];
//        
//        scrollerViewWidth = _scrollerview.frame.size.width;
//        scrollerViewHight = _scrollerview.frame.size.height;
//        
//    }
//#endif
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//    {
//    }
//    else
//    {
//        _scrollerview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigh)];
//        _btnOK = [[UIButton alloc]initWithFrame:CGRectMake(244,  _scrollerview.frame.size.height + 11, 61, 32)];
//    }
//    //显示选中的图片的大图
//  
//    _scrollerview.backgroundColor = [UIColor whiteColor];
//    _scrollerview.delegate = self;
//    _scrollerview.pagingEnabled=YES;
//    [self loadingScorllView];
//    _scrollerview.contentOffset=CGPointMake(ScreenWidth*_index, 0);
//    //缩放的最大倍数
//    _scrollerview.maximumZoomScale=2;
//    //缩放的最小倍数
//    _scrollerview.minimumZoomScale=0.5;
////    _scrollerview.zoomScale = 1.0;
////    _scrollerview.bouncesZoom = YES;
//    _scrollerview.delegate = self;
//    [self.view addSubview:_scrollerview];
//    //点击按钮，回到主发布页面
//   
////    [_btnOK setBackgroundImage:[UIImage imageNamed:@"complete.png"] forState:UIControlStateNormal];
//// 
////    [_btnOK setTitle:[NSString stringWithFormat:@"完成(%ld)",self.arrayOK.count] forState:UIControlStateNormal];
////    _btnOK .titleLabel.font = [UIFont systemFontOfSize:10];
////    [_btnOK addTarget:self action:@selector(complete:) forControlEvents:UIControlEventTouchUpInside];
////    [self.view addSubview:_btnOK];
//    
//    
//}
//
//-(void)complete:(UIButton *)sender{
//    NSLog(@"完成了,跳到主发布页面");
//    [self dismissViewControllerAnimated:YES completion:Nil];
//}
//
//-(void)delete:(UIButton *)sender{
//    
//    CGFloat content=_scrollerview.contentOffset.x;
//    NSInteger index;
//    NSInteger temp;
//    NSLog(@"%@",[_scrollerview subviews]);
//    for(UIImageView*image in[_scrollerview subviews])
//    {
//        if (image.tag==content/itemWidth) {
//            index=image.tag;
//            temp=image.tag;
//            if (image.tag == _arrayOK.count-1) {
//                temp=image.tag-1;
//            }
//            [_arrayOK removeObjectAtIndex:image.tag];
//            break;
//        }
//    }
//    
//    if (_arrayOK.count==0) {
//        [self dismiss];
//    }
//    
//    else{
//         [self loadingScorllView];
//          _scrollerview.contentOffset=CGPointMake(itemWidth*temp, 0);
//            self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld",(long)(_scrollerview.contentOffset.x/ScreenWidth)+1,(long)_arrayOK.count];
//        pageControl.numberOfPages = _arrayOK.count;
//    }
//    if([self.delegate respondsToSelector:@selector(showBigViewControllerDelegate:didSelectDeleteButtonAtIndex:)]){
//        [self.delegate showBigViewControllerDelegate:self
//               didSelectDeleteButtonAtIndex:index];
//       }
//
//}
//
//-(void)loadingScorllView {
//    
//    if ([_scrollerview subviews]) {
//        for (UIView*view in [_scrollerview subviews]) {
//            [view removeFromSuperview];
//        }
//    }
//
//    CGFloat dx = 10.0;
//    _scrollerview.frame = CGRectMake(-dx,  0,  scrollerViewWidth,scrollerViewHight);
//    itemWidth = scrollerViewWidth +dx*2;
//    _scrollerview.frame =  CGRectMake(-dx, 0, itemWidth,scrollerViewHight);
//    for (int i=0; i<[self.arrayOK count]; i++) {
//        UIImageView *img;
//        if ([self.arrayOK[i] isKindOfClass:[NSDictionary class]]) {
//            NSDictionary*dic=self.arrayOK[i];
//            img=dic[@"imageView"];
//        }else{
//            img=self.arrayOK[i];
//        }
//        
//        UIImage * modifyImage = img.image;
//        UIImageView *imgview=[[UIImageView alloc]init];
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*itemWidth, 0, itemWidth, scrollerViewHight)];
//        if (modifyImage.size.width >ViewWidth || modifyImage.size.height > scrollerViewHight) {
//            
//             modifyImage = [self fixedWidthAdjustmentHightWithModifyImage:modifyImage];
//            
//            
//            if (modifyImage.size.width > modifyImage.size.height) {
//
//                imgview.frame = CGRectMake((view.frame.size.width-modifyImage.size.width)/2,(scrollerViewHight - modifyImage.size.height)/2, ViewWidth, modifyImage.size.height);
//
//            } else {
//   
//                if (modifyImage.size.height > scrollerViewHight) {
//                    modifyImage = [self fixedHightAdjustmentWidthWithModifyImage:modifyImage];
//                    imgview.frame = CGRectMake((view.frame.size.width-modifyImage.size.width)/2,0, modifyImage.size.width, modifyImage.size.height);
//                } else {
//                    
//                    imgview.frame = CGRectMake((view.frame.size.width-modifyImage.size.width)/2,(scrollerViewHight - modifyImage.size.height)/2,  modifyImage.size.width, modifyImage.size.height);
//                }
//            }
//
//        } else {
//            
//            imgview.frame = CGRectMake((view.frame.size.width-modifyImage.size.width)/2,(scrollerViewHight - modifyImage.size.height)/2, modifyImage.size.width, modifyImage.size.height);
//        }
//        imgview.contentMode=UIViewContentModeScaleAspectFill;
//        imgview.clipsToBounds=YES;
//        imgview.image = modifyImage;
//        imgview.tag = i;
//        [view addSubview:imgview];
//        [_scrollerview addSubview:view];
//    }
//    _scrollerview.contentSize = CGSizeMake(_arrayOK.count * itemWidth,[_scrollerview bounds].size.height);
//}
//
//- (UIImage *)fixedWidthAdjustmentHightWithModifyImage:(UIImage *)modifyImage{
//    CGFloat width = scrollerViewWidth;
//    CGFloat proportion =  (modifyImage.size.width - scrollerViewWidth)/modifyImage.size.width;
//    CGFloat height = modifyImage.size.height -  (modifyImage.size.height*proportion);
//    CGSize imageSize = CGSizeMake(width, height);
//     UIImage *image = [self imageWithImage:modifyImage scaledToSize:imageSize];
//    return image;
//}
//
//- (UIImage *)fixedHightAdjustmentWidthWithModifyImage:(UIImage *)modifyImage{
//    
//    CGFloat  height = scrollerViewHight;
//    CGFloat proportion =  (modifyImage.size.height - scrollerViewHight)/modifyImage.size.height;
//    CGFloat width = modifyImage.size.width -  (modifyImage.size.width*proportion);
//    CGSize imageSize = CGSizeMake(width, height);
//    UIImage *image = [self imageWithImage:modifyImage scaledToSize:imageSize];
//    return image;
//}
//
//#pragma mark - 压缩图片
//- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)targetSize {
//    
//    UIImage * sourceImage = image;
//    UIImage * newImage = nil;
//    CGFloat width = image.size.width ;
//    CGFloat height=  image.size.height ;
//    CGFloat targetWidth = targetSize.width ;
//    CGFloat targetHeight =targetSize.height ;
//    CGFloat scale_factor= 0.0;
//    CGFloat scaledWidth = targetWidth;
//    CGFloat scaledHeight = targetHeight;
//    CGPoint thumbnailPoint =  CGPointMake(0.0,0.0);
//    if (CGSizeEqualToSize(image.size,targetSize)==  NO){
//        CGFloat  widthFactor = targetWidth /width;
//        CGFloat  heightFactor = targetHeight/height;
//        if (widthFactor <heightFactor){
//            
//           scale_factor = widthFactor;
//            
//        } else {
//            
//            scale_factor = heightFactor;
//        }
//    
//        scaledWidth  =width * scale_factor;
//        scaledHeight =height * scale_factor;
//        //中心图像
//        if (widthFactor <heightFactor){
//            
//            thumbnailPoint.y =(targetHeight - scaledHeight)* 0.5;
//        }  else if  (widthFactor> heightFactor){
//            thumbnailPoint.x  =(targetWidth - scaledWidth)* 0.5;
//        }
//    }
//    //主要部分：
//    UIGraphicsBeginImageContext(targetSize);
//    CGRect  thumbnailRect =  CGRectZero ;
//    thumbnailRect.origin   = thumbnailPoint;
//    thumbnailRect.size.width  = scaledWidth;
//    thumbnailRect.size.height  = scaledHeight;
//    [sourceImage  drawInRect:thumbnailRect];
//    newImage =  UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    if(newImage == nil){
//        NSLog (@"nil");
//    }
//
//    return newImage;
//}
//
//-(void)dismiss{
//
//    [self.navigationController popViewControllerAnimated:YES];
//
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    NSInteger index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
//    [pageControl setCurrentPage:index];
//    
//    self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld",(long)(_scrollerview.contentOffset.x/ScreenWidth)+1,(long)_arrayOK.count];
//
//}
//
//-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
//    
//    NSInteger index = _scrollerview.contentOffset.x/itemWidth;
//    return _scrollerview.subviews[index];
//}
//
//#pragma mark-  缩放完毕
//-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
//{
//    NSInteger index = scrollView.contentOffset.x/itemWidth;
//    if (_scrollerview.zoomScale < 1) {
//        
//        scrollView.zoomScale=1;
//        scrollView.subviews[index].center = self.view.center;
//       
//    } else {
//        
//    }
//        //缩放完之后恢复原状
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    
//    NSInteger index = scrollView.contentOffset.x/itemWidth;
//
//    NSLog(@"%.0f",scrollView.zoomScale);
//    if (scrollView.zoomScale > 1.0) {
//        for (int i = 0; i < scrollView.subviews.count; i++) {
//            
//            UIView *view = scrollView.subviews[i];
//            
//            if (view == scrollView.subviews[index]) {
//                
//                view.frame = CGRectMake(itemWidth*i+(itemWidth-itemWidth*scrollView.zoomScale)/2, (scrollerViewHight-scrollerViewHight*scrollView.zoomScale)/2, scrollerViewWidth*scrollView.zoomScale, scrollerViewHight*scrollView.zoomScale);
//            } else {
//                
//                
//                if (i>index) {
//                    
//                    view.frame = CGRectMake(itemWidth*i+(scrollerViewWidth*scrollView.zoomScale-itemWidth), scrollerViewHight-scrollerViewHight*scrollView.zoomScale, view.frame.size.width,view.frame.size.height);
//                } else {
//                    
//                    view.frame = CGRectMake(itemWidth*i, scrollerViewHight-scrollerViewHight*scrollView.zoomScale, view.frame.size.width,view.frame.size.height);
//                }
//            }
//            
//        }
//        
//         scrollView.contentSize = CGSizeMake(self.arrayOK.count * itemWidth +scrollView.subviews[index].frame.size.width*_scrollerview.zoomScale-scrollView.subviews[index].frame.size.width, scrollView.subviews[index].frame.size.height*_scrollerview.zoomScale-scrollView.subviews[index].frame.size.height);
// 
//    }

//    NSInteger index = scrollView.contentOffset.x/itemWidth;
//    if (scrollView.subviews[index].center.x != scrollerViewWidth / 2 || scrollView.subviews[index].center.y != scrollerViewHight / 2) {
    
//        scrollView.subviews[index].center = CGPointMake(_scrollerview.contentSize.width / 2, _scrollerview.contentSize.height / 2);
//    }
//    else {
//         scrollView.subviews[index].center = self.view.center;
//    }
    
//    if (_scrollerview.zoomScale < 1) {
//        
//        scrollView.contentOffset = CGPointMake(0, 0);
//        
//    } else {
//        
//        scrollView.contentOffset = CGPointMake((scrollView.subviews[index].size.width - scrollView.subviews[index].size.width*_scrollerview.zoomScale)/2, (scrollView.subviews[index].size.height - scrollView.subviews[index].size.height*_scrollerview.zoomScale)/2);
//    }
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
//}

// 滑动减速时调用该方法。
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    
//    NSLog(@"scrollViewWillBeginDecelerating");
//    // 该方法在scrollViewDidEndDragging方法之后。
//    
////    _scrollerview.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y);
//}



/**
 *  固定一个大小宽／高  来缩放图片比例
 *
 *  @param modifyImage    需要缩放的图片
 *  @param fixedSize      固定的大小  宽度／高度
 *  @param proportionSize 原有图片的大小 宽度／高度 （用于获取缩放比例的依据）
 *  @param viewSize       固定的大小 宽度／高度
 *  @param justmentSize   缩放的大小 宽度／高度
 *
 *  @return 缩放后的图片
 */
//- (UIImage *)zoomImageWithImager:(UIImage *)modifyImage
//                           Fixed:(NSInteger )fixedSize
//                      proportion:(NSInteger )proportionSize
//                            view:(NSInteger )viewSize
//                        justment:(NSInteger )justmentSize{
//
//    CGFloat fixed = fixedSize;
//    CGFloat proportion =  (proportionSize - viewSize)/proportionSize;
//    CGFloat justment = justmentSize -  (justmentSize*proportion);
//    CGSize imageSize = CGSizeMake(fixed, justment);
//    UIImage *image = [self imageWithImage:modifyImage scaledToSize:imageSize];
//    return image;
//
//
//}


@end
