//
//  IntroductionViewController.m
//  itop
//
//  Created by huangli on 2018/5/18.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "IntroductionViewController.h"

@interface IntroductionViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *introdutionTV;
@property (weak, nonatomic) IBOutlet UIButton *determineButton;

@end

@implementation IntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initNavigationBarItems{
    
    self.title = @"简介";
}

-(void)initView{
    
    [super initView];
    [_determineButton.layer insertSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_determineButton) atIndex:0];
    _determineButton.layer.cornerRadius = _determineButton.height/2;
    _determineButton.layer.masksToBounds = YES;
}

-(void)initData{
    
    [super initData];
    _introdutionTV.placeholder = @"请输入简介";
    _introdutionTV.delegate = self;
    
    if (![Global stringIsNullWithString:_introduction]) {
        
        _introdutionTV.text = _introduction;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)determine:(UIButton *)sender {
    
    if ([Global stringIsNullWithString:_introdutionTV.text]) {
        
        [self showToastWithMessage:@"简介不能为空"];
        return;
    }
    
    [self back];
    
    if([UIManager sharedUIManager].introductionBackOffBolck){
        
        [UIManager sharedUIManager].introductionBackOffBolck(_introdutionTV.text);
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSLog(@"%@",text);
    if (range.location > 120) {
        
        [self showToastWithMessage:@"输入的内容不能超过120个"];
        textView.text = [textView.text substringWithRange:NSMakeRange(0, 119)];
    }
    return YES;
}

@end
