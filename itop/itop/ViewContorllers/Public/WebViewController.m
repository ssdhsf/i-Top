//
//  WebViewController.m
//  itop
//
//  Created by huangli on 2018/2/2.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     _webView.delegate = self;
    _webView.scrollView.bounces = NO;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillDisappear:(BOOL)animated{
    // [self.webView stopLoading];
    // JSValue *JSfunc =_jsContext[@”guanbiyinyue”];
    // [JSfunc callWithArguments:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
}

-(void)initView{
//    _hud = [[MBProgressHUD alloc] init];
//    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    
//    self.navigationItem.title = _VCtitle;
    [self loadWebPageWithString:_h5Url];
//    _backgroundPicture.hidden=YES;
//    _tipStatus.hidden=YES;
//    _refreshButton.hidden=YES;
}


//根据url加载网页
- (void)loadWebPageWithString:(NSString*)urlString{
    
//    [[Global sharedSingleton] createProgressHUDInView:self.view withMessage:@"加载中..."];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self setUserAgent];
    [_webView loadRequest:request];
}

#pragma mark-视图加载完执行的方法
-(void)webViewDidFinishLoad:(UIWebView*)webView{
    
    [MBProgressHUD hideHUDForView: self.view animated:NO];
    [self loadJsCallOC];
}

#pragma mark 创建JS调用OC本地代码
-(void)loadJsCallOC{
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"practiceApplication"] = ^() {
        
        NSArray *args = [JSContext currentArguments];
        [self accordingToFitnessPushViewController:args];
    };
    //  上传图片方法
    context[@"chooseFile"] = ^() {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            
//            [[SubmitFileManager sheardSubmitFileManager]popupsSelectPhotoTipsView];
        });
    };
    
    context[@"chooseFile2"] = ^() {
        
    };
    
    //手动添加实习申请调用JS的方法
    context[@"wait"]= ^ () {
        
        [[Global sharedSingleton] createProgressHUDInView:self.view withMessage:@"加载中..."];
    };
    
    //退出
    
    context[@"goBack"] = ^() { // 1

    };
    //    获取服务器返回的数据判断做什么操作
    context[@"call"] = ^() {
        NSArray *args = [JSContext currentArguments];
        [self accordingToFitnessPushViewController:args];
    };
}


- (void)setUserAgent {
    //get the original user-agent of wßebview
    NSString *oldAgent = [self.webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSLog(@"old agent :%@", oldAgent);
    
    //add my info to the new agent
    NSString *newAgent = [oldAgent stringByAppendingString:@"app-ios"];
    NSLog(@"new agent :%@", newAgent);
    
    //regist the new agent
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    //  [self loadView];
    
}

#pragma mark-视图加载前执行的方法/重定向
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    if ([request.URL.absoluteString hasSuffix:@".txt"]||
        [request.URL.absoluteString hasSuffix:@".doc"]||
        [request.URL.absoluteString hasSuffix:@".docx"]||
        [request.URL.absoluteString hasSuffix:@".xlsx"]||
        [request.URL.absoluteString hasSuffix:@".xls"]) {
        NSString *url = request.URL.absoluteString;
        NSLog(@"%@",url);
//        [self downFileWithUrl:url];
        return NO;
    }
    
    if ([request.URL.absoluteString hasSuffix:@".png"]||
        [request.URL.absoluteString hasSuffix:@".gif"]||
        [request.URL.absoluteString hasSuffix:@".jpg"]||
        [request.URL.absoluteString hasSuffix:@".JPG"]||
        [request.URL.absoluteString hasSuffix:@".JPEG"]||
        [request.URL.absoluteString hasSuffix:@".PNG"]||
        [request.URL.absoluteString hasSuffix:@".GIF"]||
        [request.URL.absoluteString hasSuffix:@".jpeg"]) {
        NSString *url = request.URL.absoluteString;
        NSLog(@"%@",url);
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:request.URL options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//            MSSBrowseModel *model = [[MSSBrowseModel alloc]init];
//            model.bigImage = image;
//            MSSBrowseLocalViewController *bvc = [[MSSBrowseLocalViewController alloc]initWithBrowseItemArray:@[model] currentIndex:1];
//            bvc.delegate = self;
//            bvc.isBrowsePictures = YES;
//            [bvc showBrowseViewController];
        }];
        return NO;
    }
    
    NSLog(@"%ld",(long)navigationType);
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        [[Global sharedSingleton] createProgressHUDInView:self.view withMessage:@"加载中..."];
        
    }
    NSHTTPURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    if (response.statusCode != 200) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            [MBProgressHUD hideHUDForView: self.view animated:NO];
            [self showToastWithMessage:@"加载失败"];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        });
        return NO;
    }
    
    //TODO : 接口拼接参数的时候不能用type字段  会引起冲突
    BOOL isGoon=YES;
    NSURL *url = [request URL];
    //    从获取的url中判断3种情况 0 提交失败 1提交成功返回历史页 —1跳转登陆页面
    NSString*fitnessz=@"type=0";
    NSString*fitnesso=@"type=1";
    NSString*fitnesst=@"type=-1";
    NSString*urlString=[NSString stringWithFormat:@"%@",url];
    NSLog(@"%@",urlString);
    if ([urlString rangeOfString:fitnessz].location!=NSNotFound ) {
        [MBProgressHUD hideHUDForView: self.view animated:NO];
        isGoon=YES;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"push" object:nil userInfo:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([urlString rangeOfString:fitnesso].location!=NSNotFound ) {
        [MBProgressHUD hideHUDForView: self.view animated:NO];
        NSArray * array= [fitnesso componentsSeparatedByString:@"="];
        NSString*fitnessSring=array[1];
        NSArray*fitnessArr=@[fitnessSring];
        NSLog(@"%@",fitnessArr);
        [self accordingToFitnessPushViewController:fitnessArr];
        isGoon=NO;
    }
    else  if([urlString rangeOfString:fitnesst].location!=NSNotFound ) {
        [MBProgressHUD hideHUDForView: self.view animated:NO];
        NSArray  * array= [fitnesst componentsSeparatedByString:@"="];
        NSString*fitnessSring=array[1];
        NSArray*fitnessArr=@[fitnessSring];
        [self accordingToFitnessPushViewController:fitnessArr];
        isGoon=NO;
    }
    
    NSRange range = [[NSString stringWithFormat:@"%@",url] rangeOfString:@"iamback"];
    if (range.length>0) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:Notification_UpdataTaskList object:nil];
//        [self back];
//        [[NSNotificationCenter defaultCenter]postNotificationName:Notification_UpdateCountHome object:self userInfo:nil];
//        isGoon=NO;
    }
    
    return isGoon;
}

#pragma mark-服务端返回的状态操作
-(void)accordingToFitnessPushViewController:(NSArray*)arr{
    
    if(arr.count>0){
        NSString *code = [arr[0] toString];
        
        if ([code isEqualToString:@"20000"]) {
            
//            [[NSNotificationCenter defaultCenter]postNotificationName:Notification_REFRESHDATA object:nil userInfo:nil];
            
            //提交成功跳转历史页面
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            });
            
        }else if([code isEqualToString:@"40510"] || [code isEqualToString:@"40511"]){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                //跳转登陆页面
                [[Global sharedSingleton] createProgressHUDInView:self.view withMessage:@"加载中..."];
//                UnifiedLoginViewController *loginVC =
//                [[UnifiedLoginViewController alloc]
//                 init];
//                UINavigationController *navigationVC =
//                [[UINavigationController alloc]
//                 initWithRootViewController:loginVC];
//                [self presentViewController:navigationVC
//                                   animated:NO
//                                 completion:nil];
//                [self logout];
                [MBProgressHUD hideHUDForView: self.view animated:NO];
                
            });
        }else{
            //            提示服务端返回的信息
            [MBProgressHUD hideHUDForView: self.view animated:NO];
            NSString*message=[arr[1] toString];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                [self showToastWithMessage:message];
            });
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
