//
//  CompanySigningStore.m
//  itop
//
//  Created by huangli on 2018/2/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CompanySigningStore.h"

static NSArray *_superTagList = nil;
static NSArray *_fieldList = nil;

@implementation CompanySigningStore

+ (instancetype)shearCompanySigningStore{
    
    static CompanySigningStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[CompanySigningStore alloc]init];
    });
    return store;
}

-(NSArray *)companySizeArray{
    
    NSArray *array = @[@"1-49人",@"50-99人",@"100-499人",@"500-9999人",@"1000-2000人",@"2000-5000人",@"5000-10000人",@"10000人以上",];
    return array;
}

-(NSArray *)provinceArray{
    
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city-picker.data" ofType:@"json"]];
    NSDictionary *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"%@",dataArray);
    NSDictionary *dic = dataArray[@"86"];
    NSMutableArray *tempProvinceArray = [NSMutableArray array];
    [tempProvinceArray addObjectsFromArray:(NSArray *)dic[@"A-G"]];
    [tempProvinceArray addObjectsFromArray:(NSArray *)dic[@"H-K"]];
    [tempProvinceArray addObjectsFromArray:(NSArray *)dic[@"L-S"]];
    [tempProvinceArray addObjectsFromArray:(NSArray *)dic[@"T-Z"]];
    
   NSMutableArray *provinceArray = [NSMutableArray array];
//    _cityArray = [NSMutableArray array];
    for (NSDictionary *dic in tempProvinceArray) {
        
        Province *province = [[Province alloc]initWithDictionary:dic error:nil];
        NSDictionary *cityDic = dataArray[province.code];
        NSMutableArray *tmpeCityArray = [NSMutableArray array];
        NSArray *key = [cityDic allKeys];
        for (NSString *cityCode in key) {
            
            Province *city = [[Province alloc]init];
            city.code = cityCode;
            city.address = cityDic[cityCode];
            [tmpeCityArray addObject:city];
        }
        province.cityArray = tmpeCityArray;
        [provinceArray addObject:province];
    }

    return provinceArray;
}

-(void )confitionIndustryWithRequstIndustryArray:(NSArray *)array{
    
    NSMutableArray *tagArr = [NSMutableArray array];
    for (NSDictionary * dic in array) {
        
        TagList *tag = [[TagList alloc]initWithDictionary:dic error:nil];
        if ([tag.parent_id isEqualToNumber:@0]) {
            
            [tagArr addObject:tag];
            NSMutableArray *subTagArray = [NSMutableArray array];
            
            for (NSDictionary * dic in array) {
                
                 TagList *subTag = [[TagList alloc]initWithDictionary:dic error:nil];
                if ([subTag.parent_id isEqualToNumber:tag.id]) {
                    
                    [subTagArray addObject:subTag];
                }
            }
            
            tag.subTagArray = subTagArray;
        }
    }
    
    _superTagList = tagArr;
}


-(void)confitionFieldWithRequstFieldArray:(NSArray *)array{
    
    NSMutableArray *tagArr = [NSMutableArray array];
    for (NSDictionary * dic in array) {
        
        TagList *tag = [[TagList alloc]initWithDictionary:dic error:nil];
        [tagArr addObject:tag];
    }
    _fieldList = tagArr;
}

-(NSArray *)confitionChannelListWithRequstChannelListArray:(NSArray *)array{
    
    NSMutableArray *tagArr = [NSMutableArray array];
    for (NSDictionary * dic in array) {
        
        ChannelList *tag = [[ChannelList alloc]initWithDictionary:dic error:nil];
        [tagArr addObject:tag];
    }
    return tagArr;
}

-(NSArray *)superTagList{
    
    return _superTagList;
}

-(NSArray *)fieldList{
    
    return _fieldList;
}

-(Province *)provinceWithProvinceCode:(NSString *)code{
    

    for (Province *province in [self provinceArray]  ) {
        
        if ([province.code isEqualToString:code] || [province.address isEqualToString:code]) {
            
            return province;
        }
    }
    return nil;
}

-(Province *)cityWithCityCode:(NSString *)cityCode provinceCode:(NSString *)provinceCode{
    
    
    for (Province *province in [self provinceArray]) {
        
        if ([province.code isEqualToString:provinceCode] || [province.address isEqualToString:provinceCode]) {
            
            for (Province *city in province.cityArray) {
                
                if ([city.code isEqualToString:cityCode] || [city.address isEqualToString:cityCode]) {
                    
                    return city;
                    
                }
            }
        }
    }
    return nil;
}

-(TagList *)superTagWithTagId:(id )tag_id {
    
    for (TagList *tagList in _superTagList) {
        
    
        if ([tag_id isKindOfClass:[NSNumber class]] ? [tagList.id isEqualToNumber:(NSNumber *)tag_id] : [tagList.name isEqualToString:(NSString *)tag_id]) {
            
            return tagList;
        }
    }
    return nil;
}


-(TagList *)fieldWithTagId:(NSNumber *)tag_id {
    
    for (TagList *tagList in _fieldList) {
        
        
        if ([tag_id isKindOfClass:[NSNumber class]] ? [tagList.id isEqualToNumber:tag_id] : [tagList.name isEqualToString:(NSString *)tag_id]) {
            
            return tagList;
        }
    }
    return nil;
}


-(TagList *)subTagWithTagId:(NSNumber *)tag_id superTagId:(NSNumber *)superTagId{
    
    for (TagList *superTag in _superTagList) {
        
        if ([tag_id isKindOfClass:[NSNumber class]] ? [superTag.id isEqualToNumber:superTagId] : [superTag.name isEqualToString:(NSString *)superTagId]) {
            
            for (TagList *subTag in superTag.subTagArray) {
               
                if ([tag_id isKindOfClass:[NSNumber class]] ? [subTag.id isEqualToNumber:tag_id] : [subTag.name isEqualToString:(NSString *)tag_id]) {
                    
                    return subTag;
                }
            }
        }
    }
    return nil;
}

@end
