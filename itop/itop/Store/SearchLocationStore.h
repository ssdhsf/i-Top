//
//  SearchLocationStore.h
//  itop
//
//  Created by huangli on 2018/3/23.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchLocationStore : NSObject

+ (instancetype)shearaSearchLocationStore;

//解析搜索建议数据
-(NSMutableArray *)configurationSearchLocationMenuWithSearchSuggestionKey:(NSArray *)searchKeyList
                                                     searchSuggestionCity:(NSArray *)searchCityList
                                                 searchSuggestionDistrict:(NSArray *)searchdistrictList
                                                    laocationCoordinate2D:(NSArray *)locationCoordinate2D;


-(NSArray *)scopeArray;
-(NSInteger )scopeArrayWithObj:(NSString *)obj;
-(NSArray *)scopeValueArray;


@end
