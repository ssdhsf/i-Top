//
//  DesignerSigningStore.m
//  itop
//
//  Created by huangli on 2018/3/5.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DesignerSigningStore.h"

@implementation DesignerSigningStore


+ (instancetype)shearDesignerSigningStore{
    
    static DesignerSigningStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[DesignerSigningStore alloc]init];
    });
    return store;

}

//-(NSArray *)fieldArray{
//    
//    NSArray *fieldArray = @[@"企业宣传",@"企业招聘",@"产品介绍",@"活动促销",@"报名培训",@"会议邀请",@"品牌推广",@"节日传情",@"商务科技",@"扁平简约",@"清新文艺",@"卡通手绘",@"时尚炫酷",@"中国风",@"最多选3个"];
//    return fieldArray;
//}

@end
