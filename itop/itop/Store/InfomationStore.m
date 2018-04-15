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

- (NSMutableArray *)configurationMenuWithUserInfo:(InfomationModel *)info userType:(UserType )user_type{
    
    NSMutableArray *sectionArray = [NSMutableArray array];
    switch (user_type) {
        case UserTypeDefault:
            return [self configurationAverageUserMenu:info];
            break;
        case UserTypeDesigner:
            return [self configurationDesignerMenu:info];
            break;
        case UserTypeEnterprise:
            return [self configurationCompenyMenu:info];
            break;
        case UserTypeMarketing:
            return [self configurationMarktingMenu:info];
            break;
        default:
            break;
    }
    return sectionArray;
}

//一般用户
-(NSMutableArray *)configurationAverageUserMenu:(InfomationModel *)info{
    
    NSMutableArray *sectionArray = [NSMutableArray array];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"头像" content:info.user_info.head_img isEditor:YES sendKey:@"Head_img" pickViewType:PickViewTypePicture] ];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"用户类型" content:[self userTypeWithUserTypeId:info.user_type] isEditor:NO sendKey:@"" pickViewType:PickViewTypeNone]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"昵称" content:info.user_info.nickname isEditor:YES sendKey:@"nickname" pickViewType:PickViewTypeEdit]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"姓名" content:info.name isEditor:YES sendKey:@"Name" pickViewType:PickViewTypeEdit]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"性别" content:[self sexWithIndex:info.user_info.sex] isEditor:YES sendKey:@"Sex" pickViewType:PickViewTypeSex]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"年龄" content:info.user_info.age isEditor:YES sendKey:@"Age" pickViewType:PickViewTypeAge]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"所在城市" content:[self provinceAppdingCity:info.user_info.province city:info.user_info.city] isEditor:YES sendKey:@"" pickViewType:PickViewTypeProvince]];
    return sectionArray;
}


//企业信息
-(NSMutableArray *)configurationCompenyMenu:(InfomationModel *)info{
    
    NSMutableArray *sectionArray = [NSMutableArray array];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"LOGO" content:info.user_info.head_img isEditor:YES sendKey:@"Head_img" pickViewType:PickViewTypePicture]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"用户类型" content:[self userTypeWithUserTypeId:info.user_type] isEditor:NO sendKey:@"" pickViewType:PickViewTypeNone]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"账号等级" content:[self userVersionWithVersion:info.other_info.version] isEditor:NO sendKey:@"nickname" pickViewType:PickViewTypeNone]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"企业名称" content:info.other_info.name isEditor:YES sendKey:@"Enterprise_name" pickViewType:PickViewTypeEdit]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"企业简称" content:info.user_info.nickname isEditor:YES sendKey:@"Short_name" pickViewType:PickViewTypeEdit]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"所属行业" content:info.other_info.trade isEditor:YES sendKey:@"Trade" pickViewType:PickViewTypeIndustry]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"企业规模" content:info.other_info.scale isEditor:YES sendKey:@"Scale" pickViewType:PickViewTypeCompnySize]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"所在城市" content:[self provinceAppdingCity:info.other_info.province city:info.other_info.city] isEditor:YES sendKey:@"" pickViewType:PickViewTypeProvince]];
    return sectionArray;
}

//设计师信息
-(NSMutableArray *)configurationDesignerMenu:(InfomationModel *)info{
    
    NSMutableArray *sectionArray = [NSMutableArray array];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"头像" content:info.user_info.head_img isEditor:YES sendKey:@"Head_img" pickViewType:PickViewTypePicture]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"用户类型" content:[self userTypeWithUserTypeId:info.user_type] isEditor:NO sendKey:@"" pickViewType:PickViewTypeNone]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"账号等级" content:[self userLevelWithLevel:info.other_info.level] isEditor:NO sendKey:@"nickname" pickViewType:PickViewTypeNone]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"昵称" content:info.user_info.nickname isEditor:YES sendKey:@"nickname" pickViewType:PickViewTypeEdit]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"姓名" content:info.name isEditor:YES sendKey:@"Name" pickViewType:PickViewTypeEdit]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"擅长领域" content:info.other_info.field isEditor:NO sendKey:@"Field" pickViewType:PickViewTypeField]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"年龄" content:info.user_info.age isEditor:YES sendKey:@"Age" pickViewType:PickViewTypeAge]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"所在城市" content:[self provinceAppdingCity:info.user_info.province city:info.user_info.city] isEditor:YES sendKey:@"" pickViewType:PickViewTypeProvince]];
    return sectionArray;
}

//自营销人信息
-(NSMutableArray *)configurationMarktingMenu:(InfomationModel *)info{
    
    NSMutableArray *sectionArray = [NSMutableArray array];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"头像" content:info.user_info.head_img isEditor:YES sendKey:@"Head_img" pickViewType:PickViewTypePicture]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"用户类型" content:[self userTypeWithUserTypeId:info.user_type] isEditor:NO sendKey:@"" pickViewType:PickViewTypeNone]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"账号等级" content:[self userLevelWithLevel:info.other_info.level] isEditor:NO sendKey:@"nickname" pickViewType:PickViewTypeNone]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"昵称" content:info.user_info.nickname isEditor:YES sendKey:@"nickname" pickViewType:PickViewTypeEdit]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"姓名" content:info.name isEditor:YES sendKey:@"Name" pickViewType:PickViewTypeEdit]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"所属行业" content:info.other_info.trade isEditor:YES sendKey:@"Trade" pickViewType:PickViewTypeIndustry]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"年龄" content:info.user_info.age isEditor:YES sendKey:@"Age" pickViewType:PickViewTypeAge]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"所在城市" content:[self provinceAppdingCity:info.user_info.province city:info.user_info.city] isEditor:YES sendKey:@"" pickViewType:PickViewTypeProvince]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"渠道资源" content:nil isEditor:NO sendKey:@"" pickViewType:PickViewTypeNone]];
    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"简介" content:nil isEditor:YES sendKey:@"Sex" pickViewType:PickViewTypeEdit]];
    return sectionArray;
}

-(Infomation *)setupLeaveDetailWithLeaveDetailTitle:(NSString *)title
                                            content:(NSString *)content
                                           isEditor:(BOOL)animation
                                            sendKey:(NSString *)sendKey
                                       pickViewType:(PickViewType)pickViewType{
    
    Infomation *info = [[Infomation alloc]init];
    info.title = title;
    info.content = content;
    info.isEdit =  animation;
    info.sendKey = sendKey;
    info.pickViewType = pickViewType;
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

//用户等级
-(NSString *)userLevelWithLevel:(NSString*)level{
    
    NSArray *userLevelArray = @[@"未知",@"初级",@"中级",@"高级"];
    NSInteger userType ;
    if ([Global stringIsNullWithString:level]) {
        
        userType = 0;
    }else{
        userType = [level integerValue];
    }
    return userLevelArray[userType];
}

//企业等级
-(NSString *)userVersionWithVersion:(NSString*)version{
    
    NSArray *userVersionArray = @[@"免费版",@"粉钻版",@"蓝钻版",@"黑钻版"];
    NSInteger user ;
    if ([Global stringIsNullWithString:version]) {
        
        user = 0;
    }else{
        user = [version integerValue];
    }
    return userVersionArray[user];
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
