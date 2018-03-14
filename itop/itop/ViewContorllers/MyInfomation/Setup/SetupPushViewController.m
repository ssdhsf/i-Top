//
//  SetupPushViewController.m
//  itop
//
//  Created by huangli on 2018/3/11.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SetupPushViewController.h"

@interface SetupPushViewController ()

@property (weak, nonatomic) IBOutlet UIButton *instantButton;
@property (weak, nonatomic) IBOutlet UIView *instantView;

@property (weak, nonatomic) IBOutlet UIButton *timingButton;
@property (weak, nonatomic) IBOutlet UIView *timingView;
@property (assign, nonatomic) BOOL switchPush;

@end

@implementation SetupPushViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    
    [super initView];
    _instantView.layer.masksToBounds = YES;
    _instantView.layer.cornerRadius = _instantView.height/2;
    _timingView.layer.masksToBounds = YES;
    _timingView.layer.cornerRadius = _timingView.height/2;
    
    _instantView.backgroundColor = UIColorFromRGB(0xfda5ed);
    _instantButton.selected = YES;
}

-(void)initNavigationBarItems{
    
    self.title = @"通知设置";
    _switchPush = YES;
    self.navigationItem.rightBarButtonItem = [self customBarItem:@"data_button_on" action:@selector(pushSwitch:) size:CGSizeMake(45, 21)];
}

-(void)pushSwitch:(UIBarButtonItem *)sender{
    
    _switchPush = !_switchPush;
    if (!_switchPush) {
        self.navigationItem.rightBarButtonItem = [self customBarItem:@"data_button_off" action:@selector(pushSwitch:) size:CGSizeMake(45, 21)];
        _timingView.backgroundColor = UIColorFromRGB(0xe0e3e6);//灰色
        _instantView.backgroundColor = UIColorFromRGB(0xe0e3e6); //灰色
    } else {
        
        self.navigationItem.rightBarButtonItem = [self customBarItem:@"data_button_on" action:@selector(pushSwitch:) size:CGSizeMake(45, 21)];
        
        if (_instantButton.isSelected == YES) {
            _instantView.backgroundColor = UIColorFromRGB(0xfda5ed);
        }
        
        if (_timingButton.isSelected == YES) {
            _timingView.backgroundColor = UIColorFromRGB(0xfda5ed);
        }
    }
}

- (IBAction)pushItem:(UIButton *)sender {

    if (sender.tag == 1 && _instantButton.isSelected == NO) {
        
        _instantView.backgroundColor = UIColorFromRGB(0xfda5ed); //紫色
        _timingView.backgroundColor = UIColorFromRGB(0xe0e3e6);//灰色
        _instantButton.selected = YES;
        _timingButton.selected = NO;
        
    } else if (sender.tag == 2 && _timingButton.isSelected == NO){
        
        _timingView.backgroundColor = UIColorFromRGB(0xfda5ed); //紫色
        _instantView.backgroundColor = UIColorFromRGB(0xe0e3e6); //灰色
        _timingButton.selected = YES;
        _instantButton.selected = NO;

    } else {
        
        return;
    }
}



@end
