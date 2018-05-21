//
//  CustomRequirementsDetail.h
//  itop
//
//  Created by huangli on 2018/4/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Demand.h"
#import "Enterprise.h"

@interface CustomRequirementsDetail : JSONModel

@property (strong ,nonatomic)Demand <Demand , Optional>*demand;
@property (strong ,nonatomic)NSArray <Optional>*designer_list;
@property (strong ,nonatomic)Enterprise <Enterprise , Optional>*enterprise;

@end
