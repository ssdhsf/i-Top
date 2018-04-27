//
//  CarouselScrollView.m
//  itop
//
//  Created by huangli on 2018/1/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CarouselScrollView.h"
#import "UIImageView+WebCache.h"
#import "HomeCollectionViewCell.h"
#import "TagView.h"
#import "CustomRequirementsStoreCell.h"

/**
 *  滚动时间间隔 可以自己修改
 */
static double kFGGScrollInterval = 5.0f;

@interface CarouselScrollView()
/**
 *  滚动视图对象（只读）
 */
@property(nonatomic,strong,readonly)UIScrollView        *scroll;

@end

@implementation CarouselScrollView{
    
    //定时器
    NSTimer *_timer;
    //页码控制器
    UIPageControl *_pageControl;
    /**默认图片*/
    UIImage *_placeHolderImage;
}

//加载网络图片的方法
-(instancetype)initWithFrame:(CGRect)frame placeHolderImage:(UIImage *)placeHolderImage imageURLs:(NSArray *)URLArray imageDidSelectedBlock:(FGGImageClickBlock)didSelectedImageAtIndex{
    
    if(self=[super initWithFrame:frame]){
        
        _placeHolderImage=placeHolderImage;
        _imageURLArray=URLArray;
        _didSelectedImageAtIndex=didSelectedImageAtIndex;
//        [self createAutoCarouselScrollView];
    }
    return self;
}

//构建循环滚动视图
-(void)createAutoCarouselScrollView{
    
    if(_scroll){
        
        for(UIView *sub in _scroll.subviews)
            [sub removeFromSuperview];
        [_scroll removeFromSuperview];
        _scroll=nil;
    }
    _scroll=[[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:_scroll];
    _scroll.delegate = self;
    _scroll.contentSize = CGSizeMake((_imageURLArray.count+1)*self.bounds.size.width, self.bounds.size.height);
    
    _scroll.pagingEnabled=YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    [self initTimer];
        for(int i = 0;i <= _imageURLArray.count;i++){
        
        CGFloat xpos = i*self.bounds.size.width;
        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(xpos, 0, self.bounds.size.width, self.bounds.size.height)];
        
        //设置灰色底
        imv.image = _placeHolderImage;
        imv.userInteractionEnabled = YES;
        
        //添加点击图片的手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)];
        [imv addGestureRecognizer:tap];
        [_scroll addSubview:imv];
//        NSString *urlString;
            HomeBanner *banner;
        if(i<_imageURLArray.count)
            banner = _imageURLArray[i];
        else
            banner = _imageURLArray[0];
        NSURL *url = [NSURL URLWithString:banner.img];
        [imv sd_setImageWithURL:url placeholderImage:nil options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            imv.clipsToBounds = YES;
            imv.contentMode = UIViewContentModeScaleAspectFill;
    }
    if(_pageControl)
        _pageControl = nil;
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height-10);
    _pageControl.numberOfPages = _imageURLArray.count-1;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self addSubview:_pageControl];
}

-(void)createTopScrollView{
    
    if(_scroll){
        
        for(UIView *sub in _scroll.subviews)
            [sub removeFromSuperview];
        [_scroll removeFromSuperview];
        _scroll = nil;
    }
    _scroll.pagingEnabled = YES;
    _scroll = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:_scroll];
    _scroll.delegate = self;
    
    NSInteger page= _imageURLArray.count/3;
    
    if (_imageURLArray.count%3 != 0) {
        page = page +1;
    }
    _scroll.pagingEnabled=YES;
    _scroll.contentSize = CGSizeMake(page*ScreenWidth, self.bounds.size.height);
    
    _scroll.showsHorizontalScrollIndicator = NO;
    for(int i = 0;i < _imageURLArray.count;i++){
        
         H5List *h5 = _imageURLArray[i];
        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(43/2+i*(self.frame.size.width/3), 5,  self.frame.size.width/3-43, (self.frame.size.width/3-43)*1.7)];
        //设置灰色底
        imv.image = _placeHolderImage;
        imv.userInteractionEnabled = YES;
        
        //添加点击图片的手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapH5Image:)];
//        tap.numberOfTapsRequired = i;
        [imv addGestureRecognizer:tap];
        imv.tag = i;
        
        UILabel *NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(43/2+i*(self.frame.size.width/3), CGRectGetMaxY(imv.frame)+7, self.frame.size.width/3-43,16)];
        NameLabel.textAlignment = NSTextAlignmentLeft;
        NameLabel.font = [UIFont systemFontOfSize:12];
        
        UILabel *workLabel = [[UILabel alloc]initWithFrame:CGRectMake(43/2+i*(self.frame.size.width/3), CGRectGetMaxY(NameLabel.frame)+9, self.frame.size.width/3-43,16)];
        workLabel.textAlignment = NSTextAlignmentLeft;
        workLabel.font = [UIFont systemFontOfSize:12];
        workLabel.textColor = UIColorFromRGB(0xeb6ea5);
        
        
        NSInteger saleLabelWith = [[Global sharedSingleton]widthForString:[NSString stringWithFormat:@"  %@人使用",[Global stringIsNullWithString:h5.sale_count] ? @"0" : h5.sale_count] fontSize:7 andHeight:10];
        UILabel *saleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(imv.frame)+7, CGRectGetMaxY(imv.frame)-15, saleLabelWith+10, 10)];
        
        saleLabel.text = [NSString stringWithFormat:@"  %@人使用",[Global stringIsNullWithString:h5.sale_count] ? @"0" : h5.sale_count];
        saleLabel.backgroundColor = [UIColor colorWithRed:((float)((0xcbe8f3 & 0xFF0000) >> 16))/255.0 green:((float)((0xcbe8f3 & 0xFF00) >> 8))/255.0 blue:((float)(0xcbe8f3 & 0xFF))/255.0 alpha:0.5];
        saleLabel.layer.cornerRadius = 5;
        saleLabel.layer.masksToBounds = YES;
        saleLabel.textColor = [UIColor whiteColor];
        saleLabel.font = [UIFont systemFontOfSize:7];
        
        [_scroll addSubview:NameLabel];
        [_scroll addSubview:workLabel];
        [_scroll addSubview:imv];
        [_scroll addSubview:saleLabel];
       
        [imv sd_setImageWithURL:[NSURL URLWithString:h5.cover_img] placeholderImage:H5PlaceholderImage options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];

        NameLabel.text = h5.title;
        workLabel.text = h5.praise_count;
    }
}

-(void)createdesignerScrollView{
    
    if(_scroll){
        
        for(UIView *sub in _scroll.subviews)
            [sub removeFromSuperview];
        [_scroll removeFromSuperview];
        _scroll=nil;
    }
    
    NSLog(@"%f", self.bounds.size.height);
    _scroll=[[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:_scroll];
    _scroll.delegate = self;
    NSInteger page= _imageURLArray.count/3;
    
    if (_imageURLArray.count%3 != 0) {
        page = page +1;
    }
    _scroll.contentSize = CGSizeMake(page*ScreenWidth, self.bounds.size.height);
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    for(int i = 0;i < _imageURLArray.count;i++){
        
        DesignerList *designer = _imageURLArray[i];
        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(35/2+i*(self.frame.size.width/3), 5,  self.frame.size.width/3-35, self.frame.size.width/3-35)];
        //设置灰色底
        imv.image = _placeHolderImage;
        imv.userInteractionEnabled = YES;
        imv.layer.cornerRadius = imv.frame.size.height/2;
        imv.layer.masksToBounds = YES;
        //添加点击图片的手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDesignImage:)];
//        tap.numberOfTapsRequired = i;
        [self addGestureRecognizer:tap];
        self.tag = i;
        
        UILabel *NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*(self.frame.size.width/3)+20, CGRectGetMaxY(imv.frame)+18,  80,16)];
        NameLabel.textAlignment = NSTextAlignmentCenter;
        NameLabel.font = [UIFont systemFontOfSize:12];
        
        
//        NSInteger workLabelHeight = [Global heightWithString:designer.field width:ScreenWidth/3-40 fontSize:12];
        UILabel *workLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*(self.frame.size.width/3)+20, CGRectGetMaxY(NameLabel.frame)+5, ScreenWidth/3-40,32)];
        workLabel.textAlignment = NSTextAlignmentCenter;
        workLabel.font = [UIFont systemFontOfSize:12];
        workLabel.numberOfLines = 0;
        
        
        UIButton *focus = [[UIButton alloc]initWithFrame:CGRectMake((i*(self.frame.size.width/3))+((self.frame.size.width/3)/2-20), CGRectGetMaxY(self.frame)-21, 40,16)];
        
        if ([designer.follow integerValue]== 1) {

            focus.frame = CGRectMake((i*(self.frame.size.width/3))+((self.frame.size.width/3)/2-30), CGRectGetMaxY(workLabel.frame)+8, 50,16);
            [focus setTitle:FOCUSSTATETITLE_FOCUS forState:UIControlStateNormal];
        } else {
            
            focus.frame = CGRectMake((i*(self.frame.size.width/3))+((self.frame.size.width/3)/2-20),  CGRectGetMaxY(workLabel.frame)+8, 40,16);
            [focus setTitle:FOCUSSTATETITLE_NOFOCUS forState:UIControlStateNormal];
            
        }
        [focus.layer insertSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(focus) atIndex:0];
        [focus setFont:[UIFont systemFontOfSize:12]];
        focus.tag = i;
        [focus addTarget:self action:@selector(focus:) forControlEvents:UIControlEventTouchDown];
        focus.layer.cornerRadius = 2;
        focus.layer.masksToBounds = YES;
        
        
        [_scroll addSubview:NameLabel];
        [_scroll addSubview:workLabel];
        [_scroll addSubview:focus];
        [_scroll addSubview:imv];
        [imv sd_setImageWithURL:[NSURL URLWithString:designer.head_img] placeholderImage:PlaceholderImage options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];

        NameLabel.text = designer.nickname;
        workLabel.text = designer.field;
    }
}

-(void)createTagScrollView{
    
    if(_scroll){
        
        for(UIView *sub in _scroll.subviews)
            [sub removeFromSuperview];
        [_scroll removeFromSuperview];
        _scroll = nil;
    }
    _scroll = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:_scroll];
    _scroll.delegate = self;
    
    NSInteger page= _imageURLArray.count/6;
    
    if (_imageURLArray.count%6 != 0) {
        page = page +1;
    }
    
    _scroll.contentSize = CGSizeMake(page*ScreenWidth, self.bounds.size.height);
    
    _scroll.pagingEnabled=YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    for(int i = 0;i < _imageURLArray.count;i++){ //TODO
        
        TagView *cell = [[TagView alloc]init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTagImage:)];
        [cell addGestureRecognizer:tap];
        cell.tag = i;
        
        if ((i/3)%2<1) {
            
            NSLog(@"%f",((i/6)*self.frame.size.width));
             cell.frame = CGRectMake((i%3)*(ScreenWidth/3)+((i/6)*ScreenWidth), 0,  ScreenWidth/3, ScreenWidth/3-102+19+5+9+5);
            
            NSLog(@"%f--%f",cell.frame.origin.x,cell.frame.origin.y);
        } else {
        
            CGFloat replenish = 0;
            
            if (ScreenWidth/3-102 < 23) {
                
                replenish = 20;
            }
            cell.frame = CGRectMake((i%3)*(ScreenWidth/3)+((i/6)*ScreenWidth), ScreenWidth/3-102+19+5+9+5+replenish,  ScreenWidth/3, ScreenWidth/3-102+19+5+9+5);
             NSLog(@"%f--%f",cell.frame.origin.x,cell.frame.origin.y);
        }
        
        [_scroll addSubview:cell];
        TagList *h5 = _imageURLArray[i];
        [cell setItmeOfModel:h5 tapTag:i];
    }
}

-(void)createCustromScrollView{
    
    if(_scroll){
        
        for(UIView *sub in _scroll.subviews)
            [sub removeFromSuperview];
        [_scroll removeFromSuperview];
        _scroll=nil;
    }
    
    NSLog(@"%f", self.bounds.size.height);
    _scroll=[[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:_scroll];
    _scroll.delegate = self;
    NSInteger page= _imageURLArray.count;
    _scroll.contentSize = CGSizeMake(page*ScreenWidth, self.bounds.size.height);
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    for(int i = 0;i < _imageURLArray.count;i++){
        
        CustomRequirements *custom = _imageURLArray[i];
        CustomRequirementsStoreCell *cell =  [[[NSBundle mainBundle] loadNibNamed:@"CustomRequirementsStoreCell" owner:nil options:nil] lastObject];
        cell.frame = CGRectMake(i*ScreenWidth, 0, ScreenWidth, self.height);
        cell.buttonTag = i;
        [_scroll addSubview:cell];
        [cell setItmeOfModel:custom];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCustrom:)];
        //        tap.numberOfTapsRequired = i;
        [self addGestureRecognizer:tap];
        self.tag = i;
    }
}

/**
 *  自动循环滚动
 */
-(void)automaticScroll{
    
    if (self.tag == 0 ) {
        if(_imageURLArray.count>0){
            
            NSInteger index = _scroll.contentOffset.x/self.bounds.size.width;
            index++;
            if(self.imageDidScrolledBlock)
                self.imageDidScrolledBlock(index);
            
            __weak typeof(self) weakSelf = self;
            //添加滚动动画
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.scroll.contentOffset = CGPointMake(index*self.bounds.size.width, 0);
            } completion:^(BOOL finished) {
                
                _pageControl.currentPage = index;
                if (index == _imageURLArray.count-1) {
                    self.scroll.contentOffset = CGPointMake(0, 0);
                    _pageControl.currentPage = 0;
                }
                
            }];
        }
 
    }
}

//点击图片时回调代码块
-(void)tapImage{
    
    if(self.didSelectedImageAtIndex){
        
        self.didSelectedImageAtIndex(_pageControl.currentPage);
    }
}

-(void)tapH5Image:(UITapGestureRecognizer *)tap{
    
    if(self.didSelectedImageAtIndex){
        UIView *view = tap.view;
        self.didSelectedImageAtIndex(view.tag);
    }
}

-(void)tapDesignImage:(UITapGestureRecognizer *)tap{
    
    if(self.didSelectedImageAtIndex){
        
        UIView *view = tap.view;
        self.didSelectedImageAtIndex(view.tag);
    }
}

-(void)tapTagImage:(UITapGestureRecognizer *)tap{
    
    if(_tagDidScrolledBlock){
        
        UIView *view = tap.view;
        self.tagDidScrolledBlock(view.tag);
    }
}

-(void)tapCustrom:(UITapGestureRecognizer *)tap{
    
    if(self.didSelectedImageAtIndex){
        UIView *view = tap.view;
        self.didSelectedImageAtIndex(view.tag);
    }
}

/**图片数组的setter方法*/
-(void)setImageURLArray:(NSArray *)imageURLArray{
    
    if(![imageURLArray isKindOfClass:[NSArray class]])
        return;
    _imageURLArray = imageURLArray;
    if(_imageURLArray.count == 0)
        return;
//    [self createAutoCarouselScrollView];
}

#pragma mark - UIScrollView
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   
    if (self.tag == 0) {
        
        NSInteger index = _scroll.contentOffset.x/self.bounds.size.width;
        if(index == _imageURLArray.count-1)
            index = 0;
        if(self.imageDidScrolledBlock)
            self.imageDidScrolledBlock(index);
        _pageControl.currentPage = index;
        _scroll.contentOffset = CGPointMake(self.bounds.size.width*index, 0);
    }
    
    if (self.tag == 0) {
            [self initTimer];
    }
//开启定时器
//    [_timer setFireDate:[NSDate distantPast]]; //开启定时器
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
   
    if (self.tag == 0) {
        [self stopTimer];
    }
     // 取消定时器
    //    [_timer setFireDate:[NSDate distantFuture]];//暂定定时器
}

-(void)initTimer{
    
    if(_timer){
        
        [self stopTimer];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:kFGGScrollInterval
                                              target:self
                                            selector:@selector(automaticScroll)
                                            userInfo:nil
                                             repeats:YES];
}

-(void)stopTimer{
    
    [_timer invalidate]; // 取消定时器
    _timer = nil;
}

-(void)focus:(UIButton *)button{
    
    DesignerList *designer = _imageURLArray[button.tag];
    [[UserManager shareUserManager]focusOnUserWithUserId:[NSString stringWithFormat:@"%@",designer.id] focusType:[designer.follow integerValue]];
    [UserManager shareUserManager].focusOnUserSuccess = ^ (id obj){
        
        if ([button.titleLabel.text isEqualToString:FOCUSSTATETITLE_NOFOCUS]) {
            
            designer.follow = @1;
            [self setupFocusStateWithButton:button isFocus:YES];
            [[Global sharedSingleton]showToastInCenter:self withMessage:FOCUSSTATETITLE_SUCCESSFOCUS];
        } else {
            
            designer.follow = @0;
            [self setupFocusStateWithButton:button isFocus:NO];
            [[Global sharedSingleton]showToastInCenter:self withMessage:FOCUSSTATETITLE_CANCELFOCUS];
        }
    };
}

#pragma mark 改变热点FocusButton状态
-(void)setupFocusStateWithButton:(UIButton *)button isFocus:(BOOL)animation{
    
    if (animation) {
        
        button.frame = CGRectMake(CGRectGetMinX(button.frame)-5, CGRectGetMinY(button.frame), 50,16);
        [button setTitle:FOCUSSTATETITLE_FOCUS forState:UIControlStateNormal];
    }else {
        
        button.frame = CGRectMake(CGRectGetMinX(button.frame)+5, CGRectGetMinY(button.frame), 40,16);
        [button setTitle:FOCUSSTATETITLE_NOFOCUS forState:UIControlStateNormal];

    }
    [button.layer insertSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(button) atIndex:0];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 2;
}


@end
