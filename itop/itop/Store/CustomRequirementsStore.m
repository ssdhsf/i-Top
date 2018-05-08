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

-(NSArray *)configurationCustomRequirementsCommentsWithRequsData:(NSArray *)arr{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dic in arr) {
        
        CustomRequirementsComments *custom = [[CustomRequirementsComments alloc]initWithDictionary:dic error:nil];
        [array addObject:custom];
    }
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
   
    if ([[UserManager shareUserManager] crrentUserType] == UserTypeDesigner) {
       
        NSArray *array = @[@[@"接单",@"拒绝"], //待接单
                           @[@"作品上传",@"平台介入"],//已接单
                           @[@"删除"], //已拒绝
                           @[@"取消竞标"],//竞标中
                           @[@"作品上传",@"平台介入"],//竞标成功
                           @[@"删除"],//竞标失败
                           @[@"删除"],//竞标取消
                           @[@"评价"],//验收完成
                           @[@"删除"],//合作失败
                           @[@"删除"],//已完成
                           @[@"编辑",@"删除"],//审核中
                           @[@"评价"],//审核不通过
                           @[@"删除"],//合作取消
                           @[@"编辑",@"上架",@"删除"],//已下架
                           @[@"平台介入",@"取消合作"]//平台介入
                           ];
        
        return array[state];

    } else {
        
        NSArray *array = @[@[@"编辑",@"下架",@"托管赏金",@"删除"], //待接单
                           @[@"托管赏金",@"平台介入",@"验收完成"],//已接单
                           @[@"删除"], //已拒绝
                           @[@"编辑",@"托管赏金"],//竞标中
                           @[@"托管赏金",@"平台介入",@"验收完成"],//竞标成功
                           @[@"重新发布",@"删除"],//竞标失败
                           @[@"删除"],//竞标取消
                           @[@"评价"],//验收完成
                           @[@"删除"],//合作失败
                           @[@"删除"],//已完成
                           @[@"编辑",@"删除"],//审核中
                           @[@"编辑",@"重新发布",@"删除"],//审核不通过
                           @[@"删除"],//合作取消
                           @[@"编辑",@"上架",@"删除"],//已下架
                           @[@"平台介入",@"取消合作"]//平台介入
                           ];
        
        return array[state];

    }
    
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
                       @"审核不通过",
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
    
    NSString *title =  [[UserManager shareUserManager] crrentUserType] ? @"客户评价" : @"设计师评价";
    NSArray *array = [NSArray array];
    switch (state) {
            
        case CustomRequirementsTypeUnAccept: //待接单
        case CustomRequirementsTypePending://审核中
        case CustomRequirementsTypeOut://下架
        case CustomRequirementsTypeNotPass://不通过
        case CustomRequirementsTypeRefuse://已拒绝
        case CustomRequirementsTypeBidCancel: //竞标取消
            
            array = @[@"订单"];
            break;
            
        case CustomRequirementsTypeAccept://已接单
            
            array = @[@"订单",@"作品"];
            break;
            
        case CustomRequirementsTypeBid://竞标中
            
            array = @[@"订单",@"投标"];
            break;
        case CustomRequirementsTypeBidSucess://竞标成功
            
            array = @[@"订单",@"投标",@"作品"];
            break;
            
        case CustomRequirementsTypeSucess://验收完成
            
            if (demandType == DemandTypeDirectional) {
                array = @[@"订单",@"作品"];
            } else {
                
                array = @[@"订单",@"投标",@"作品"];
            }
            break;
            
        case CustomRequirementsTypeCompletion://已完成
            
            if (demandType == DemandTypeDirectional) {
                array = @[@"订单",@"作品",title,@"我的评价"];
            } else {
                array = @[@"订单",@"投标",@"作品",title,@"我的评价"];
            }
            break;
        case CustomRequirementsTypeIntervention://平台介入
        case CustomRequirementsTypeCanceled://合作取消
        case CustomRequirementsTypeBidFail://合作失败
            
            if (demandType == DemandTypeDirectional) {
                array = @[@"订单",@"作品"];
            } else {
                
                array = @[@"订单",@"投标",@"作品"];
            }
            break;
            
        default:
            break;
    }
    return array;
}

@end
