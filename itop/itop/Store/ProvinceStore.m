//
//  ProvinceStore.m
//  itop
//
//  Created by huangli on 2018/4/1.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ProvinceStore.h"
#import "CompanySigningStore.h"
#import "MapLocationManager.h"

@implementation ProvinceStore

+ (instancetype)shearProvinceStore{
    
    static ProvinceStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[ProvinceStore alloc]init];
    });
    return store;
}


-(NSMutableArray *)configurationProvinceStoreMenuWithMenu:(NSArray *)arr{
    
    NSMutableArray *cityModelArray = [NSMutableArray array];
    for (NSString *letter in [self partition]) {
    
        for (NSDictionary *dic in arr) {
            
            if ([dic[@"pinyin"] isEqualToString:letter]) {
                
                SelecteProvinceModel *province = [[SelecteProvinceModel alloc]init];
                province.letterKey = dic[@"pinyin"];
                province.letterProvince = [NSMutableArray array];
                
                for (NSDictionary *cityDic in dic[@"city"]) {
                    
                    City *city = [[City alloc]initWithDictionary:cityDic error:nil];
                    [province.letterProvince addObject:city];
                    
                }
                
                [cityModelArray addObject:province];
            }
        }
    }
//
//    for (NSString *letter in [self partition]) {
//        
//        SelecteProvinceModel *province = [[SelecteProvinceModel alloc]init];
//        province.letterProvince = [NSMutableArray array];
//        
//        for (Province *city in cityArray) {
//            
//            NSString *first = [Global transform:city.address];
//            
//            if ([first isEqualToString:letter]) {
//                
//                [province.letterProvince addObject:city];
//            }
//        }
//        province.letterKey = letter;
//        
//        
//        if (province.letterProvince.count != 0) {
//            [cityModelArray addObject:province];
//        }
//    }
    SelecteProvinceModel *model = [[SelecteProvinceModel alloc]init];
    model.letterKey = @"当";
    model.letterProvince = [NSMutableArray array];
    City *locationCity  = [[City alloc]init];
    [model.letterProvince addObject:locationCity];
    
    if ([MapLocationManager sharedMapLocationManager].location != nil) {
        NSArray *provinceArray = [[CompanySigningStore shearCompanySigningStore]provinceArray];
        NSMutableArray *nativeCityArray = [NSMutableArray array];
        for (Province *province in provinceArray) {
            
            [nativeCityArray addObjectsFromArray:province.cityArray];
        }
        for (Province *tempCity in nativeCityArray) {
            
            if ([tempCity.address isEqualToString:[MapLocationManager sharedMapLocationManager].location]) {
                
                locationCity.name = tempCity.address;
                locationCity.code = tempCity.code;
                
                [cityModelArray insertObject:model atIndex:0];
//                return cityModelArray;
            }
        }
        
    } else {
        
        locationCity.name = @"定位失败";
//        locationCity.code = tempCity.code;
        
        [cityModelArray insertObject:model atIndex:0];
//        return cityModelArray;

    }
    return cityModelArray;
}

-(NSArray*)partition{
    
    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
}

-(NSMutableArray *)screeningLetter{
    
    NSMutableArray *array = [NSMutableArray array];
    for (SelecteProvinceModel *model in [self configurationProvinceStoreMenuWithMenu:nil]) {
        
        [array addObject:model.letterKey];
    }
    return  array;
}

@end

@implementation SelecteProvinceModel

@end
