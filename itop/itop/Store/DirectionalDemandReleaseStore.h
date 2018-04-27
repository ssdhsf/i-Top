//
//  DirectionalDemandReleaseStore.h
//  itop
//
//  Created by huangli on 2018/4/22.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectionalDemandReleaseStore : NSObject

+ (instancetype)shearDirectionalDemandReleaseStore;
- (NSMutableArray *)configurationDirectionalDemandReleaseEditWithDemandType:(DemandType )demandType
                                                   customRequirementsDetail:(CustomRequirementsDetail *)customRequirementsDetail
                                                               desginerList:(NSArray *)desginerList
                                                        desginerProductList:(NSArray *)desginerProductList
                                                                   province:(Province *)province
                                                                       city:(Province *)city
                                                                     isEdit:(BOOL)isEdit;

@end
