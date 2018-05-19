//
//  CustomRequirementsStore.h
//  itop
//
//  Created by huangli on 2018/4/19.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomRequirementsStore : NSObject

+ (instancetype)shearCustomRequirementsStore;

- (NSMutableArray *)configurationCustomRequirementsWithRequsData:(NSArray *)arr;

- (NSMutableArray *)configurationCustomRequirementsDetailWithMenu:(CustomRequirementsDetail *)datail teader:(NSString *)teader; //首页显示定制详情

- (NSMutableArray *)configurationMyCustomRequirementsDetailWithMenu:(CustomRequirementsDetail *)datail
                                                         demandType:(DemandType)demandType
                                                           desginer:(DesignerList*)desginer
                                                           editCase:(EditCase*)editCase
                                                             teader:(NSString *)teader;//我的订单显示定制详情
-(NSString *)stateStringWithCheckState:(int)chechState; //订单路径

- (NSMutableArray *)configurationCustomRequirementsListWithRequsData:(NSArray *)arr;

-(NSArray *)operationStateWithState:(CustomRequirementsType)state demandType:(DemandType)demandType;//列表显示状态操作

-(NSString *)showStateWithState:(CustomRequirementsType)state;//显示状态

-(NSArray *)showPageTitleWithState:(CustomRequirementsType)state demandType:(DemandType)demandType;//详情页显示项

-(NSArray *)configurationCustomRequirementsCommentsWithRequsData:(NSArray *)arr;

-(BidDesginerList *)getBidDesginerListWithRequsData:(NSArray *)arr;

@end
