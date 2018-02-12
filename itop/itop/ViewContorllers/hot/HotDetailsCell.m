//
//  HotDetailsCell.m
//  itop
//
//  Created by huangli on 2018/1/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "HotDetailsCell.h"

#define standOutHeight 8

@implementation HotDetailsCell


- (void)setItmeOfModel:(HotComments*)hotComment{
    
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:hotComment.user_head_img] placeholderImage:PlaceholderImage];
    
    self.userImageView.layer.cornerRadius = self.userImageView.height/2;
    self.userImageView.layer.masksToBounds = YES;
    self.userName.text = hotComment.user_name;
    self.timeLabel.text = [[Global sharedSingleton]timestampTotimeStringWithtimestamp:hotComment.create_datetime pattern:TIME_PATTERN_minute];
    
    CGFloat contentLabheight = [Global heightWithString:hotComment.content width:ScreenWidth-CGRectGetMaxX(_userImageView.frame)-25 fontSize:15];
    _contentLabel.frame = CGRectMake(CGRectGetMaxX(_userImageView.frame)+5, CGRectGetMaxY(_userName.frame)+6, ScreenWidth-CGRectGetMaxX(_userImageView.frame)-25, contentLabheight);
    self.contentLabel.text = hotComment.content;
    
    if (hotComment.replyString != nil) {
        
        _bubbleView.hidden = NO;
        _replyLabel.hidden = NO;
        NSInteger _replyLabelHeight = [Global heightWithString:hotComment.replyString width:ScreenWidth-CGRectGetMaxX(_userImageView.frame)-25 fontSize:15];
        
        _bubbleView.frame =CGRectMake(65, CGRectGetMaxY(_contentLabel.frame)+5, ScreenWidth-CGRectGetMaxX(_userImageView.frame)-25,standOutHeight);
        [self drawTabbarBgImageView];
        
        NSLog(@"%f",_replyLabel.height);
        _replyLabel.frame = CGRectMake(65, CGRectGetMaxY(_bubbleView.frame), ScreenWidth-CGRectGetMaxX(_userImageView.frame)-25, _replyLabelHeight+10);
        _replyLabel.text = hotComment.replyString;
        _replyLabel.backgroundColor = RGB(239, 239, 244);
    } else {
        
        _bubbleView.hidden = YES;
        _replyLabel.hidden = YES;
    }
}

- (void)drawTabbarBgImageView{
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, standOutHeight)];
    [path addLineToPoint:CGPointMake(20,standOutHeight)];
    [path addLineToPoint:CGPointMake(25,0)];
    [path addLineToPoint:CGPointMake(30,standOutHeight)];
    [path addLineToPoint:CGPointMake(ScreenWidth-CGRectGetMaxX(_userImageView.frame)-25,standOutHeight)];
//    [path addLineToPoint:CGPointMake(ScreenWidth-CGRectGetMaxX(_userImageView.frame)-25,frame.size.height)];
//    [path addLineToPoint:CGPointMake(0,frame.size.height)];
//    [path addLineToPoint:CGPointMake(0,standOutHeight)];
    
    layer.path = path.CGPath;
    layer.fillColor = RGB(239, 239, 244).CGColor;
    NSArray *arr = [_replyLabel.layer sublayers];
    if (arr !=nil) {
        for ( int i = 1 ; i < arr.count;i++) {
            
            CAShapeLayer *layers = arr[i];
            [layers removeFromSuperlayer];
        }
    }
        [_bubbleView.layer insertSublayer:layer atIndex:0];
//    _replyLabel.backgroundColor = RGB(239, 239, 244);
}

@end
