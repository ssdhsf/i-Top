//
//  DesignerListStore.m
//  itop
//
//  Created by huangli on 2018/1/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DesignerListStore.h"

@implementation DesignerListStore


+ (instancetype)shearDesignerListStore{
    
    static DesignerListStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[DesignerListStore alloc]init];
    });
    return store;
}

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu{
    
    NSMutableArray *sectionArray = [NSMutableArray array];
    
    for (NSDictionary *dic in menu) {
        
       DesignerList *designer = [[DesignerList alloc]initWithDictionary:dic error:nil];
        [sectionArray addObject:designer];
        
    }
    
//    for (int i = 0 ; i<menu.count; i++) {
//        
////        NSMutableArray *itmeArray = [NSMutableArray array];
////        for (int i = 0 ; i<3; i++) {
//        
//            DesignerList *thmeCustom = [[DesignerList alloc]init];
//            thmeCustom.designerName = [NSString stringWithFormat:@"MC设计师"];
//            thmeCustom.designerProfessional = [NSString stringWithFormat:@"UI设计"];
//            thmeCustom.designerImageUrl = [NSString stringWithFormat:@"default_man"];
////            [itmeArray addObject:thmeCustom];
////        }
//        
//        [sectionArray addObject:thmeCustom];
//    }
    
    return sectionArray;
}


- (NSMutableArray *)configurationCustomRequirementsDegsinListWithRequstData:(NSArray *)desgin{
    
        NSMutableArray *sectionArray = [NSMutableArray array];
    
    for (NSDictionary *dic in desgin) {
        
        CustomRequirementsDegsinList *designer = [[CustomRequirementsDegsinList alloc]initWithDictionary:dic error:nil];
        [sectionArray addObject:designer];
        
    }
    
    return sectionArray;
}

@end
