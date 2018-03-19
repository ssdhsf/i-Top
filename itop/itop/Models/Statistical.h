//
//  Statistical.h
//  itop
//
//  Created by huangli on 2018/3/19.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Statistical : JSONModel

@property (nonatomic, strong) NSArray <Optional>*commend_count_list;
@property (nonatomic, strong) NSArray <Optional>*comment_count_list;
@property (nonatomic, strong) NSArray <Optional>*product_count_list;
@property (nonatomic, strong) NSNumber <Optional>*comment_count_total;
@property (nonatomic, strong) NSNumber <Optional>*product_count_total;
@property (nonatomic, strong) NSNumber <Optional>*commend_count_total;

@end
