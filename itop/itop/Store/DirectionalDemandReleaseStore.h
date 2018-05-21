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
                                                        isEdit:(BOOL)isEdit; //配置定制管理Itme

- (NSMutableArray *)configurationCaseWitiCaseDetail:(CaseDetail *)caseDetail
                                             isEdit:(BOOL)isEdit; //配置添加案例Item

- (NSMutableArray *)configurationUploadProduct;//配置作品上传Item

- (NSMutableArray *)configurationUploadProductDetailWithProductDetail:(BiddingProduct *)productDetail; //获取作品详情itme

@end
