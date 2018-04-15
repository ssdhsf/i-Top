//
//  HomeStore.m
//  itop
//
//  Created by huangli on 2018/1/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "HomeStore.h"

@implementation HomeStore


+ (instancetype)shearHomeStore{
    
    static HomeStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[HomeStore alloc]init];
    });
    return store;
}

//- (NSMutableArray *)requestConfigurationMenuWithMenu:(NSArray *)menu{
//    
//    NSMutableArray *sectionArray = [NSMutableArray array];
//    for (int i = 0; i < 5; i++) {
//        
//        NSArray *arr = [NSArray array];
//        [sectionArray addObject:arr];
//    }
//    
//    [[UserManager shareUserManager]designerlistWithPageIndex:1 PageCount:10];
//    [UserManager shareUserManager].designerlistSuccess = ^(id obj){
//        
//        NSLog(@"%@",obj);
//    };
//    
//    return sectionArray;
//}

- (NSMutableArray *)configurationBanner:(NSArray *)banner{
    
    NSMutableArray *bannerArray = [NSMutableArray array];
    
    for (NSDictionary *dic in banner) {
        
        HomeBanner *banner = [[HomeBanner alloc]initWithDictionary:dic error:nil];
        [bannerArray addObject:banner];
    }
    
    if (bannerArray.count!=0) {
        [bannerArray insertObject:bannerArray.firstObject atIndex:bannerArray.count];
    }
    return bannerArray;
}

- (NSMutableArray *)configurationTag:(NSArray *)tag{
    
    NSMutableArray *tagArray = [NSMutableArray array];
    for (NSDictionary *dic in tag) {
        
        TagList *tag = [[TagList alloc]initWithDictionary:dic error:nil];
        [tagArray addObject:tag];
    }
    for (int i = 0 ; i < tag.count-1; i++) {
        
       
        for (int j = 0; j<tagArray.count-i-1; j++) {
           TagList *tag =  tagArray[j];
            TagList *tag1 =  tagArray[j+1];
            
            if ([tag1.index integerValue] < [tag.index integerValue]) {
                
                TagList *tempTag = tagArray[j];
                tagArray[j] = tagArray[j+1];
                tagArray[j+1] = tempTag;
            }
        }
    }
    return tagArray;
}

-(NSMutableArray *)configurationAllTagWithMenu:(NSArray *)menu {
    
    NSMutableArray  *useArray = [NSMutableArray array];
    for (NSDictionary *dic in menu) {
        
        TagList *tag = [[TagList alloc]initWithDictionary:dic error:nil];
        [useArray addObject:tag];
    }
    
    return useArray;
}


- (NSMutableArray *)configurationTagWithMenu:(NSArray *)menu  tagType:(NSString *)tagType{
    
    NSMutableArray  *useArray = [NSMutableArray array];
    NSString *idStr ;
    for (TagList *tag in menu) {
        
//        TagList *tag = [[TagList alloc]initWithDictionary:dic error:nil];
        if ([tag.name isEqualToString:tagType]) {
            idStr = tag.id;
            break;
        }
    }
    
    for (TagList *tag  in menu) {
        
//        TagList *tag = [[TagList alloc]initWithDictionary:dic error:nil];
        if ([tag.parent_id isEqualToString:idStr]) {
            [useArray addObject: tag];
        }
    }
    return useArray;
}


- (NSMutableArray *)configurationTagNameWithMenu:(NSArray *)menu  tagType:(NSString *)tagType{
    
    NSMutableArray  *useArray = [NSMutableArray array];
    for ( TagList *tag in menu) {
        
        [useArray addObject: tag.name];
    }
    return useArray;
}

-(NSMutableArray *)configurationTagNameWithTag:(NSString *)tag{
    
    NSMutableArray  *useArray = [NSMutableArray array];
    
    if ([tag isEqualToString:@"场景H5"]) {
        
        [useArray addObjectsFromArray:@[@"用途",@"行业",@"热点",@"风格"]];
    }
    
    if ([tag isEqualToString:@"一页H5"]) {
        
        [useArray addObjectsFromArray:@[@"用途",@"行业",@"技术",@"风格"]];
    }
    
    if ([tag isEqualToString:@"视频H5"]) {
        
        [useArray addObjectsFromArray:@[@"用途",@"尺寸",@"时长",@"风格"]];
    }
    
    return useArray;
}


- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu{
    
    NSMutableArray *sectionArray = [NSMutableArray array];
    NSMutableArray *itmeArray = [NSMutableArray array];
    
    for (int i = 0 ; i<6; i++) {
        
        HomeModel *thmeCustom = [[HomeModel alloc]init];
        switch (i) {
            case 0:
                thmeCustom.title = [NSString stringWithFormat:@"促销"];
                thmeCustom.imageUrl = [NSString stringWithFormat:@"促销B"];
                break;
            case 1:
                thmeCustom.title = [NSString stringWithFormat:@"活动推广"];
                thmeCustom.imageUrl = [NSString stringWithFormat:@"活动推广"];
                break;
            case 2:
                thmeCustom.title = [NSString stringWithFormat:@"媒体宣传"];
                thmeCustom.imageUrl = [NSString stringWithFormat:@"媒体宣传"];
                break;
            case 3:
                thmeCustom.title = [NSString stringWithFormat:@"邀请成员"];
                thmeCustom.imageUrl = [NSString stringWithFormat:@"邀请成员"];
                break;
            case 4:
                thmeCustom.title = [NSString stringWithFormat:@"招聘"];
                thmeCustom.imageUrl = [NSString stringWithFormat:@"招聘"];
                break;
            case 5:
                thmeCustom.title = [NSString stringWithFormat:@"中国结"];
                thmeCustom.imageUrl = [NSString stringWithFormat:@"活动推广"];
                break;
                
            default:
                break;
        }
        
        [itmeArray addObject:thmeCustom];
    }
    
    Home *home = [[Home alloc]init];
    home.itemKey =Type_Home;
    home.itemArray = itmeArray;
    home.itemHeader = @"主题";
    [sectionArray addObject:home];
    
    //----------------------------------------------------
    NSMutableArray *itmeArray1 = [NSMutableArray array];

    for (int i = 0 ; i<5; i++) {
        
        H5List *h5Model = [[H5List alloc]init];
        h5Model.h5Title = [NSString stringWithFormat:@"会议邀请函"];
        h5Model.h5Money = [NSString stringWithFormat:@"$10"];
        h5Model.h5ImageUrl = [NSString stringWithFormat:@"h5"];
        [itmeArray1 addObject:h5Model];
    }
    
    Home *home1 = [[Home alloc]init];
    home1.itemKey = Type_H5;
    home1.itemArray = itmeArray1;
    home1.itemHeader = @"推荐H5";
    [sectionArray addObject:home1];
    
    //----------------------------------------------------
    NSMutableArray *itmeArray2 = [NSMutableArray array];
    
    for (int i = 0 ; i<5; i++) {
        
        DesignerList *designer = [[DesignerList alloc]init];
        designer.designerName = [NSString stringWithFormat:@"MC设计师"];
        designer.designerProfessional = [NSString stringWithFormat:@"UI设计"];
        designer.designerImageUrl = [NSString stringWithFormat:@"default_man"];
        [itmeArray2 addObject:designer];
    }
    
    Home *home2 = [[Home alloc]init];
    home2.itemKey = Type_Designer;
    home2.itemArray = itmeArray2;
    home2.itemHeader = @"推荐设计师";
    [sectionArray addObject:home2];
    
    //----------------------------------------------------
    NSMutableArray *itmeArray3 = [NSMutableArray array];
    
    for (int i = 0 ; i<3; i++) {
        
        H5List *h5Model = [[H5List alloc]init];
        h5Model.h5Title = [NSString stringWithFormat:@"会议邀请函"];
        h5Model.h5Money = [NSString stringWithFormat:@"$10"];
        h5Model.h5ImageUrl = [NSString stringWithFormat:@"h5"];
        [itmeArray3 addObject:h5Model];
    }
    
    Home *home3 = [[Home alloc]init];
    home3.itemKey = Type_H5;
    home3.itemArray = itmeArray3;
    home3.itemHeader = @"场景H5";
    [sectionArray addObject:home3];
    
    //----------------------------------------------------
    NSMutableArray *itmeArray4 = [NSMutableArray array];
    
    for (int i = 0 ; i<3; i++) {
        
        H5List *h5Model = [[H5List alloc]init];
        h5Model.h5Title = [NSString stringWithFormat:@"会议邀请函"];
        h5Model.h5Money = [NSString stringWithFormat:@"$10"];
        h5Model.h5ImageUrl = [NSString stringWithFormat:@"h5"];
        [itmeArray4 addObject:h5Model];
    }
    
    Home *home4 = [[Home alloc]init];
    home4.itemKey = Type_H5;
    home4.itemArray = itmeArray4;
    home4.itemHeader = @"一页H5";
    [sectionArray addObject:home4];

    return sectionArray;
}

@end
