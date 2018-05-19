//
//  BidDesginerList.h
//  itop
//
//  Created by huangli on 2018/5/16.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BidDesginerList : JSONModel

@property (strong ,nonatomic)NSString <Optional>*nickname;
@property (strong ,nonatomic)NSString <Optional>*head_img;
@property (strong ,nonatomic)NSString <Optional>*bid;
@property (strong ,nonatomic)NSString <Optional>*success_bid;
@property (strong ,nonatomic)NSNumber <Optional>*designer_id;
@property (strong ,nonatomic)NSString <Optional>*demand_count;
@property (strong ,nonatomic)NSString <Optional>*score_average;
@property (strong ,nonatomic)NSString <Optional>*update_datetime;
@property (strong ,nonatomic)NSString <Optional>*dispute;
@end
