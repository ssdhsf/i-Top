//
//  MyInfomationStore.m
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MyInfomationStore.h"

@implementation MyInfomationStore

+ (instancetype)shearMyInfomationStore{
    
    static MyInfomationStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[MyInfomationStore alloc]init];
    });
    return store;
}

- (NSMutableArray *)configurationMenuWithUserType:(UserType)user_type{
    
    NSMutableArray *sectionArray = [NSMutableArray array];

    switch (user_type) {
        case UserTypeDefault:
            [sectionArray addObject:[self configurationAverageUserMenu]];
            break;
        case UserTypeDesigner:
            [sectionArray addObject:[self configurationDesignerMenu]];
            break;
        case UserTypeEnterprise:
            [sectionArray addObject:[self configurationCompenyMenu]];
            break;
        case UserTypeMarketing:
            [sectionArray addObject:[self configurationMarktingMenu]];
            break;

        default:
            break;
    }
    [sectionArray addObject: [self configurationItopMenuWithUserType:user_type]];
    return sectionArray;
}

-(NSMutableArray *)configurationItopMenuWithUserType:(UserType)user_type{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"分享" imageName:@"me_icon_share" vcName:@"ShearViewController"]];
    if (user_type == UserTypeDefault) {
        [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"入驻申请" imageName:@"me_icon_ruzhu" vcName:@"SigningTypeViewController"]];
    }
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"意见反馈" imageName:@"me_icon_comment" vcName:@"CustomerServiceViewController"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"设置" imageName:@"me_icon_set" vcName:@"SetupHomeViewController"]];
    
    return array;
}

//一般用户
-(NSMutableArray *)configurationAverageUserMenu{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"我的作品" imageName:@"me_icon_production" vcName:@"MyWorksViewCotroller"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"我的钱包" imageName:@"me_icon_purse" vcName:@""]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"我的留资" imageName:@"me_icon_liuzi" vcName:@"LeaveViewController"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"关注" imageName:@"me_icon_watch" vcName:@"MyFocusViewController"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"通知" imageName:@"me_icon_remind" vcName:@""]];
    return array;
}

//企业用户
-(NSMutableArray *)configurationCompenyMenu{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"作品" imageName:@"me_icon_production" vcName:@"MyWorksViewCotroller"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"热点" imageName:@"me_icon_hot" vcName:@"MyWorksViewCotroller"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"钱包" imageName:@"me_icon_purse" vcName:@""]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"推广" imageName:@"me_icon_extend" vcName:@""]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"数据" imageName:@"me_icon_data" vcName:@"StatisticalDataViewController"]];
    
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"关注" imageName:@"me_icon_watch" vcName:@"MyFocusViewController"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"通知" imageName:@"me_icon_remind" vcName:@""]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"评论" imageName:@"me_icon_comment" vcName:@"CommentListViewController"]];
    return array;
}


//设计师用户
-(NSMutableArray *)configurationDesignerMenu{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"作品" imageName:@"me_icon_production" vcName:@"MyWorksViewCotroller"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"热点" imageName:@"me_icon_hot" vcName:@"MyhotViewController"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"钱包" imageName:@"me_icon_purse" vcName:@""]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"数据" imageName:@"me_icon_data" vcName:@"StatisticalDataViewController"]];
    
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"关注" imageName:@"me_icon_watch" vcName:@"MyFocusViewController"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"通知" imageName:@"me_icon_remind" vcName:@"MessageViewController"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"评论" imageName:@"me_icon_comment" vcName:@"CommentListViewController"]];
    return array;
}

//自营销人用户
-(NSMutableArray *)configurationMarktingMenu{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"订单" imageName:@"me_icon_ordermanage" vcName:@"MyWorksViewCotroller"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"热点" imageName:@"me_icon_hot" vcName:@"MyWorksViewCotroller"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"钱包" imageName:@"me_icon_purse" vcName:@""]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"数据" imageName:@"me_icon_data" vcName:@"StatisticalDataViewController"]];
    
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"关注" imageName:@"me_icon_watch" vcName:@"MyFocusViewController"]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"通知" imageName:@"me_icon_remind" vcName:@""]];
    [array addObject:[self setupMyInfomationWithLeaveDetailTitle:@"评论" imageName:@"me_icon_comment" vcName:@"CommentListViewController"]];
    return array;
}

//- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu{
//    NSMutableArray *sectionArray = [NSMutableArray array];
//    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"张三" content:@""]];
//    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"留资时间" content:@"2018-01-22 12:12"]];
//    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"作品来源" content:@"双十一狂欢邀请函"]];
//    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"电话" content:@"1888888888"]];
//    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"邮箱" content:@"346232424@qq.com"]];
//    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"地址" content:@"广州市天河区中石化大厦45号"]];
//    [sectionArray addObject:[self setupLeaveDetailWithLeaveDetailTitle:@"留言" content:@"迄今为止已经连续发表50于篇第一作者论文"]];
//    
//    return sectionArray;
//}

-(MyInfomation *)setupMyInfomationWithLeaveDetailTitle:(NSString *)title imageName:(NSString *)imageName vcName:(NSString *)vcName{
    
    MyInfomation *info = [[MyInfomation alloc]init];
    info.myInfoTitle = title;
    info.myInfoImageUrl = imageName;
    info.nextVcName = vcName;
    
    return info;
}

@end
