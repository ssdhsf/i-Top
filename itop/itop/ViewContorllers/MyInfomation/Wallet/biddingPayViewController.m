//
//  biddingPayViewController.m
//  itop
//
//  Created by huangli on 2018/5/9.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "biddingPayViewController.h"

@interface biddingPayViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation biddingPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)initNavigationBarItems{
    
    if (_biddingPayType == BiddingPayTypeWexinPay) {
        self.title = @"微信绑定指南";
    } else{
        self.title = @"支付宝绑定指南";
    }
}

-(void)initView{
    
    [super initView];
    UIImage *image = [UIImage imageNamed:@"ios9-ali-pay"];
    
    
    switch (_biddingPayType) {
        case BiddingPayTypeWexinPay:
            if ([[UIDevice currentDevice].systemVersion floatValue] < 11.0) {
                
                image = [UIImage imageNamed:@"ios9-weixin-pay"];
            } else {
                
                image = [UIImage imageNamed:@"ios11-weixin-pay"];
            }
            break;
        case BiddingPayTypeAliPay:
            if ([[UIDevice currentDevice].systemVersion floatValue] < 11.0) {
                
                image = [UIImage imageNamed:@"ios9-ali-pay"];
            } else {
                
                image = [UIImage imageNamed:@"ios11-ali-pay"];
            }

            break;
            
        default:
            break;
    }
    
    

    CGFloat height = image.size.height;
    
    CGFloat proportion = ScreenWidth /image.size.width;
    _scrollView.contentSize = CGSizeMake(ScreenWidth, height * proportion +20);
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, ScreenWidth-40, height *proportion)];
    view.image  = image;
    view.contentMode = UIViewContentModeScaleAspectFill;
    [_scrollView addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
