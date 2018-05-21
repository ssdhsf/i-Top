//
//  CustomRequirementsComments.h
//  itop
//
//  Created by huangli on 2018/5/2.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CustomRequirementsComments : JSONModel

@property (strong ,nonatomic)NSNumber <Optional>*id;
@property (strong ,nonatomic)NSNumber <Optional>*user_id;
@property (strong ,nonatomic)NSNumber <Optional>*demand_id;
@property (strong ,nonatomic)NSString <Optional>*content;
@property (strong ,nonatomic)NSString <Optional>*create_datetime;


//企业
@property (strong ,nonatomic)NSNumber <Optional>*quality;
@property (strong ,nonatomic)NSNumber <Optional>*time;
@property (strong ,nonatomic)NSNumber <Optional>*profession;

//设计师
@property (strong ,nonatomic)NSNumber <Optional>*specific;
@property (strong ,nonatomic)NSNumber <Optional>*change;
@property (strong ,nonatomic)NSNumber <Optional>*attitude;

/**
 * id : 16
 * user_id : 81
 * demand_id : 64
 * quality : 3
 * time : 3
 * profession : 3
 * content : 小强的评价
 * create_datetime : 2018-04-25 21:06:15
 */


/**
 * id : 2
 * user_id : 80
 * demand_id : 64
 * specific : 5
 * change : 5
 * attitude : 5
 * content : itop.cn
 * create_datetime : 2018-04-24 10:37:25
 */

@end
