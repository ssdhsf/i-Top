//
//  ThemeNavigationController.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeNavigationController : UINavigationController<UINavigationControllerDelegate>

-(void)setTitle:(NSString *)title tabBarItemImageName:(NSString *)imageName tabBarItemSelectedImageName:(NSString *)imageName;
@end
