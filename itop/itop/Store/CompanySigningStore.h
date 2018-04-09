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

-(NSDictionary *)industryArray;
-(NSArray *)companySizeArray;
-(NSArray *)provinceArray;

@end
