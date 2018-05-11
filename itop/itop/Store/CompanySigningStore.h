//
//  CompanySigningStore.h
//  itop
//
//  Created by huangli on 2018/2/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanySigningStore : NSObject


+ (instancetype)shearCompanySigningStore;

//-(NSDictionary *)industryArray;
-(NSArray *)companySizeArray;
-(NSArray *)provinceArray;

- (NSArray *)superTagList;
- (NSArray *)fieldList;

-(void)cacheIndustryWithIndustryArray:(NSArray *)array;

-(void)confitionIndustryWithRequstIndustryArray:(NSArray *)array;
-(void)confitionFieldWithRequstFieldArray:(NSArray *)array;

-(NSArray *)confitionChannelListWithRequstChannelListArray:(NSArray *)array;

-(Province *)provinceWithProvinceCode:(NSString *)code;//获取某个省份
-(Province *)cityWithCityCode:(NSString *)cityCode provinceCode:(NSString *)provinceCode;//获取某个城市

-(TagList *)superTagWithTagId:(NSNumber *)tag_id ;//获取某个行业

-(TagList *)subTagWithTagId:(NSNumber *)tag_id superTagId:(NSNumber *)superTagId;//获取某个子行业

-(TagList *)fieldWithTagId:(NSNumber *)tag_id;//获取某个擅长领域
@end
