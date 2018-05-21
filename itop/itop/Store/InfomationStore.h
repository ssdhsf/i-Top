//
//  InfomationStore.h
//  itop
//
//  Created by huangli on 2018/2/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfomationStore : NSObject

+ (instancetype)shearInfomationStore;

//- (NSMutableArray *)configurationMenuWithInfomationModel:(InfomationModel *)info;
- (NSMutableArray *)configurationMenuWithUserInfo:(InfomationModel *)info userType:(UserType )user_type;

- (NSInteger)indexWithSex:(NSString *)sex;

-(NSString *)sexWithIndex:(NSString *)indexStr;
//- (NSString*)provinceAppdingCity:(NSString *)province city:(NSString *)city;

-(NSArray *)sexArray;
-(NSString *)userVersionWithVersion:(NSString*)version;//企业等级

@end
