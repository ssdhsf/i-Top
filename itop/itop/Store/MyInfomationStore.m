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

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu{
    
    NSMutableArray *sectionArray = [NSMutableArray array];
    NSMutableArray *itmeArray1 = [NSMutableArray array];
    NSMutableArray *itmeArray2 = [NSMutableArray array];
    [itmeArray1 addObject:[self setupMyInfomationWithLeaveDetailTitle:@"我的作品" imageName:@"me_icon_production" vcName:@"MyWorksViewCotroller"]];
    [itmeArray1 addObject:[self setupMyInfomationWithLeaveDetailTitle:@"我的钱包" imageName:@"me_icon_purse" vcName:@""]];
    [itmeArray1 addObject:[self setupMyInfomationWithLeaveDetailTitle:@"我的留资" imageName:@"me_icon_liuzi" vcName:@"LeaveViewController"]];
    [itmeArray1 addObject:[self setupMyInfomationWithLeaveDetailTitle:@"关注" imageName:@"me_icon_watch" vcName:@"MyFocusViewController"]];
    [itmeArray1 addObject:[self setupMyInfomationWithLeaveDetailTitle:@"通知" imageName:@"me_icon_remind" vcName:@""]];
    
    [itmeArray2 addObject:[self setupMyInfomationWithLeaveDetailTitle:@"分享" imageName:@"me_icon_share" vcName:@""]];
    [itmeArray2 addObject:[self setupMyInfomationWithLeaveDetailTitle:@"入驻申请" imageName:@"me_icon_ruzhu" vcName:@"UsersSigningViewController"]];
    [itmeArray2 addObject:[self setupMyInfomationWithLeaveDetailTitle:@"意见反馈" imageName:@"me_icon_comment" vcName:@""]];
    [itmeArray2 addObject:[self setupMyInfomationWithLeaveDetailTitle:@"设置" imageName:@"me_icon_set" vcName:@""]];
    
    [sectionArray addObject:itmeArray1];
    [sectionArray addObject:itmeArray2];
    
//    for (int i = 0 ; i<2; i++) {
//        
//        NSMutableArray *itmeArray = [NSMutableArray array];
//        for (int i = 0 ; i<5; i++) {
//            
//            MyInfomation *myInfomation = [[MyInfomation alloc]init];
//            myInfomation.myInfoTitle = [NSString stringWithFormat:@"我的作品"];
//            myInfomation.myInfoImageUrl = [NSString stringWithFormat:@"h5"];
//            [itmeArray addObject:myInfomation];
//        }
//        
//        [sectionArray addObject:itmeArray];
//    }
    
    return sectionArray;
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
