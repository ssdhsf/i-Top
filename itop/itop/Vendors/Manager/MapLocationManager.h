//
//  BMKLocationManager.h
//  itop
//
//  Created by huangli on 2018/3/30.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapLocationManager : NSObject<BMKLocationAuthDelegate,BMKLocationManagerDelegate>

@property (nonatomic, strong)BMKLocationManager *locationManager;
@property (nonatomic, strong)NSString *location;
@property (nonatomic, strong)NSString *province;

+(instancetype)sharedMapLocationManager;

-(void)initMapLocation;

@end
