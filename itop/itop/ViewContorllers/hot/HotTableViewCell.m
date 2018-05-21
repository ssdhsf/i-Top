//
//  HotTableViewCell.m
//  itop
//
//  Created by huangli on 2018/1/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "HotTableViewCell.h"
#import "HotH5ItmeViewController.h"
#import "RecommendedViewController.h"

@implementation HotTableViewCell


-(void)setItmeWithItmeTitle:(NSString *)itmeTitle indexPath:(NSIndexPath *)indexPath{
    
    if ([itmeTitle isEqualToString:@"H5"] || [itmeTitle isEqualToString:@"视频"]) {

        if (_h5Vc == nil) {
            _h5Vc = [[HotH5ItmeViewController alloc]initWithNibName:@"HotH5ItmeViewController" bundle:nil];
            _h5Vc.view.frame = CGRectMake(0, 0,  ScreenHeigh-65, ScreenWidth);
            
            _h5Vc.view.transform = CGAffineTransformMakeRotation(-(M_PI / 2*3 ));
            _h5Vc.view.frame = CGRectMake(0, 0, ScreenHeigh-65, ScreenWidth);
//            [_h5Vc addView];

        }
        [self addSubview:_h5Vc.view];

    } else {
        
        if (_RecommendedVc == nil) {
            _RecommendedVc = [[RecommendedViewController alloc]init];
            _RecommendedVc.view.frame = CGRectMake(0, 0,  ScreenHeigh-65, ScreenWidth);
            
            _RecommendedVc.view.transform = CGAffineTransformMakeRotation(-(M_PI / 2*3 ));
            _RecommendedVc.view.frame = CGRectMake(0, 0, ScreenHeigh-65, ScreenWidth);
        }
        
        [self addSubview:_RecommendedVc.view];
        
    }
}


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == nil) {
        for (UIView *subView in self.subviews) {
            CGPoint myPoint = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, myPoint)) {
                
                return subView;
            }
        }
    }
    
    return view;
}


@end
