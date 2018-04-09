//
//  SearchLocationStore.m
//  itop
//
//  Created by huangli on 2018/3/23.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SearchLocationStore.h"

@implementation SearchLocationStore

+ (instancetype)shearaSearchLocationStore{
    
    static SearchLocationStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[SearchLocationStore alloc]init];
    });
    return store;
}

//解析搜索建议数据
-(NSMutableArray *)configurationSearchLocationMenuWithSearchSuggestionKey:(NSArray *)searchKeyList
                                                      searchSuggestionCity:(NSArray *)searchCityList
                                                      searchSuggestionDistrict:(NSArray *)searchdistrictList
                                                     laocationCoordinate2D:(NSArray *)locationCoordinate2D
{
   
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i< searchKeyList.count; i++) {
        
         SearchLocation * searchLocation = [[ SearchLocation alloc]init];
         searchLocation.searchLocation = searchKeyList[i];
         searchLocation.searchBelongs = [NSString stringWithFormat:@"%@-%@",searchCityList[i],searchdistrictList[i]];
         [array addObject:searchLocation];
    
        NSValue *value = locationCoordinate2D[i];
        CLLocationCoordinate2D coor;
        [value getValue:&coor ];
        searchLocation.latitude = coor.latitude;
        searchLocation.longitude = coor.longitude;
    }

    return array;
}

-(NSArray *)scopeArray{
    
    NSArray *array = @[@"1公里",@"2公里",@"5公里",@"10公里",@"15公里",@"20公里",];
    return array;
}

-(NSInteger )scopeArrayWithObj:(NSString *)obj{
    
    NSInteger index = [self.scopeArray indexOfObject:obj];
    return index;
}

-(NSArray *)scopeValueArray{
    
    NSArray *array = @[@"1000",@"2000",@"5000",@"10000",@"15000",@"20000"];
    return array;
}

@end
