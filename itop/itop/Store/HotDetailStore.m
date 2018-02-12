//
//  HotDetailStore.m
//  itop
//
//  Created by huangli on 2018/1/31.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "HotDetailStore.h"

@implementation HotDetailStore

+ (instancetype)shearHotDetailStore{
    
    static HotDetailStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[HotDetailStore alloc]init];
    });
    return store;
}

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu{

    NSMutableArray *sectionArray = [NSMutableArray array];
    
   
    for (NSDictionary *dic in menu) {

        HotComments *hotComment = [[HotComments alloc]initWithDictionary:dic error:nil];
        
        for (int i = 0; i < menu.count; i ++) {
            
            HotComments *subHotComment = [[HotComments alloc]initWithDictionary:menu[i] error:nil];
            
            if ([hotComment.id isEqualToString:subHotComment.parent_id]) {
                
               hotComment.replyString = [self mosaicStringWithOriginally:hotComment.replyString joiningString:[NSString stringWithFormat:@"%@: %@",subHotComment.user_name,subHotComment.content]];
                
            }
        }
        
        if ([hotComment.parent_id isEqualToString:@"0"]) {
            
            [sectionArray addObject:hotComment];
        }
    }
    
    
    
    
#ifdef DEBUG
    // 调试状态, 打开LOG功能
    
    if (sectionArray.count == 0) {
        for (int i = 0; i < 5; i++) {
            HotComments *hotComments = [[HotComments alloc]init];
            hotComments.user_head_img = @"http://192.168.7.100:8028/files/img/20180129/201801291921400799.png";
            hotComments.user_name = @"喜大大";
            hotComments.create_datetime = @"2018-01-31 14:59:59";
            hotComments.content = @"LBS（Location Based Service基于位置的服务）的三大目标是你在哪你和谁在一起附近有什么资源。其中『你在哪里』是LBS服务的核心。百度智能定位服务是为了帮助广大开发者更好解决你在哪里这个难题而开放的服务支持GPSWiFi基站融合定位完美支持各类应用开发者对位置获取的诉求百度地图开放平台定位服务是广大开发者定位首选服务每日定位请求超过300亿次开发者市场占有率超过70";
            [sectionArray addObject:hotComments];
        }
    }
    
    
//#define NSLog(...) NSLog(__VA_ARGS__)
#else
    // 发布状态, 关闭LOG功能
//#define
#endif
    return sectionArray;
}

- (NSString *)mosaicStringWithOriginally:(NSString *)originallyString joiningString:(NSString *)joiningString{
    
    NSString*jsonString;
    if (!originallyString) {
        jsonString = [NSString stringWithFormat:@"%@",joiningString];
    }else{
        jsonString=[NSString stringWithFormat:@"%@\n%@",originallyString,joiningString];
    }
    return jsonString;
}

@end
