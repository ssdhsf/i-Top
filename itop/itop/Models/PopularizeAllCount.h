//
//  PopularizeAllCount.h
//  itop
//
//  Created by huangli on 2018/4/11.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PopularizeAllCount : JSONModel

@property (nonatomic, strong)NSString <Optional>*user_id;
@property (nonatomic, strong)NSString <Optional>*rows_count;
@property (nonatomic, strong)NSString <Optional>*share_count;
@property (nonatomic, strong)NSString <Optional>*register_count;
@property (nonatomic, strong)NSString <Optional>*browse_count;
@property (nonatomic, strong)NSString <Optional>*reward_count;
//"user_id": "17",
//"rows_count": "10",
//"share_count": "7628",
//"register_count": "988",
//"browse_count": "0",
//"reward_count": null
@end
