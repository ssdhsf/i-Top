//
//  DesignerListStore.h
//  itop
//
//  Created by huangli on 2018/1/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesignerListStore : NSObject

+ (instancetype)shearDesignerListStore;

- (NSMutableArray *)configurationMenuWithMenu:(NSArray *)menu;


@end
