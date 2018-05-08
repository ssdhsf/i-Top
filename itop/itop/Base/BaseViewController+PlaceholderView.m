//
//  BaseViewController+PlaceholderView.m
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseViewController+PlaceholderView.h"

@implementation BaseViewController (PlaceholderView)


-(void)setHasData:(BOOL)hasData{
    
    [self setisHasData:hasData noDataType:self.noDataType origin:self.originY];
}

- (void)setisHasData:(BOOL)isHasData
          noDataType:(NoDataType)noDataType
              origin:(NSInteger)originY{
    
    if (!self.showImg) {
//        self.hideView = [[UIView alloc] initWithFrame:CGRectMake(0, originY, ScreenWidth, ScreenHeigh-originY)];
//        self.hideView.tag=1;
//        [self.view addSubview:self.hideView];
        self.showImg = [[UIImageView alloc] init];
        
        switch (noDataType) {
            case NoDataTypeDefult:
                self.showImg.image =  [UIImage imageNamed:@"nothing"];
                break;
            case NoDataTypeProduct:
                self.showImg.image =  [UIImage imageNamed:@"noproduction"];
                break;

            case NoDataTypeMessage:
                self.showImg.image =  [UIImage imageNamed:@"nomassage"];
                break;

            case NoDataTypeBusiness:
                self.showImg.image =  [UIImage imageNamed:@"nobusiness"];
                break;
                
            case NoDataTypeLacation:
                self.showImg.image =  [UIImage imageNamed:@"nolacation"];
                break;
                
            default:
                break;
        }
        self.showImg.frame = CGRectMake(60, self.originY, ScreenWidth-120, (ScreenWidth-120)*1.07f);
        
        self.tipsLab = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.showImg.frame)+30, ScreenWidth-80, 90)];
        NSString *tipString = @"没有有数据";
        if(self.showViewType ==1)
        {
            tipString = @"暂无数据";
        }
        if(self.showViewType ==2)
        {
            tipString = @"当前没有记录,请点击右上角按钮进行创建";
        }
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:tipString];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:12];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [tipString length])];
        [self.tipsLab setAttributedText:attributedString1];
        self.tipsLab.numberOfLines = 0;
        self.tipsLab.textColor = [UIColor lightGrayColor];
        self.tipsLab.textAlignment = NSTextAlignmentCenter;
        self.tipsLab.font = [UIFont systemFontOfSize:19];
        [self.view addSubview:self.tipsLab];
        [self.view addSubview:self.showImg];
//        self.hideView.hidden = isHasData;
        self.showImg.hidden = isHasData;
        self.tipsLab.hidden = isHasData;
    } else {
        
//        [self.view addSubview:self.hideView];
//        self.hideView.hidden = isHasData;
        self.showImg.hidden = isHasData;
        self.tipsLab.hidden = isHasData;
    }
}

#pragma Mark- 切换页面如果有数据就清除占为图片
-(void)removeHiderView{
    
    for(id tmpView in [self.view subviews]){
        //找到要删除的子视图的对象
        if([tmpView isKindOfClass:[UIView class]]){
            
            UIView *imgView = (UIView *)tmpView;
            if(imgView.tag == 1){  //判断是否满足自己要删除的子视图的条件
                [imgView removeFromSuperview]; //删除子视图
                
                break;  //跳出for循环，因为子视图已经找到，无须往下遍历
            }
        }
    }
}


@end
