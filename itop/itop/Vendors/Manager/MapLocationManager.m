//
//  BMKLocationManager.m
//  itop
//
//  Created by huangli on 2018/3/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MapLocationManager.h"

@implementation MapLocationManager

+(instancetype)sharedMapLocationManager{
    
    static MapLocationManager *organization = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken ,^{
        organization  = [[MapLocationManager alloc]init];
    });
    return organization;

}

-(void)initMapLocation{
    
    NSLog(@"%@",BAIDU_MAP_AKAPKEY);
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:BAIDU_MAP_AKAPKEY authDelegate:self];
    //初始化实例
    _locationManager = [[BMKLocationManager alloc] init];
    //设置delegate
    _locationManager.delegate = self;
    //设置返回位置的坐标系类型
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    //设置距离过滤参数
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //设置预期精度参数
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置应用位置类型
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    //设置是否自动停止位置更新
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    //设置是否允许后台定位
    _locationManager.allowsBackgroundLocationUpdates = NO;
    //设置位置获取超时时间
    _locationManager.locationTimeout = 10;
    //设置获取地址信息超时时间
    _locationManager.reGeocodeTimeout = 10;
    
    [_locationManager requestLocationWithReGeocode:YES withNetworkState:NO completionBlock:^(BMKLocation *location, BMKLocationNetworkState state, NSError *error)
     {
         if (error)
         {
             
#if TARGET_IPHONE_SIMULATOR
             
             //模拟器不发送定位失败
#else
             
             [UserManager shareUserManager].mapLocationManagerFailure(error);
             NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
#endif

         }
         if (location) {//得到定位信息，添加annotation
             
             if (location.location) {
                 NSLog(@"LOC = %@",location.location);
             }
             if (location.rgcData) {
                 
//                 self.loctionLable.text = [NSString stringWithFormat:@"%@",[location.rgcData.city description]];
                 //                 [self setLeftBarItemString:[NSString stringWithFormat:@"%@>",[location.rgcData.city description]] action:@selector(selectorCity)];
                 
                 self.location = [location.rgcData.city description];
                 [UserManager shareUserManager].mapLocationManagerSuccess(self.location);
                 NSLog(@"rgc = %@",[location.rgcData.city description]);
             }
         }
         NSLog(@"netstate = %d",state);
     }];
}

@end
