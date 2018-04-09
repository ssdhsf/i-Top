//
//  StatisticalData.h
//  itop
//
//  Created by huangli on 2018/1/22.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface StatisticalData : JSONModel

@property (nonatomic, strong)NSString <Optional>*title;
@property (nonatomic, strong)NSString <Optional>*content;
@property (nonatomic, strong)NSString <Optional>*type;
@property (nonatomic, strong)NSArray  <Optional>*dataModel;
@property (nonatomic, strong)UIColor  *markColor;

@end
