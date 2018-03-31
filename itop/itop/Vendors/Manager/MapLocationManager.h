//
//  BMKLocationManager.h
//  itop
//
//  Created by huangli on 2018/3/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BMKLocationkit/BMKLocationComponent.h>
#import <BMKLocationKit/BMKLocationAuth.h>

@interface MapLocationManager : NSObject<BMKLocationAuthDelegate,BMKLocationManagerDelegate>

@property (nonatomic, strong)BMKLocationManager *locationManager;
@property (nonatomic, strong)NSString *location;

+(instancetype)sharedMapLocationManager;

-(void)initMapLocation;

@end
