//
//  MyWorksStore.m
//  itop
//
//  Created by huangli on 2018/1/31.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "MyWorksStore.h"

@implementation MyWorksStore

+ (instancetype)shearMyWorksStore{
    
    static MyWorksStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[MyWorksStore alloc]init];
    });
    return store;
}

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu{
    
    NSMutableArray *sectionArray = [NSMutableArray array];
    for (NSDictionary *dic in menu) {
        
            H5List *h5Model = [[H5List alloc]initWithDictionary:dic error:nil];
            [sectionArray addObject:h5Model];

    }
    
#ifdef DEBUG
    // 调试状态, 打开LOG功能
//    if (sectionArray.count == 0) {
//        for (int i = 0; i < 8; i++) {
//            H5List *h5Model = [[H5List alloc]init];
//            h5Model.h5Title = [NSString stringWithFormat:@"会议邀请函"];
//            h5Model.h5Money = [NSString stringWithFormat:@"￥10"];
//            h5Model.h5ImageUrl = [NSString stringWithFormat:@"h5"];
//            [sectionArray addObject:h5Model];
//        }
//    }
    //#define NSLog(...) NSLog(__VA_ARGS__)
#else
    // 发布状态, 关闭LOG功能
//#define
#endif
    return sectionArray;
}

- (NSMutableArray *)commentsListDropdownMenuConfigurationMenuWithMenu:(NSArray *)menu{
    
    NSMutableArray *sectionArray = [NSMutableArray array];
    for (H5List *h5Model in menu) {
        [sectionArray addObject:h5Model.title];
    }

    return sectionArray;
}


- (NSDictionary *)editProductConfigurationMenuWithGetProductType:(GetProductListType )getProductListType{
    
    NSDictionary * configurationDic;
    NSArray*titleArray;
    if (getProductListType == GetProductListTypeHome) {
        configurationDic = @{@"编辑":@"zuo_icon_edit",
                             @"预览":@"zuo_icon_preview",
                             @"留资":@"zuo_icon_liuzi",
                             @"设置":@"zuo_icon_set",
                             @"分享":@"zuo_icon_share",
                             @"复制链接":@"zuo_icon_link",
                             @"二维码":@"zuo_icon_code",
                             @"删除":@"zuo_icon_delete"};
        titleArray = @[@"编辑",@"预览",@"留资",@"设置",@"分享",@"复制链接",@"二维码",@"删除"];

    } else {
        
        configurationDic = @{@"编辑":@"zuo_icon_edit",
                             @"预览":@"zuo_icon_preview",
//                             @"标题优化":@"zuo_icon_biaoti",
                             @"设置":@"zuo_icon_set",
                             @"数据":@"zuo_icon_data",
                             @"分享":@"zuo_icon_share",
                             @"复制链接":@"zuo_icon_link",
                             @"二维码":@"zuo_icon_code"};
        titleArray = @[@"编辑",@"预览",@"设置",@"数据",@"分享",@"复制链接",@"二维码"];
    }
    
    NSDictionary * dic = @{@"config":configurationDic,@"title": titleArray};

    return dic;
}



@end
