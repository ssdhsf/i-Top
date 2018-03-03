//
//  OrganizationManagement.m
//  xixun
//
//  Created by huangli on 16/5/10.
//  Copyright © 2016年 3N. All rights reserved.
//

#import "OrganizationManagement.h"
//#import "UIAlertView+Blocks.h"


@interface OrganizationManagement ()<UIActionSheetDelegate>{
    
    UIView *bgView;
}

@end

@implementation OrganizationManagement

+(instancetype)sharedOrganizationManagement{
    
    static OrganizationManagement *organization = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken ,^{
        organization  = [[OrganizationManagement alloc]init];
    });
    
    return organization;
}


- (void)selectObjWithObjTitleArray:(NSArray *)objTitle
                        currentObj:(NSString *)current_obj
                             title:(NSString *)title
                        Completion:(completion_organization)completion{
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle: UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        for (NSString *title in objTitle) {
            
            UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                    completion(action.title);
            }];
            
            if ([title isEqualToString:current_obj]) {
                
                if ([UIDevice currentDevice].systemVersion.floatValue > 8.3f){
                     [archiveAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
                }
            }
            
            [alertController addAction:archiveAction];

        }
        
            [[[UIManager sharedUIManager]topViewController] presentViewController:alertController animated:YES completion:nil];
        
        
    } else {
        UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:title
                                                        delegate:nil
                                               cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:nil];
        as.delegate = self;
        for (NSString *obj in objTitle) {
            
            [as addButtonWithTitle:obj];
        }
        as.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
//        as.tapBlock = ^(UIActionSheet *actionSheet, NSInteger buttonIndex){
//            if(buttonIndex != 0){
//
//                completion([actionSheet buttonTitleAtIndex:buttonIndex]);
//            }
//            
//        };
        [as showInView:[[UIManager sharedUIManager]topViewController].view];
    }
}


@end
