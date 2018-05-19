//
//  SelectagViewController.m
//  itop
//
//  Created by huangli on 2018/5/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SelectagViewController.h"

@interface SelectagViewController ()

@property (strong, nonatomic) YZTagList *tagList;
@property (strong, nonatomic) NSMutableArray *tagArray;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation SelectagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initNavigationBarItems{
    
    self.title = @"选择标签";
}

-(void)initData{
    
    [super initData];
    self.tagArray = [NSMutableArray array];
    if ([[CompanySigningStore shearCompanySigningStore]fieldList].count == 0) {
        
        [[UserManager shareUserManager]hometagListWithType:TagTypeField];
        [UserManager shareUserManager].homeTagListSuccess = ^(id arr){
            
            [[CompanySigningStore shearCompanySigningStore]confitionFieldWithRequstFieldArray:arr];
            [_tagArray addObjectsFromArray:[[CompanySigningStore shearCompanySigningStore]fieldList]];
            [self addkeywordsViewWithkeywords:_tagArray];
        };
    } else {
        
        [_tagArray addObjectsFromArray:[[CompanySigningStore shearCompanySigningStore]fieldList]];

        for (TagList *tag in _tagArray) {
            tag.selecteTag.selecteTag = NO;
        }
        [self addkeywordsViewWithkeywords:_tagArray];
    }
}

-(void)initView {
    
    [super initView];
    
}

-(void)addkeywordsViewWithkeywords:(NSArray *)keywords{
    
    // 高度可以设置为0，会自动跟随标题计算
    _tagList = [[YZTagList alloc] initWithFrame:CGRectMake(30, 50, ScreenWidth-60, 0)];
    _tagList.tag = 1;
    _tagList.backgroundColor = [UIColor whiteColor];
    _tagList.tagCornerRadius = 3;
    _tagList.borderColor = UIColorFromRGB(0xc6c8ce);
    _tagList.borderWidth = 1;
    _tagList.tagFont =  [UIFont systemFontOfSize:15] ;
    // 设置标签背景色
    //    _tagList.tagBackgroundColor = RGB(244, 245, 247);
    _tagList.tagColor = [UIColor blackColor];
    [_tagList addFieldTag: keywords action:@selector(fieldTag:)];
    [self.view addSubview:_tagList];
    //    _nextButton.frame = CGRectMake(ScreenWidth/2-65,CGRectGetMaxY(_tagList.frame)+30,130 , 35);
    
    __weak typeof(self) weakSelf = self;
    _tagList.fieldTagBlock = ^ (NSString *tag, BOOL select){
        
        NSInteger selectNumber = 0 ;
        for (TagList *sTag in weakSelf.tagArray) {
            if (sTag.selecteTag.selecteTag == YES) {
                
                selectNumber ++;
            }
        }
        if (selectNumber == 3) {
            
            for (TagList *sTag in weakSelf.tagArray) {
                if ([sTag.name isEqualToString:tag]  && sTag.selecteTag.selecteTag == YES) {
                    
                    sTag.selecteTag.selecteTag = !sTag.selecteTag.selecteTag;
                    [weakSelf addkeywordsViewWithkeywords:weakSelf.tagArray];
                    return ;
                }
            }
            [[Global sharedSingleton]showToastInTop:weakSelf.view withMessage:@"选择不超过3个"];
            return ;
        }else {
            
            for (TagList *sTag in weakSelf.tagArray) {
                if ([sTag.name isEqualToString:tag]) {
                    
                    sTag.selecteTag.selecteTag = !sTag.selecteTag.selecteTag;
                }
            }
            
        }
        [weakSelf addkeywordsViewWithkeywords:weakSelf.tagArray];
        NSLog(@"%@",tag);
    };
    
    _submitButton.layer.masksToBounds = YES;
    _submitButton.layer.cornerRadius = _submitButton.height/2;
    _submitButton.frame = CGRectMake(0,CGRectGetMaxY(_tagList.frame)+30,130 , 35);
    _submitButton.centerX = _tagList.centerX;
    [_submitButton.layer insertSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitButton) atIndex:0];
}

- (IBAction)submit:(UIButton *)sender {
    
    
    NSMutableArray *selectTagArray = [NSMutableArray array];
    for (TagList *tag in self.tagArray) {
        
        if (tag.selecteTag.selecteTag == YES) {
            
            [selectTagArray addObject:tag];
        }
    }
    
    if (selectTagArray.count == 0) {
        
        [self showToastWithMessage:@"没有选择任何标签"];
        return;
        
    }
    [self back];
    if ([UIManager sharedUIManager].selectTagOffBolck) {
        [UIManager sharedUIManager].selectTagOffBolck(selectTagArray);
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
