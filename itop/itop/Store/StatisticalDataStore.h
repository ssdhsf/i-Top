//
//  StatisticalDataStore.h
//  itop
//
//  Created by huangli on 2018/1/22.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatisticalDataStore : NSObject

+ (instancetype)shearStatisticalDataStore;

- (NSMutableArray *)configurationStatisticalDataWithUserType:(UserType )user_type itmeType:(StatisticalItmeType)itme_type;

//组织曲线模型；
-(NSMutableArray *)itmeDataModelWithDictionarys:(NSArray *)Dictionarys
                                     ThemeColor:(UIColor *)ThemeColor;

-(NSArray *)coordinatesYElementsPiecewiseWithMaxCount:(NSInteger)maxCount;
@end
