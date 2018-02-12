//
//  CarouselScrollView.h
//  itop
//
//  Created by huangli on 2018/1/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FGGImageClickBlock)(NSInteger indexPath);
typedef void (^FGGImageScrolledBlock)(NSInteger indexPath);
typedef void (^FGGTagScrolledBlock)(NSInteger indexPath);

@interface CarouselScrollView : UIView<UIScrollViewDelegate>

/**点击照片的回调*/
@property(nonatomic,copy,readonly)FGGImageClickBlock    didSelectedImageAtIndex;
@property(nonatomic,copy) FGGImageScrolledBlock         imageDidScrolledBlock;
@property(nonatomic,copy) FGGTagScrolledBlock           tagDidScrolledBlock;

/**
 *    图片的urlString链接数组
 *
 *    可以通过调用其set方法，来重载数据源和视图
 */
@property(nonatomic,strong)NSArray *imageURLArray;

/**
 *  加载网络图片滚动
 *
 *  @param frame    frame
 *  @param URLArray 包含图片URL字符串的数组
 *  @param didSelectedImageAtIndex 点击图片时回调的block
 *
 *  @return FGGAutoScrollView对象
 */
-(instancetype)initWithFrame:(CGRect)frame placeHolderImage:(UIImage *)placeHolderImage imageURLs:(NSArray *)URLArray imageDidSelectedBlock:(FGGImageClickBlock) didSelectedImageAtIndex;


-(void)initTimer;
-(void)stopTimer;

-(void)createTopScrollView;
-(void)createAutoCarouselScrollView;
-(void)createdesignerScrollView;
-(void)createTagScrollView;


@end
