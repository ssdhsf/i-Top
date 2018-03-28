//
//  LoadingViewController.m
//  itop
//
//  Created by huangli on 2018/3/21.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "LoadingViewController.h"

#define DURATION 5

@interface LoadingViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *myImgView;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self loadGifBundleWithImageView];
    [self scheduledGCDTimer];
    
    NSLog(@"%@",[NSData data]);
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

#pragma mark - 使用Bundle打包,用ImageView加载
- (NSArray *)animationImages
{
    NSLog(@"%@",[NSData data]);
    NSFileManager *fielM = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"loadingGif" ofType:@"bundle"];
    NSArray *arrays = [fielM contentsOfDirectoryAtPath:path error:nil];
    NSLog(@"%@",[NSData data]);
    NSMutableArray *imagesArr = [NSMutableArray array];
    for (NSString *name in arrays) {
        UIImage *image = [UIImage imageNamed:[(@"loadingGif.bundle") stringByAppendingPathComponent:name]];
        if (image) {
            [imagesArr addObject:image];
        }
    }
    return imagesArr;
}


- (void)loadGifBundleWithImageView
{
    self.myImgView.animationImages = [self animationImages]; //获取Gif图片列表
    self.myImgView.animationDuration = DURATION;     //执行一次完整动画所需的时长
    self.myImgView.animationRepeatCount = 0;  //动画重复次数
    [self.myImgView startAnimating];
}

- (void)scheduledGCDTimer
{
    [self cancleGCDTimer];
    __block int timeLeave = DURATION; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    __typeof (self) __weak weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        if(timeLeave <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(weakSelf.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //关闭界面
                [self.myImgView stopAnimating];
                [UIManager sharedUIManager].backOffBolck(nil);
                
            });
        }
        
        else{
//            int curTimeLeave = timeLeave;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面
////                [weakSelf showSkipBtnTitleTime:curTimeLeave];
//            });
            --timeLeave;
        }
    });
    dispatch_resume(_timer);
}

- (void)cancleGCDTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

@end
