//
//  CustomRequirementsStore.m
//  itop
//
//  Created by huangli on 2018/4/19.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "CustomRequirementsStore.h"

@implementation CustomRequirementsStore

+ (instancetype)shearCustomRequirementsStore{
    
    static CustomRequirementsStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[CustomRequirementsStore alloc]init];
    });
    return store;
}

- (NSMutableArray *)configurationCustomRequirementsWithRequsData:(NSArray *)arr{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dic in arr) {
        
        CustomRequirements *custom = [[CustomRequirements alloc]initWithDictionary:dic error:nil];
        
        [array addObject:custom];
    }
    return array;
}

- (NSMutableArray *)configurationCustomRequirementsListWithRequsData:(NSArray *)arr{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dic in arr) {
        
        CustomRequirementsList *custom = [[CustomRequirementsList alloc]initWithDictionary:dic error:nil];
        custom.descrip = dic[@"description"];
        [array addObject:custom];
    }
    return array;
}

- (NSMutableArray *)configurationCustomRequirementsDetailWithMenu:(CustomRequirementsDetail *)datail{
    
    NSString *time = [[Global sharedSingleton]timeFormatTotimeStringFormatWithtime:datail.demand.finish_datetime willPattern:TIME_PATTERN_second didPattern:TIME_PATTERN_day];
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[self setupCustomRequirementsWithCustomRequirementsDetailTitle:@"订单号" content:datail.demand.pay_order_no]];
    [array addObject:[self setupCustomRequirementsWithCustomRequirementsDetailTitle:@"活动名称" content:datail.demand.contact_name]];
    [array addObject:[self setupCustomRequirementsWithCustomRequirementsDetailTitle:@"截稿时间" content:time]];
    [array addObject:[self setupCustomRequirementsWithCustomRequirementsDetailTitle:@"预算" content:datail.demand.price]];
    [array addObject:[self setupCustomRequirementsWithCustomRequirementsDetailTitle:@"参考网站" content:datail.demand.reference_url]];
    [array addObject:[self setupCustomRequirementsWithCustomRequirementsDetailTitle:@"参考图片" content:datail.demand.reference_img]];
    [array addObject:[self setupCustomRequirementsWithCustomRequirementsDetailTitle:@"行业" content:datail.demand.contact_name]];
    [array addObject:[self setupCustomRequirementsWithCustomRequirementsDetailTitle:@"地域要求" content:datail.demand.province]];
    [array addObject:[self setupCustomRequirementsWithCustomRequirementsDetailTitle:@"需求描述" content:datail.demand.descrip]];
    return array;
}

-(Infomation *)setupCustomRequirementsWithCustomRequirementsDetailTitle:(NSString *)title
                                                                content:(NSString *)content{
    
    Infomation *info = [[Infomation alloc]init];
    info.title = title;
    info.content = content;
    return info;
}


-(NSString *)stateStringWithCheckState:(int)chechState{
    
    NSString *checkSting = [NSString string];
    switch (chechState) {
        case 0:
            checkSting = @"发布";
            break;
        case 1:
            checkSting = @"审核";
            break;
        case 2:
            checkSting = @"投标中";
            break;
        case 3:
            checkSting = @"签单";
            break;
        case 4:
            checkSting = @"工作";
            break;
        case 5:
            checkSting = @"验收";
            break;
        case 6:
            checkSting = @"评价";
            break;
            
        default:
            break;
    }
    return checkSting;
}

-(NSArray *)operationStateWithState:(CustomRequirementsType)state demandType:(DemandType)demandType{
    
    NSArray *stateArray = [self operationArrayWithState:state ];
    return stateArray;
}

-(NSArray *)operationArrayWithState:(CustomRequirementsType)state{
    
    NSArray *array = @[@[@"编辑",@"下架",@"托管赏金",@"删除"],
                       @[@"托管赏金",@"平台介入",@"验收完成"],
                       @[@"删除"],
                       @[@"编辑",@"托管赏金"],
                       @[@"作品上传",@"平台介入",@"取消合作"],
                       @[@"重新发布",@"删除"],
                       @[@"删除"],
                       @[@"评价"],
                       @[@"评价"],
                       @[@"删除"],
                       @[@"编辑",@"删除"],
                       @[@"评价"],
                       @[@"删除"],
                       @[@"走你"],
                       @[@"你们干一架"]
                       ];
    return array[state];
    
}

-(NSString *)showStateArrayWithState:(CustomRequirementsType)state{
    
    NSArray *array = @[@"待接单",
                       @"已接单",
                       @"已拒绝",
                       @"竞标中",
                       @"竞标成功",
                       @"竞标失败",
                       @"竞标取消",
                       @"验收完成",
                       @"合作失败",
                       @"已完成",
                       @"审核中",
                       @"验收完成",
                       @"合作取消",
                       @"下架",
                       @"平台介入"];
    return array[state];
    
}

-(NSString *)showStateWithState:(CustomRequirementsType)state{
    
    NSString *stateString = [self showStateArrayWithState:state];
    return stateString;
}

-(NSArray *)showPageTitleWithState:(CustomRequirementsType)state demandType:(DemandType)demandType{
    
    NSArray *array ;
    switch (state) {
            
        case CustomRequirementsTypeUnAccept:
        case CustomRequirementsTypePending://审核中
        case CustomRequirementsTypeOut://下架
        case CustomRequirementsTypeNotPass://不通过
        case CustomRequirementsTypeCanceled://合作取消
        case CustomRequirementsTypeRefuse://已拒绝
        case CustomRequirementsTypeIntervention://平台介入
        case CustomRequirementsTypeBidFail://合作失败
            
            array = @[@"订单"];
            break;
            
        case CustomRequirementsTypeAccept://已接单
            
            array = @[@"订单",@"作品"];
            break;
            
        case CustomRequirementsTypeBid://竞标成功
            
            array = @[@"订单",@"投标"];
            break;
        case CustomRequirementsTypeBidSucess://竞标成功
            
            array = @[@"订单",@"投标",@"作品"];
            break;
            
        case CustomRequirementsTypeSucess://验收完成
            
            if (demandType == DemandTypeDirectional) {
                array = @[@"订单",@"作品",@"设计师评价",@"我的评价"];
            } else {
                
                array = @[@"订单",@"投标",@"作品",@"设计师评价",@"我的评价"];
            }
            
            break;
            
        case CustomRequirementsTypeCompletion://已完成
            
            if (demandType == DemandTypeDirectional) {
                array = @[@"订单",@"作品",@"设计师评价",@"我的评价"];
            } else {
                
                array = @[@"订单",@"投标",@"作品",@"设计师评价",@"我的评价"];
            }
            
            break;
            
        default:
            break;
    }
    return array;
}

@end
