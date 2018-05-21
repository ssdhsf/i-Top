//
//  ReleaseHotViewController.h
//  itop
//
//  Created by huangli on 2018/3/16.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, ReleaseHotType) { //发布热点类型
    ReleaseHotTypeAdd = 0, //添加
    ReleaseHotTypeUpdata = 1,//更新
};

@interface ReleaseHotViewController : BaseViewController

@property (nonatomic, strong)HotDetails *hotDetail;
@property (nonatomic ,assign)ItemDetailType itemDetailType;
@property (nonatomic ,assign)ReleaseHotType releaseHotType;

@end
