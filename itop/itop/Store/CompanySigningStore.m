//
//  CompanySigningStore.m
//  itop
//
//  Created by huangli on 2018/2/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CompanySigningStore.h"

@implementation CompanySigningStore

+ (instancetype)shearCompanySigningStore{
    
    static CompanySigningStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[CompanySigningStore alloc]init];
    });
    return store;
}

-(NSDictionary *)industryArray{
    
    NSDictionary *array = @{@"商品交易":@[@"快消零售",@"电商",@"汽车",@"家居",@"家电",@"母婴",@"图书",@"电子数码",@"服装服饰",@"批发",@"外贸"],
                            @"生活服务":@[@"餐饮",@"旅游",@"住宿",@"租赁",@"娱乐",@"美容",@"摄影",@"法律",@"物流",@"婚庆",@"自媒体",@"装修",@"家政",@"其他"],
                            @"商务服务":@[@"广告",@"设计",@"咨询",@"传媒",@"金融",@"房地产",@"交通",@"运输",@"保险",@"其他"],
                            @"科技服务":@[@"互联网",@"软件",@"游戏",@"IT服务",@"通信",@"科学技术",@"其他"],
                              @"工农业":@[@"制造业",@"生产加工业",@"建筑业",@"农牧业"],
                            @"机构组织":@[@"教育培训",@"医疗卫生",@"政府机构",@"社会组织",@"公益组织",@"个人"]};
    return array;
}

-(NSArray *)companySizeArray{
    
    NSArray *array = @[@"1-49",@"50-99",@"100-499",@"500-9999",@"1000-2000",@"2000-5000",@"5000-10000",@"10000以上",];
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

@end
