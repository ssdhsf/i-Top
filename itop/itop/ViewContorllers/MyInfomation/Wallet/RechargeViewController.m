//
//  RechargeViewController.m
//  itop
//
//  Created by huangli on 2018/5/9.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "RechargeViewController.h"
#import "biddingPayViewController.h"

static const NSString *PayProduct20 = @"PayProductType20";

static const NSString *PayProduct50 = @"PayProductType50";

static const NSString *PayProduct100 = @"PayProductType100";

static const NSString *PayProduct200 = @"PayProductType200";

static const NSString *PayProduct500 = @"PayProductType500";

static const NSString *PayProduct800 = @"PayProductType800";

static const NSString *PayProduct1000 = @"PayProductType1000";

static const NSString *PayProduct2000 = @"PayProductType2000";

@interface RechargeViewController ()<SKPaymentTransactionObserver,SKProductsRequestDelegate >

@property (strong, nonatomic) YZTagList *tagList;
@property (strong, nonatomic) NSMutableArray *tagArray;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) CAGradientLayer *selectViewLayer;
@property (strong, nonatomic) CALayer *noSelectViewLayer;
@property (weak, nonatomic) IBOutlet UIButton *submitPayButton;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (assign, nonatomic) NSInteger selectPrice;
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initNavigationBarItems{
    
    self.title = @"充值";
}

-(void)initData{
    
    [super initData];
    self.tagArray = [NSMutableArray array];
    self.buttonArray = [NSMutableArray array];
    [self.tagArray addObjectsFromArray:@[@"20",@"50",@"100",@"200",@"500",@"800",@"1000",@"2000"]];
    _moneyLabel.text = [NSString stringWithFormat:@"0元"];
}

-(void)initView{
    
    [super initView];
    [self addkeywordsViewWithkeywords:self.tagArray];
    
    UIButton *binddinWechatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    binddinWechatButton.frame = CGRectMake(0, 350, ScreenWidth/2, 17);
    [binddinWechatButton setTitle:@"如何绑定微信支付" forState:UIControlStateNormal];
    binddinWechatButton.tag = 0;
    [binddinWechatButton addTarget:self action:@selector(biddingPay:) forControlEvents:UIControlEventTouchDown];
    binddinWechatButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [binddinWechatButton setTitleColor:UIColorFromRGB(0x61bef4) forState:UIControlStateNormal];
    
    [self.view addSubview:binddinWechatButton];
    
    UIButton *binddinAlliPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    binddinAlliPayButton.frame = CGRectMake(ScreenWidth/2, 350, ScreenWidth/2, 17);
    [binddinAlliPayButton setTitle:@"如何绑定支付宝支付" forState:UIControlStateNormal];
    [binddinAlliPayButton addTarget:self action:@selector(biddingPay:) forControlEvents:UIControlEventTouchDown];
    binddinAlliPayButton.tag = 1;
    binddinAlliPayButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [binddinAlliPayButton setTitleColor:UIColorFromRGB(0x61bef4) forState:UIControlStateNormal];
    [self.view addSubview:binddinAlliPayButton];
    
    [_submitPayButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitPayButton)];
    _submitPayButton.layer.masksToBounds = YES;
    _submitPayButton.layer.cornerRadius = _submitPayButton.height/2;
}

-(void)addkeywordsViewWithkeywords:(NSArray *)keywords{

    for (int i = 0; i < keywords.count; i ++) {
        
        NSInteger x = i%3;
        NSInteger y = i/3;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x*((ScreenWidth-80)/3)+((x+1)*20),y*75 +((y+1)*20), (ScreenWidth-80)/3, 75)];
        view.backgroundColor = UIColorFromRGB(0xf5f7f9);
        [self.view addSubview:view];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 5;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(2,2, (ScreenWidth-92)/3, 71);
        [view addSubview:button];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:[NSString stringWithFormat:@"¥%@元",keywords[i]] forState:UIControlStateNormal];
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;
        [button setTitleColor:UIColorFromRGB(0x434a5c) forState:UIControlStateNormal];
        button.tag = i;
        
        [button addTarget:self action:@selector(recharge:) forControlEvents:UIControlEventTouchDown];
        [_buttonArray addObject:button];
    }
}

-(void)recharge:(UIButton*)sender{
    
    for (UIButton *button in _buttonArray) {
        if (button.tag == sender.tag) {
            _selectPrice = sender.tag;
            _moneyLabel.text = [NSString stringWithFormat:@"%@元",self.tagArray[sender.tag]];
            [button setTitleColor:UIColorFromRGB(0xeb6ea5) forState:UIControlStateNormal];
            UIView *view = button.superview;
            
            if(_selectViewLayer){
                
                [_selectViewLayer removeFromSuperlayer];
            } else {
                _selectViewLayer = DEFULT_BUTTON_CAGRADIENTLAYER(view);
            }
                [view.layer insertSublayer:_selectViewLayer atIndex:0];

        } else {

            [button setTitleColor:UIColorFromRGB(0x434a5c) forState:UIControlStateNormal];
        }
    }
}

-(void)biddingPay:(UIButton*)sender{
    
    biddingPayViewController *bidding = [[biddingPayViewController alloc]init];
    NSLog(@"%ld",sender.tag);
    bidding.biddingPayType = sender.tag;
    [self.navigationController pushViewController:bidding animated:YES];
}

- (void)requestProductDataWithPayProductType:(PayProductType)productType{
    
    NSArray *product;
    
    switch(productType) {
            
        case PayProductType20:
            
            product =@[PayProduct20];
            
            break;
            
        case PayProductType50:
            
            product =@[PayProduct50];
            
            break;
            
        case PayProductType100:
            
            product =@[PayProduct100];
            
            break;
            
        case PayProductType200:
            
            product =@[PayProduct200];
            
            break;
            
        case PayProductType500:
            
            product =@[PayProduct500];
            
            break;
            
        case PayProductType800:
            
            product =@[PayProduct800];
            break;
            
        case PayProductType1000:
            
            product =@[PayProduct1000];
            
            break;
            
        case PayProductType2000:
            
            product =@[PayProduct2000];
            
            break;
            
        default:
            
            break;
    }
    
    NSLog(@"请求的产品%@",product);
    
    NSSet *nsset = [NSSet setWithArray:product];
    
    SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:nsset];
    
    request.delegate =self;
    
    [request start];
    
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"-----------收到产品反馈信息--------------");
    
    NSArray *myProduct = response.products;
    
    NSLog(@"产品Product ID:%@",response.invalidProductIdentifiers);
    
    NSLog(@"产品付费数量: %d", (int)[myProduct count]);
    
    // populate UI
    
    for(SKProduct *product in myProduct){
        
        NSLog(@"product info");
        
        NSLog(@"SKProduct描述信息%@", [product description]);
        
        NSLog(@"产品标题%@", product.localizedTitle);
        
        NSLog(@"产品描述信息: %@", product.localizedDescription);
        
        NSLog(@"价格: %@", product.price);
        
        NSLog(@"Product id: %@", product.productIdentifier);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        
        //addPayment 将支付信息添加进苹果的支付队列后，苹果会自动完成后续的购买请求，在用户购买成功或者点击取消购买的选项后回调
    }
}

//+ (id)paymentWithProductIdentifier:(NSString*)identifier{
//    NS_DEPRECATED_IOS(3_0,5_0,"Use +paymentWithProduct: after fetching the available products using SKProductsRequest");
//}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    
    NSLog(@"------------------错误-----------------:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request{
    
    NSLog(@"------------反馈信息结束-----------------");
    
}


//监听购买结果的回调

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    
    for(SKPaymentTransaction *tran in transaction){
        
        switch(tran.transactionState) {
                
            case SKPaymentTransactionStatePurchased:
                
                NSLog(@"交易完成");
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                
                //                [self verifyTransactionResult];
                
                break;
                
                 
                
            case SKPaymentTransactionStatePurchasing:
                
                NSLog(@"商品添加进列表");
                
                break;
                
            case SKPaymentTransactionStateRestored:
                
                NSLog(@"已经购买过商品");
                
                break;
                
            case SKPaymentTransactionStateFailed:
                
                NSLog(@"交易失败");
                
                //                [MyTaShowMessageView showMessage:@"交易失败！"];
                
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                
                break;
                
                
            default:
                
                break;
                
        }
    }
}

@end
