//
//  YZTagList.m
//  Hobby
//
//  Created by yz on 16/8/14.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "YZTagList.h"
#import "YZTagButton.h"

CGFloat const imageViewWH = 20;

@interface YZTagList ()
{
    NSMutableArray *_tagArray;
}
@property (nonatomic, weak) UICollectionView *tagListView;
@property (nonatomic, strong) NSMutableDictionary *tags;
@property (nonatomic, strong) NSMutableArray *tagButtons;
/**
 *  需要移动的矩阵
 */
@property (nonatomic, assign) CGRect moveFinalRect;
@property (nonatomic, assign) CGPoint oriCenter;
@end

@implementation YZTagList

- (NSMutableArray *)tagArray
{
    if (_tagArray == nil) {
        _tagArray = [NSMutableArray array];
    }
    return _tagArray;
}
- (NSMutableArray *)tagButtons
{
    if (_tagButtons == nil) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

- (NSMutableDictionary *)tags
{
    if (_tags == nil) {
        _tags = [NSMutableDictionary dictionary];
    }
    return _tags;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

#pragma mark - 初始化
- (void)setup
{
    _tagMargin = 10;
    _tagColor = [UIColor redColor];
    _tagButtonMargin = 5;
    _tagCornerRadius = 5;
    _borderWidth = 0;
    _borderColor = _tagColor;
    _tagListCols = 4;
    _scaleTagInSort = 1;
    _isFitTagListH = YES;
    _tagFont = [UIFont systemFontOfSize:15];
    self.clipsToBounds = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _tagListView.frame = self.bounds;
}

- (void)setScaleTagInSort:(CGFloat)scaleTagInSort
{
    if (_scaleTagInSort < 1) {
        @throw [NSException exceptionWithName:@"YZError" reason:@"(scaleTagInSort)缩放比例必须大于1" userInfo:nil];
    }
    _scaleTagInSort = scaleTagInSort;
}

- (CGFloat)tagListH
{
    if (self.tagButtons.count <= 0) return 0;
    return CGRectGetMaxY([self.tagButtons.lastObject frame]) + _tagMargin;
}

#pragma mark - 操作标签方法
// 添加多个标签
//- (void)addTags:(NSArray *)tagStrs action:(SEL)action
//{
//    if (self.frame.size.width == 0) {
//        @throw [NSException exceptionWithName:@"YZError" reason:@"先设置标签列表的frame" userInfo:nil];
//    }
//    
//    for (SpecialityTag *tagStr in tagStrs) {
//        [self addTag:tagStr action:action];
//    }
//}

// 添加标签
- (void)addFieldTag:(NSArray *)tagArray action:(SEL)action{
    
    for (TagList *tagStr in tagArray) {
        Class tagClass = _tagClass?_tagClass : [YZTagButton class];
        
        // 创建标签按钮
        YZTagButton *tagButton = [tagClass buttonWithType:UIButtonTypeCustom];
        if (_tagClass == nil) {
            tagButton.margin = _tagButtonMargin;
        }
        
        tagButton.layer.cornerRadius = 0;
        if ([tagStr.name isEqualToString:@"最多选3个"] || tagStr.selecteTag.selecteTag == YES) {
            
            tagButton.layer.borderWidth = 0;
        } else {
            
            tagButton.layer.borderWidth = _borderWidth;
        }
        
        tagButton.selected = tagStr.selecteTag.selecteTag;
        if (tagStr.selecteTag.selecteTag == YES) {
            
            [tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tagButton setBackgroundColor:UIColorFromRGB(0xcbedfb)];
            
        }else {
            
            [tagButton setTitleColor:_tagColor forState:UIControlStateNormal];
            [tagButton setBackgroundColor:_tagBackgroundColor];
            
        }

        // 保存到字典
        [self.tags setObject:tagButton forKey:tagStr];
        [self.tagArray addObject:tagStr];
        [self generalSetupWithButton:tagButton action:action tag:tagStr.name];
    }
}

// 添加搜索标签
- (void)addSearchListTag:(NSArray *)tagArray action:(SEL)action{
    
    for (NSString *tag in tagArray) {
        
        Class tagClass = _tagClass?_tagClass : [YZTagButton class];
        
        // 创建标签按钮
        YZTagButton *tagButton = [tagClass buttonWithType:UIButtonTypeCustom];
        if (_tagClass == nil) {
            tagButton.margin = _tagButtonMargin;
        }
        
        tagButton.layer.cornerRadius = 0;
        [tagButton setTitleColor:_tagColor forState:UIControlStateNormal];
        [tagButton setBackgroundColor:_tagBackgroundColor];
        [self generalSetupWithButton:tagButton action:action tag:tag];
    }
}

- (void)addOperationDemandListTag:(NSArray *)tagArray action:(SEL)action{

    for (NSString *tag in tagArray) {
        
        Class tagClass = _tagClass?_tagClass : [YZTagButton class];
        
        // 创建标签按钮
        YZTagButton *tagButton = [tagClass buttonWithType:UIButtonTypeCustom];
        if (_tagClass == nil) {
            tagButton.margin = _tagButtonMargin;
        }
        
        tagButton.layer.cornerRadius = 0;
        [tagButton setTitleColor:_tagColor forState:UIControlStateNormal];
        [tagButton setBackgroundColor:_tagBackgroundColor];
        
        [self generalSetupWithButton:tagButton action:action tag:tag];
        [tagButton.layer insertSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(tagButton) atIndex:0];
        [tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}


-(void)generalSetupWithButton:(UIButton *)tagButton action:(SEL)action tag:(NSString *)tag{
    
    tagButton.layer.borderColor = _borderColor.CGColor;
    tagButton.clipsToBounds = YES;
    tagButton.tag = self.tagButtons.count;
    [tagButton setImage:_tagDeleteimage forState:UIControlStateNormal];
    [tagButton setTitle:tag forState:UIControlStateNormal];
    [tagButton setBackgroundImage:_tagBackgroundImage forState:UIControlStateNormal];
    tagButton.titleLabel.font = _tagFont;
    [tagButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    if (_isSort) {
        // 添加拖动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [tagButton addGestureRecognizer:pan];
    }
    
    //    NSLog(@"%.f",tagButton.frame);
    [self addSubview:tagButton];
    
    // 保存到数组
    [self.tagButtons addObject:tagButton];
    
    [self.tags setObject:tagButton forKey:tag];
    [self.tagArray addObject:tag];

    // 设置按钮的位置
    [self updateTagButtonFrame:tagButton.tag extreMargin:YES];
    
    // 更新自己的高度
    if (_isFitTagListH) {
        CGRect frame = self.frame;
        frame.size.height = self.tagListH;
        self.frame = frame;
        //        [UIView animateWithDuration:0.25 animations:^{
        //            self.frame = frame;
        //        }];
    }
}

// 点击标签 设计师选择领域
- (void)fieldTag:(UIButton *)button{
    if (_fieldTagBlock && ![button.currentTitle isEqualToString:@"最多选3个"]) {
        _fieldTagBlock(button.currentTitle, button.selected);
    }
}

// 点击标签 搜索历史
- (void)searchListTag:(UIButton *)button{
    if (_searchListTagBlock ) {
        _searchListTagBlock(button.currentTitle);
    }
}

// 点击标签  状态操作
- (void)operationDemandListTagTag:(UIButton *)button{
    if (_operationDemandListTagBlock ) {
        _operationDemandListTagBlock(button.currentTitle);
    }
}

- (void)rechargeTag:(UIButton *)button{
    if (_fieldTagBlock) {
        _fieldTagBlock(button.currentTitle, button.selected);
    }
}

// 拖动标签
- (void)pan:(UIPanGestureRecognizer *)pan
{
    // 获取偏移量
    CGPoint transP = [pan translationInView:self];
    
    UIButton *tagButton = (UIButton *)pan.view;
  
    // 开始
    if (pan.state == UIGestureRecognizerStateBegan) {
        _oriCenter = tagButton.center;
        [UIView animateWithDuration:-.25 animations:^{
            tagButton.transform = CGAffineTransformMakeScale(_scaleTagInSort, _scaleTagInSort);
        }];
        [self addSubview:tagButton];
    }
    
    CGPoint center = tagButton.center;
    center.x += transP.x;
    center.y += transP.y;
    tagButton.center = center;
    
    
    
    // 改变
    if (pan.state == UIGestureRecognizerStateChanged) {
        
        // 获取当前按钮中心点在哪个按钮上
        UIButton *otherButton = [self buttonCenterInButtons:tagButton];
        
        if (otherButton) { // 插入到当前按钮的位置
            // 获取插入的角标
            NSInteger i = otherButton.tag;
            
            // 获取当前角标
            NSInteger curI = tagButton.tag;
            
            _moveFinalRect = otherButton.frame;
            
            // 排序
            // 移除之前的按钮
            [self.tagButtons removeObject:tagButton];
            [self.tagButtons insertObject:tagButton atIndex:i];
            
            [self.tagArray removeObject:tagButton.currentTitle];
            [self.tagArray insertObject:tagButton.currentTitle atIndex:i];
            
            // 更新tag
            [self updateTag];

            if (curI > i) { // 往前插
                
                // 更新之后标签frame
                [UIView animateWithDuration:0.25 animations:^{
                    [self updateLaterTagButtonFrame:i + 1];
                }];
                
            } else { // 往后插
                
                // 更新之前标签frame
                [UIView animateWithDuration:0.25 animations:^{
                    [self updateBeforeTagButtonFrame:i];
                }];
            }
        }
        
    }
    
    // 结束
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:0.25 animations:^{
            tagButton.transform = CGAffineTransformIdentity;
            if (_moveFinalRect.size.width <= 0) {
                tagButton.center = _oriCenter;
            } else {
                tagButton.frame = _moveFinalRect;
            }
        } completion:^(BOOL finished) {
            _moveFinalRect = CGRectZero;
        }];
        
    }
    
    [pan setTranslation:CGPointZero inView:self];
}

// 看下当前按钮中心点在哪个按钮上
- (UIButton *)buttonCenterInButtons:(UIButton *)curButton
{
    for (UIButton *button in self.tagButtons) {
        if (curButton == button) continue;
        if (CGRectContainsPoint(button.frame, curButton.center)) {
            return button;
        }
    }
    return nil;
}

// 删除标签
- (void)deleteTag:(NSString *)tagStr
{
    // 获取对应的标题按钮
    YZTagButton *button = self.tags[tagStr];
    
    // 移除按钮
    [button removeFromSuperview];
    
    // 移除数组
    [self.tagButtons removeObject:button];
    
    // 移除字典
    [self.tags removeObjectForKey:tagStr];
    
    // 移除数组
    [self.tagArray removeObject:tagStr];
    
    // 更新tag
    [self updateTag];
    
    // 更新后面按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateLaterTagButtonFrame:button.tag];
    }];
    
    // 更新自己的frame
    if (_isFitTagListH) {
        CGRect frame = self.frame;
        frame.size.height = self.tagListH;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = frame;
        }];
    }
}

// 更新标签
- (void)updateTag
{
    NSInteger count = self.tagButtons.count;
    for (int i = 0; i < count; i++) {
        UIButton *tagButton = self.tagButtons[i];
        tagButton.tag = i;
    }
}

// 更新之前按钮
- (void)updateBeforeTagButtonFrame:(NSInteger)beforeI
{
    for (int i = 0; i < beforeI; i++) {
        // 更新按钮
        [self updateTagButtonFrame:i extreMargin:NO];
    }
}

// 更新以后按钮
- (void)updateLaterTagButtonFrame:(NSInteger)laterI
{
    NSInteger count = self.tagButtons.count;
    
    for (NSInteger i = laterI; i < count; i++) {
        // 更新按钮
        [self updateTagButtonFrame:i extreMargin:NO];
    }
}

- (void)updateTagButtonFrame:(NSInteger)i extreMargin:(BOOL)extreMargin
{
    // 获取上一个按钮
    NSInteger preI = i - 1;
    
    // 定义上一个按钮
    UIButton *preButton;
    
    // 过滤上一个角标
    if (preI >= 0) {
        preButton = self.tagButtons[preI];
    }
 
    // 获取当前按钮
    YZTagButton *tagButton = self.tagButtons[i];
    // 判断是否设置标签的尺寸
    if (_tagSize.width == 0) { // 没有设置标签尺寸
        // 自适应标签尺寸
        // 设置标签按钮frame（自适应）
        [self setupTagButtonCustomFrame:tagButton preButton:preButton extreMargin:extreMargin];
    } else { // 按规律排布
        // 计算标签按钮frame（regular）
        [self setupTagButtonRegularFrame:tagButton];
    }
}

// 计算标签按钮frame（按规律排布）
- (void)setupTagButtonRegularFrame:(UIButton *)tagButton
{
    // 获取角标
    NSInteger i = tagButton.tag;
    NSInteger col = i % _tagListCols;
    NSInteger row = i / _tagListCols;
    CGFloat btnW = _tagSize.width;
    CGFloat btnH = _tagSize.height;
    NSInteger margin = (self.bounds.size.width - _tagListCols * btnW - 2 * _tagMargin) / (_tagListCols - 1);
    CGFloat btnX = _tagMargin + col * (btnW + margin);;
    CGFloat btnY = _tagMargin + row * (btnH + margin);
    tagButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
}

// 设置标签按钮frame（自适应）
- (void)setupTagButtonCustomFrame:(UIButton *)tagButton preButton:(UIButton *)preButton extreMargin:(BOOL)extreMargin
{
    // 等于上一个按钮的最大X + 间距
    CGFloat btnX = CGRectGetMaxX(preButton.frame) + _tagMargin;
    
    // 等于上一个按钮的Y值,如果没有就是标签间距
    CGFloat btnY = preButton? preButton.frame.origin.y : _tagMargin;
    
    // 获取按钮宽度
    CGFloat titleW = [tagButton.titleLabel.text sizeWithFont:_tagFont].width;
    CGFloat titleH = [tagButton.titleLabel.text sizeWithFont:_tagFont].height;
    CGFloat btnW = extreMargin?titleW + 2 * _tagButtonMargin : tagButton.bounds.size.width ;
    if (_tagDeleteimage && extreMargin == YES) {
        btnW += imageViewWH;
        btnW += _tagButtonMargin;
    }
    
    // 获取按钮高度
    CGFloat btnH = extreMargin? titleH + 2 * _tagButtonMargin:tagButton.bounds.size.height;
    if (_tagDeleteimage && extreMargin == YES) {
        CGFloat height = imageViewWH > titleH ? imageViewWH : titleH;
        btnH = height + 2 * _tagButtonMargin;
    }
    
    // 判断当前按钮是否足够显示
    CGFloat rightWidth = (self.bounds.size.width-10) - btnX;
    
    if (rightWidth <= btnW) {
        // 不够显示，显示到下一行
        btnX = _tagMargin;
        btnY = CGRectGetMaxY(preButton.frame) + _tagMargin;
    }
    
    tagButton.frame = CGRectMake(btnX, btnY, btnW+btnH/2, btnH);
    tagButton.layer.cornerRadius = _tagCornerRadius;
}

@end
