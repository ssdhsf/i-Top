//
//  InfomationStore.m
//  itop
//
//  Created by huangli on 2018/2/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "InfomationStore.h"

@implementation InfomationStore

+ (instancetype)shearInfomationStore{
    
    static InfomationStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[InfomationStore alloc]init];
    });
    return store;
}
- (NSMutableArray *)configurationMenuWithInfo:(InfomationModel *)info{
    NSMutableArray *sectionArray = [NSMutableArray array];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"头像" content:info.user_info.head_img isEditor:NO sendKey:@"Head_img" ]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"用户类型" content:[self userTypeWithUserTypeId:info.user_type] isEditor:NO sendKey:@""]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"昵称" content:info.user_info.nickname isEditor:YES sendKey:@"nickname"]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"姓名" content:info.name isEditor:YES sendKey:@"Name"]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"性别" content:[self sexWithIndex:info.user_info.sex] isEditor:YES sendKey:@"Sex"]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"年龄" content:info.user_info.age isEditor:YES sendKey:@"Age"]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"所在城市" content:[self provinceAppdingCity:info.user_info.province city:info.user_info.city] isEditor:YES sendKey:@""]];
    
    return sectionArray;
}

-(Infomation *)setupLeaveDetailWithLeaveDetailTitle:(NSString *)title content:(NSString *)content isEditor:(BOOL)animation sendKey:(NSString *)sendKey{
    
    Infomation *info = [[Infomation alloc]init];
    info.title = title;
    info.content = content;
    info.isEdit =  animation;
    info.sendKey = sendKey;
    return info;
}

-(NSArray *)sexArray{
    
    NSArray *sexArray = @[@"未知" ,@"男",@"女"];
    return sexArray;
}

-(NSInteger)indexWithSex:(NSString *)sex{
    
    NSInteger index =[[self sexArray] indexOfObject:sex];
    return index;
}

-(NSString *)sexWithIndex:(NSString *)indexStr{
    
    NSInteger index ;
    if ([Global stringIsNullWithString:indexStr]) {
        
        index = 0;
    }else{
        
        index = [indexStr integerValue];
    }
    return [[self sexArray] objectAtIndex:index];
}

-(NSString *)userTypeWithUserTypeId:(NSString*)user_type{
    
    NSArray *userTypeArray = @[@"一般用户",@"设计师",@"企业",@"自营销"];
    
    NSInteger userType ;
    
    if ([Global stringIsNullWithString:user_type]) {
        
        userType = 0;
    }else{
        
        userType = [user_type integerValue];
    }
    return userTypeArray[userType];
}

-(NSString*)provinceAppdingCity:(NSString *)province city:(NSString *)city{
    
    NSString *provinceCity;
    if ([Global stringIsNullWithString:province]&&[Global stringIsNullWithString:city]) {
        
        provinceCity = [NSString stringWithFormat:@""];
    } else if(![Global stringIsNullWithString:province]&&![Global stringIsNullWithString:city]){
        provinceCity = [NSString stringWithFormat:@"%@,%@",province,city];
    } else if(![Global stringIsNullWithString:province]&&[Global stringIsNullWithString:city]){
        
        provinceCity = [NSString stringWithFormat:@"%@",province];

    } else if([Global stringIsNullWithString:province]&&![Global stringIsNullWithString:city]){
        
        provinceCity = [NSString stringWithFormat:@"%@",city];
        
    }
    return provinceCity;
}

@end
