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
   
    NSArray *provinceArray = [[CompanySigningStore shearCompanySigningStore]provinceArray];
    NSMutableArray *cityArray = [NSMutableArray array];
    NSMutableArray *cityModelArray = [NSMutableArray array];
    
    for (Province *province in provinceArray) {
        
        [cityArray addObjectsFromArray:province.cityArray];
    }

    for (NSString *letter in [self partition]) {
        
        SelecteProvinceModel *province = [[SelecteProvinceModel alloc]init];
        province.letterProvince = [NSMutableArray array];
        
        for (Province *city in cityArray) {
            
            NSString *first = [Global transform:city.address];
            
            if ([first isEqualToString:letter]) {
                
                [province.letterProvince addObject:city];
            }
        }
        province.letterKey = letter;
        
        
        if (province.letterProvince.count != 0) {
            [cityModelArray addObject:province];
        }
    }
    SelecteProvinceModel *model = [[SelecteProvinceModel alloc]init];
    model.letterKey = @"当";
    model.letterProvince = [NSMutableArray array];
    Province *locationCity  = [[Province alloc]init];
    [model.letterProvince addObject:locationCity];
    
    if ([MapLocationManager sharedMapLocationManager].location != nil) {
        
        for (SelecteProvinceModel *provinceModel in cityModelArray) {
            for (Province *tempCity in provinceModel.letterProvince) {
                
                if ([tempCity.address isEqualToString:[MapLocationManager sharedMapLocationManager].location]) {
                    
                    locationCity.address = tempCity.address;
                    locationCity.code = tempCity.code;
                    
                    [cityModelArray insertObject:model atIndex:0];
                    return cityModelArray;
                }
            }
        }
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
