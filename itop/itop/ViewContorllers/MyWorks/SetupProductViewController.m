//
//  SetupProductViewController.m
//  itop
//
//  Created by huangli on 2018/3/12.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SetupProductViewController.h"
#import "LMJDropdownMenu.h"
#import "HomeStore.h"

@interface SetupProductViewController ()<UITextViewDelegate,SubmitFileManagerDelegate,SubmitFileManagerDelegate,LMJDropdownMenuDelegate,SegmentTapViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *titleTV;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UIButton *shearIconButton;
@property (weak, nonatomic) IBOutlet UILabel *stringCount;
@property (weak, nonatomic) IBOutlet UILabel *producContentCount;
@property (strong, nonatomic) UIImageView *shear_cover;
@property (strong, nonatomic) UIImageView *product_cover;
@property (strong, nonatomic) UIImage *selectProsuctCover;
@property (strong, nonatomic) UIImage *selectShearCover;
@property (strong, nonatomic) NSArray *views;
@property (weak, nonatomic) IBOutlet UIButton *saveShearSetupButton;
@property (strong, nonatomic) NSMutableArray *h5TypeArray; //选择h5类型
@property (strong, nonatomic) NSMutableArray *useArray;     //选择用途
@property (strong, nonatomic) NSMutableArray *industryArray; //选择行业
@property (strong, nonatomic) NSMutableArray *technologyArray;   //选择技术
@property (strong, nonatomic) NSMutableArray *styleArray;   //选择分格

@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, assign)NSInteger itmeIndex;//当前的选项

@property (weak, nonatomic) IBOutlet LMJDropdownMenu *useLMJDropdownMenu;
@property (weak, nonatomic) IBOutlet LMJDropdownMenu *industryLMJDropdownMenu;
@property (weak, nonatomic) IBOutlet LMJDropdownMenu *technologyLMJDropdownMenu;
@property (weak, nonatomic) IBOutlet LMJDropdownMenu *styleLMJDropdownMenu;

@property (weak, nonatomic) IBOutlet UILabel *h5TypeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *useTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *industryTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *technologyTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *styleTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *productCoveImage;
@property (weak, nonatomic) IBOutlet UITextView *productName;
@property (weak, nonatomic) IBOutlet UITextView *productPrice;
@property (weak, nonatomic) IBOutlet UITextView *productDiscription;

@property (strong, nonatomic) NSMutableArray *sceneTempArray;
@property (strong, nonatomic) NSMutableArray *oneTempArray;
@property (strong, nonatomic) NSMutableArray *vidoeTempArray;
@property (strong, nonatomic) NSArray *allTagArray;

@end

@implementation SetupProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initNavigationBarItems{
    
    self.title = _product.title;
    [self setRightBarItemString:@"下一步" action:@selector(shearSetup)];
    self.navigationItem.rightBarButtonItem.tintColor = RGB(232, 98, 159);
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [[ShearViewManager sharedShearViewManager]setupShearViewWithshearType:ShearTypeProduct];
    [ShearViewManager sharedShearViewManager].selectShearItme = ^(NSInteger tag){
        
    };
}

-(void)initView{
    
    [super initView];
    
    _views = [[NSBundle mainBundle] loadNibNamed:@"SetupProductViewController" owner:self options:nil];
    self.view = [_views firstObject];

    [self initSegment];
    [self setupSelectViews];
    [self setupProductInfoViews];
    [self setupShearData];
    
    _titleTV.layer.cornerRadius = 4;
    _contentTV.layer.cornerRadius = 4;
    _contentTV.delegate = self;
    
    _titleTV.placeholder = @"请输入分享标题";
    _contentTV.placeholder = @"请输入分享描述";
    
    _stringCount.text = @"0/80";

    [_saveShearSetupButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_saveShearSetupButton)];
    _saveShearSetupButton.layer.cornerRadius = _saveShearSetupButton.frame.size.height/2;
    _saveShearSetupButton.layer.masksToBounds = YES;
    
    [SubmitFileManager sheardSubmitFileManager].delegate = self;
    [[SubmitFileManager sheardSubmitFileManager] addPictrueViewToViewController:_shearIconButton];
    [SubmitFileManager sheardSubmitFileManager].photoView.howMany = @"1";
    [[SubmitFileManager sheardSubmitFileManager]emptyThePictureArray];

}


-(void)setupShearData{
    
    _shear_cover = [[UIImageView alloc]init];
    [_shear_cover sd_setImageWithURL:[NSURL URLWithString:_product.share_img] placeholderImage:H5PlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [_shearIconButton setImage:image forState:UIControlStateNormal];
    }];
    
    _titleTV.layer.cornerRadius = 4;
    _contentTV.layer.cornerRadius = 4;
    _productDiscription.delegate = self;
    
    _titleTV.text = _product.share_title;
    _contentTV.text = _product.share_description;
    _productDiscription.text =  _product.descrip;
    _stringCount.text = @"0/80";
    
    if ([Global stringIsNullWithString:_product.share_title]) {
        
        _productName.placeholder = @"请输分享抬头";
        
    }
    if ([Global stringIsNullWithString:_product.share_description]) {
        
        _productDiscription.placeholder = @"请输入作品描述，80字以内";
    }
}

-(void)initData{
    
    [super initData];
    
    _itmeIndex = 0;
    _sceneTempArray = [NSMutableArray arrayWithObjects:@"请选择",@"请选择",@"请选择",@"请选择", nil];
    _oneTempArray = [NSMutableArray arrayWithObjects:@"请选择",@"请选择",@"请选择",@"请选择", nil];
    _vidoeTempArray = [NSMutableArray arrayWithObjects:@"请选择",@"请选择",@"请选择",@"请选择", nil];
    _h5TypeArray = [NSMutableArray array];
    [_h5TypeArray addObjectsFromArray:@[@"场景H5",@"一页H5", @"视频H5"]];
    
    _shear_cover = [[UIImageView alloc]init];
    [_shear_cover sd_setImageWithURL:[NSURL URLWithString:_product.share_img] placeholderImage:H5PlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [_shearIconButton setImage:image forState:UIControlStateNormal];
    }];
    
    [[UserManager shareUserManager] hometagListWithType:TagTypeProduct];
    [UserManager shareUserManager] .homeTagListSuccess = ^(NSArray *arr){
        
        _allTagArray = [[HomeStore shearHomeStore]configurationAllTagWithMenu:arr];
        [self setupSelectViews];

    };
}

-(NSMutableArray *)currentTempArray{
    
    if (_itmeIndex == 0) {
        return _sceneTempArray;
    } else if (_itmeIndex == 1){
        
        return _oneTempArray;
    } else {
        
       return _vidoeTempArray;
    }
}

-(void)shearSetup{
    
    NSInteger viewIndex = [_views indexOfObject:self.view];
    
    if (viewIndex == 0) {
        
        if ([Global stringIsNullWithString:_productName.text]) {
            [self showToastWithMessage:@"请输入作品名称"];
            return;
        }
        if ([Global stringIsNullWithString:_productPrice.text]) {
            [self showToastWithMessage:@"请设置作品价格"];
            return;
        }
        
        if ([Global stringIsNullWithString:_productDiscription.text]) {
            [self showToastWithMessage:@"请设输入作品描述"];
            return;
        }
        
        if ([_productCoveImage.imageView.image isEqual: H5PlaceholderImage]) {
            
            [self showToastWithMessage:@"请选择作品封面"];
            return;
        }
        
        [self setRightBarItemString:@"下一步" action:@selector(shearSetup)];
        [self setLeftBarItemString:@"上一步" action:@selector(back)];
        self.navigationItem.leftBarButtonItem.tintColor = RGB(232, 98, 159);
        self.navigationItem.rightBarButtonItem.tintColor = RGB(232, 98, 159);
        self.view = _views[viewIndex +1];
        
    } else if (viewIndex == 1){
        
        for (NSString *selectTag in [self currentTempArray]) {
            if ([selectTag isEqualToString:@"请选择"]) {
                
                [self showToastWithMessage:@"请完善标签项"];
                return;
            }
        }
        [self setRightBarItemString:@"分享" action:@selector(shearSetup)];
        [self setLeftBarItemString:@"上一步" action:@selector(back)];
        self.navigationItem.leftBarButtonItem.tintColor = RGB(232, 98, 159);
        self.navigationItem.rightBarButtonItem.tintColor = RGB(232, 98, 159);
        self.view = _views[viewIndex +1];
    } else{
        
        [self whetherOrNotPerfect];
        
        ShearInfo * shear = [[ShearInfo alloc]init];
        shear.shear_title = _titleTV.text;
        shear.shear_discrimination = _contentTV.text;
        shear.shear_thume_image = _selectShearCover;
        shear.shear_webLink = _product.url;
        [[ShearViewManager sharedShearViewManager]addShearViewToView:self.view shearType:UMS_SHARE_TYPE_WEB_LINK completion:^(NSInteger tag) {
            
            [[ShearViewManager sharedShearViewManager] shareWebPageToPlatformType:[[ShearViewManager sharedShearViewManager].shearTypeArray[tag] integerValue] parameter:shear];
        } ];
        
        [ShearViewManager sharedShearViewManager].shearSuccessBlock = ^(NSInteger tag){

        };
    }
}


-(void)back{
    
    NSInteger viewIndex = [_views indexOfObject:self.view];
    if (viewIndex == 0 ) {
        
        [super back];
    } else if (viewIndex == 1){
        
        [self setRightBarItemString:@"下一步" action:@selector(shearSetup)];
        [self setLeftCustomBarItem:@"icon_back" action:@selector(back)];
        self.navigationItem.rightBarButtonItem.tintColor = RGB(232, 98, 159);

        self.view = _views[viewIndex -1];
    } else {
        
        [self setRightBarItemString:@"下一步" action:@selector(shearSetup)];
        [self setLeftBarItemString:@"上一步" action:@selector(back)];
        self.navigationItem.leftBarButtonItem.tintColor = RGB(232, 98, 159);
        self.navigationItem.rightBarButtonItem.tintColor = RGB(232, 98, 159);
        self.view = _views[viewIndex -1];
    }
}

-(void)setupProductInfoViews{
   
    _product_cover = [[UIImageView alloc]init];
    [_product_cover sd_setImageWithURL:[NSURL URLWithString:_product.cover_img] placeholderImage:H5PlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [_productCoveImage setImage:image forState:UIControlStateNormal];
    }];

    _productName.layer.cornerRadius = 4;
    _productDiscription.layer.cornerRadius = 4;
    _productPrice.layer.cornerRadius = 4;
    _productDiscription.delegate = self;
    
    _productName.text = _product.title;
    _productPrice.text = _product.price;
    _productDiscription.text =  _product.descrip;
    _producContentCount.text = @"0/80";
    
    if ([Global stringIsNullWithString:_product.title]) {
       
        _productName.placeholder = @"请输入作品名称";
        
    }
    if ([Global stringIsNullWithString:_product.price]) {
        
        _productPrice.placeholder = @"请设置作品价格";
    }
    if ([Global stringIsNullWithString:_product.descrip]) {
        
        _productDiscription.placeholder = @"请输入作品描述，80字以内";
    }
}


-(void)setupSelectViews{
    
    _useLMJDropdownMenu.frame = CGRectMake(CGRectGetMaxX(_h5TypeTitleLabel.frame)+30, 0, ScreenWidth - CGRectGetMaxX(_h5TypeTitleLabel.frame)-58 , 34);
    _industryLMJDropdownMenu.frame = CGRectMake(CGRectGetMaxX(_h5TypeTitleLabel.frame)+30, 0, ScreenWidth - CGRectGetMaxX(_h5TypeTitleLabel.frame)-58 , 34);
    _technologyLMJDropdownMenu.frame = CGRectMake(CGRectGetMaxX(_h5TypeTitleLabel.frame)+30, 0, ScreenWidth - CGRectGetMaxX(_h5TypeTitleLabel.frame)-58 , 34);
    _styleLMJDropdownMenu.frame = CGRectMake(CGRectGetMaxX(_h5TypeTitleLabel.frame)+30, 0, ScreenWidth - CGRectGetMaxX(_h5TypeTitleLabel.frame)-58 , 34);
    
    _useLMJDropdownMenu.centerY = _useTitleLabel.centerY;
    _industryLMJDropdownMenu.centerY = _industryTitleLabel.centerY;
    _technologyLMJDropdownMenu.centerY = _technologyTitleLabel.centerY;
    _styleLMJDropdownMenu.centerY = _styleTitleLabel.centerY;
    
    _useLMJDropdownMenu.delegate = self;
    _industryLMJDropdownMenu.delegate = self;
    _technologyLMJDropdownMenu.delegate = self;
    _styleLMJDropdownMenu.delegate = self;
    
    [self setupSelectViewsTagTitleWithTag:0];
}

-(void)setupSelectViewsTagTitleWithTag:(NSInteger )index{

    NSString *h5Type = _h5TypeArray[index];
    NSArray *tagTitle = [[HomeStore shearHomeStore]configurationTagNameWithTag:h5Type];

    _useTitleLabel.text = tagTitle[0];
    _industryTitleLabel.text = tagTitle[1];
    _technologyTitleLabel.text = tagTitle[2];
    _styleTitleLabel.text = tagTitle[3];
    
    _useArray = [[HomeStore shearHomeStore]configurationTagWithMenu:_allTagArray tagType:tagTitle[0]];
    _industryArray = [[HomeStore shearHomeStore]configurationTagWithMenu:_allTagArray tagType:tagTitle[1]];
    _technologyArray = [[HomeStore shearHomeStore]configurationTagWithMenu:_allTagArray tagType:tagTitle[2]];
    _styleArray = [[HomeStore shearHomeStore]configurationTagWithMenu:_allTagArray tagType:tagTitle[3]];
    
    [_useLMJDropdownMenu setMenuTitles:[[HomeStore shearHomeStore]configurationTagNameWithMenu:_useArray tagType:tagTitle[0]] rowHeight:34];
    
    [_industryLMJDropdownMenu setMenuTitles:[[HomeStore shearHomeStore]configurationTagNameWithMenu:_industryArray tagType:tagTitle[1]] rowHeight:34];
    
    [_technologyLMJDropdownMenu setMenuTitles:[[HomeStore shearHomeStore]configurationTagNameWithMenu:_technologyArray tagType:tagTitle[2]] rowHeight:34];
    
    [_styleLMJDropdownMenu setMenuTitles:[[HomeStore shearHomeStore]configurationTagNameWithMenu:_styleArray tagType:tagTitle[3]] rowHeight:34];

    [self segmentTapSetLMJDropdownMenuWithTempArry:[self currentTempArray]];

    [self getLMJDropdownMenuWithTempArry:index];
}

-(void)initSegment{
    
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_h5TypeTitleLabel.frame)+35, 0, ScreenWidth - CGRectGetMaxX(_h5TypeTitleLabel.frame)-58, 40) withDataArray:_h5TypeArray withFont:15];
    self.segment.centerY = _h5TypeTitleLabel.centerY;
    self.segment.delegate = self;
    self.segment.lineColor = [UIColor clearColor];
    self.segment.textNomalColor = UIColorFromRGB(0x434a5c);
    self.segment.textSelectedColor = UIColorFromRGB(0xf95aee);
    [self.segment selectIndex:_itmeIndex];
    
    UIView *view = _views[1];
    [view addSubview:self.segment];
//    [self.view addSubview:self.segment];
}

#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index{
    
    _itmeIndex = index;
    [self setupSelectViewsTagTitleWithTag:index];
}

-(void)segmentTapSetLMJDropdownMenuWithTempArry:(NSArray *)tempArray{
    
    [_useLMJDropdownMenu.mainBtn setTitle:tempArray[0] forState:UIControlStateNormal];
    [_industryLMJDropdownMenu.mainBtn setTitle:tempArray[1] forState:UIControlStateNormal];
    [_technologyLMJDropdownMenu.mainBtn setTitle:tempArray[2] forState:UIControlStateNormal];
    [_styleLMJDropdownMenu.mainBtn setTitle:tempArray[3] forState:UIControlStateNormal];
}

-(void)getLMJDropdownMenuWithTempArry:(NSInteger )index{
    
    [[self currentTempArray] removeAllObjects];
    [[self currentTempArray] addObjectsFromArray:@[_useLMJDropdownMenu.mainBtn.titleLabel.text,_industryLMJDropdownMenu.mainBtn.titleLabel.text,_technologyLMJDropdownMenu.mainBtn.titleLabel.text,_styleLMJDropdownMenu.mainBtn.titleLabel.text]];
}

-(NSString *)getTagIdWithTagArray:(NSArray * )TagArray tagStr:(NSString *)tagStr{
    
    
    for (TagList *tag in TagArray) {
        
        if ([tag.name isEqualToString:tagStr]) {
        
            return tag.id;
            
        }
    }
    
    return nil;
}

- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    
    [self getLMJDropdownMenuWithTempArry:_itmeIndex];

}

- (IBAction)changeShearImage:(UIButton *)sender {
    
     [[SubmitFileManager sheardSubmitFileManager]popupsSelectPhotoTipsView];
}

- (void)textViewDidChange:(UITextView *)textView{

    if ([_views indexOfObject:self.view] == 2) {
        
        if (textView.text.length > 80) {
            
            _contentTV.text = [_contentTV.text substringWithRange:NSMakeRange(0, 80)];
            [self showToastWithMessage:@"输入内容长度不超过80"];
            return;
        }
        _stringCount.text = [NSString stringWithFormat:@"%ld/80",(long)textView.text.length];

    } else {
        
        if (textView.text.length > 80) {
            
            _productDiscription.text = [_productDiscription.text substringWithRange:NSMakeRange(0, 80)];
            [self showToastWithMessage:@"输入内容长度不超过80"];
            return;
        }
        _producContentCount.text = [NSString stringWithFormat:@"%ld/80",(long)textView.text.length];
    }
    
    NSLog(@"%@",_contentTV.text);
    NSLog(@"%ld",_contentTV.text.length);
}

#pragma Mark-提交获取图片url的协议方法
-(void)compressionAndTransferPicturesWithArray:(NSArray *)array{
    
    if ([_views indexOfObject:self.view] == 2){
        
        [_shearIconButton setImage:[array firstObject] forState:UIControlStateNormal];
        self.selectShearCover = [array firstObject];
        
    } else {
        
        [_productCoveImage setImage:[array firstObject] forState:UIControlStateNormal];
        self.selectProsuctCover = [array firstObject];
    }
}

- (IBAction)save:(UIButton *)sender {
    
    [self whetherOrNotPerfect];
    NSMutableArray *selectTag = [NSMutableArray array];
    
    [selectTag addObject:[self getTagIdWithTagArray:_useArray tagStr:[self currentTempArray][0]]];
    [selectTag addObject:[self getTagIdWithTagArray:_industryArray tagStr:[self currentTempArray][1]]];
    [selectTag addObject:[self getTagIdWithTagArray:_technologyArray tagStr:[self currentTempArray][2]]];
    [selectTag addObject:[self getTagIdWithTagArray:_styleArray tagStr:[self currentTempArray][3]]];

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_product.title forKey:@"Title"];
    [dic setObject:_titleTV.text forKey:@"Share_title"];
    [dic setObject:_contentTV.text forKey:@"Share_description"];
    [dic setObject:_product.id forKey:@"Id"];
    [dic setObject:selectTag forKey:@"TagList"];
    [dic setObject:@(_itmeIndex + 1) forKey:@"Product_type"];
    [dic setObject:_productDiscription.text forKey:@"Description"];
    [dic setObject:_product.url forKey:@"Url"];
    [dic setObject:_productPrice.text forKey:@"Price"];
    
    if (self.selectProsuctCover != nil) {
        
        [[SubmitFileManager sheardSubmitFileManager]submitImageWithImage:_selectProsuctCover];
        [UserManager shareUserManager].submitFileSuccess = ^ (NSString *obj){
    
            [dic setObject:obj forKey:@"Cover_img"];
            
            if (self.selectShearCover != nil) {
                
                [[SubmitFileManager sheardSubmitFileManager]submitImageWithImage:_selectShearCover];
                [UserManager shareUserManager].submitFileSuccess = ^ (NSString *obj){
                    
                    
                    [dic setObject:obj forKey:@"Share_img"];
                    [[UserManager shareUserManager]updataProductWithParameters:dic];
                    [UserManager shareUserManager].updataProductSuccess = ^(id obj){
                        
                        [self AlertOperation];
                    };
                };
            } else {
                
                if (![Global stringIsNullWithString:_product.share_img]) {
                    
                    [dic setObject:_product.share_img forKey:@"Share_img"];
                }
                [[UserManager shareUserManager]updataProductWithParameters:dic];
                [UserManager shareUserManager].updataProductSuccess = ^(id obj){
                    
                    [self AlertOperation];
                };
            }
        };
    } else if (self.selectShearCover != nil){
        
        [[SubmitFileManager sheardSubmitFileManager]submitImageWithImage:_selectShearCover];
        [UserManager shareUserManager].submitFileSuccess = ^ (NSString *obj){
            
            [dic setObject:obj forKey:@"Share_img"];
            if (![Global stringIsNullWithString:_product.cover_img]) {
                
                [dic setObject:_product.cover_img forKey:@"Cover_img"];
            }
            [[UserManager shareUserManager]updataProductWithParameters:dic];
            [UserManager shareUserManager].updataProductSuccess = ^(id obj){
                
                [self AlertOperation];
            };
        };
    } else {
        
        if (![Global stringIsNullWithString:_product.cover_img]) {
            
             [dic setObject:_product.cover_img forKey:@"Cover_img"];
        }
        
        if (![Global stringIsNullWithString:_product.share_img]) {
            
            [dic setObject:_product.share_img forKey:@"Share_img"];
        }
        
        [[UserManager shareUserManager]updataProductWithParameters:dic];
        [UserManager shareUserManager].updataProductSuccess = ^(id obj){
            
            [self AlertOperation];
        };
    }
    
//    if ([[SubmitFileManager sheardSubmitFileManager]getSelectedPicktures].count != 0){
//        
//        [[SubmitFileManager sheardSubmitFileManager]compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:self andType:nil];
//        [UserManager shareUserManager].submitFileSuccess = ^ (NSString *obj){
//            
//            [dic setObject:obj forKey:@"Share_img"];
//            [dic setObject:obj forKey:@"Cover_img"];
//            
//             [[UserManager shareUserManager]updataProductWithParameters:dic];
//            [UserManager shareUserManager].updataProductSuccess = ^(id obj){
//              
//                [self AlertOperation];
//            };
//
//        };
//    } else {
//
//        [dic setObject:_product.cover_img forKey:@"Share_img"];
//        [dic setObject:_product.cover_img forKey:@"Cover_img"];
//        [[UserManager shareUserManager]updataProductWithParameters:dic];
//        [UserManager shareUserManager].updataProductSuccess = ^(id obj){
//            
//            [self AlertOperation];
//        };
//    }
}


-(void)whetherOrNotPerfect{
    
    if ([_shearIconButton.imageView.image isEqual: H5PlaceholderImage]) {
        
        [self showToastWithMessage:@"请选择作品封面"];
        return;
    }
    
    if ([Global stringIsNullWithString:_titleTV.text]) {
        [self showToastWithMessage:@"请输入分享标题"];
        return;
    }
    if ([Global stringIsNullWithString:_titleTV.text]) {
        [self showToastWithMessage:@"请输入分享描述"];
        return;
    }
}

-(void)AlertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存分享信息成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续修改" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [super back];
        [UIManager sharedUIManager].setupProductBackOffBolck(nil);
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
