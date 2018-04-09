//
//  ProvinceStore.h
//  itop
//
//  Created by huangli on 2018/4/1.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceStore : NSObject

+ (instancetype)shearProvinceStore;

-(NSMutableArray *)configurationProvinceStoreMenuWithMenu:(NSArray *)arr;
-(NSMutableArray *)screeningLetter;

@end

@interface SelecteProvinceModel : NSObject

@property (nonatomic, strong)NSString *letterKey;
@property (nonatomic, strong)NSMutableArray *letterProvince;

@end


