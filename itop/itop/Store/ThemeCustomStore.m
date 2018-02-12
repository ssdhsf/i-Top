//
//  ThemeCustomStore.m
//  itop
//
//  Created by huangli on 2018/1/19.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ThemeCustomStore.h"

@implementation ThemeCustomStore


+ (instancetype)shearThemeCustomStore{
    
    static ThemeCustomStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[ThemeCustomStore alloc]init];
    });
    return store;

}

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu{
    
    NSMutableArray *sectionArray = [NSMutableArray array];
    for (int i = 0 ; i<10; i++) {
        
        NSMutableArray *itmeArray = [NSMutableArray array];
        for (int i = 0 ; i<3; i++) {
            
            ThemeCustom *thmeCustom = [[ThemeCustom alloc]init];
            thmeCustom.title = [NSString stringWithFormat:@"标题"];
            thmeCustom.imageUrl = [NSString stringWithFormat:@"default_man"];
            [itmeArray addObject:thmeCustom];
        }
        
        [sectionArray addObject:itmeArray];
    }
    
    return sectionArray;
}

@end
