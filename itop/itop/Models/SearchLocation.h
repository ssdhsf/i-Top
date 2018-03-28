//
//  SearchLocation.h
//  itop
//
//  Created by huangli on 2018/3/23.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SearchLocation : JSONModel

@property(strong, nonatomic)NSString *searchLocation;
@property(strong, nonatomic)NSString *searchBelongs;
@property(assign, nonatomic)CGFloat  longitude;
@property(assign, nonatomic)CGFloat  latitude;

@end
