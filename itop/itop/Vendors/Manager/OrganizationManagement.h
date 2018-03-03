//
//  OrganizationManagement.h
//  xixun
//
//  Created by huangli on 16/5/10.
//  Copyright © 2016年 3N. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef void(^completion_organization)(id organization_name);

@interface OrganizationManagement : NSObject

+ (instancetype)sharedOrganizationManagement;

/**
 *  选择列表（通用）
 *
 *  @param objTitle     选择的所有对象
 *  @param current_obj  当前选择的对象
 *  @param title        提示选择类型
 *  @param completion   选择的对象
 */
- (void)selectObjWithObjTitleArray:(NSArray *)objTitle
                        currentObj:(NSString *)current_obj
                             title:(NSString *)title
                        Completion:(completion_organization)completion;

@property (nonatomic, strong) NSString *organization;

@end
