//
//  CustomRequirementsDegsinList.h
//  itop
//
//  Created by huangli on 2018/4/23.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CustomRequirementsDegsinList : JSONModel

@property (nonatomic, strong)NSString <Optional>*nickname;
@property (nonatomic, strong)NSString <Optional>*head_img;
@property (nonatomic, strong)NSString <Optional>*bid;
@property (nonatomic, strong)NSNumber <Optional>*success_bid;
@property (nonatomic, strong)NSString <Optional>*designer_id;
@property (nonatomic, strong)NSString <Optional>*demand_count;
@property (nonatomic, strong)NSString <Optional>*score_average;
@property (nonatomic, strong)NSString <Optional>*dispute;

//"nickname": "我是设计师01",
//"head_img": "http://192.168.7.100:9000/files/img/20180419/201804191619309506.jpg",
//"bid": true,
//"success_bid": true,
//"designer_id": 82,
//"demand_count": 0,
//"score_average": 0,
//"dispute": 0

@end
