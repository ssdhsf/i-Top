//
//  UIViewController+BarItem.m
//  HWSDK
//
//  Created by Carl_Huang on 13-11-19.
//  Copyright (c) 2013年 HelloWorld. All rights reserved.
//

#import "UIViewController+BarItem.h"

@implementation UIViewController (BarItem)

-(void)setLeftBarItemString:(NSString*)str action:(SEL)selector
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:str style:UIBarButtonItemStylePlain target:self action:selector];
}
-(void)setRightBarItemString:(NSString*)str action:(SEL)selector
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:str style:UIBarButtonItemStylePlain target:self action:selector];
}
- (void)setLeftCustomBarItem:(NSString *)imageName action:(SEL)selector
{
    self.navigationItem.leftBarButtonItem = [self customBarItem:imageName action:selector];
}

- (void)setRightCustomBarItem:(NSString *)imageName action:(SEL)selector
{
    self.navigationItem.rightBarButtonItem = [self customBarItem:imageName action:selector size:CGSizeMake(22, 22)];
}

- (UIBarButtonItem *)customBarItem:(NSString *)imageName action:(SEL)selector
{
    return [self customBarItem:imageName action:selector size:CGSizeMake(20, 20)];
}

- (UIBarButtonItem *)customBarItem:(NSString *)imageName action:(SEL)selector size:(CGSize)itemSize
{
    UIImage * image = [UIImage imageNamed:imageName];
    UIButton * barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [barButton setFrame:CGRectMake(0, 0, itemSize.width, itemSize.height)];
    [barButton setImage:image forState:UIControlStateNormal];
    [barButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    if(selector)
    {
        [barButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [barButton addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    barButton = nil;
    return item;
}
- (UIBarButtonItem *)customBarThemeItem:(NSString *)imageName action:(SEL)selector size:(CGSize)itemSize
{
    UIImage * image = [[ThemeManager shareInstance]getThemeImage:imageName];
    UIButton * barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [barButton setFrame:CGRectMake(0, 0, itemSize.width, itemSize.height)];
    [barButton setImage:image forState:UIControlStateNormal];
    [barButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    if(selector)
    {
        [barButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [barButton addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    barButton = nil;
    return item;
    
}
- (UIBarButtonItem *)customBarItem:(NSString *)imageName highLightImageName:(NSString *)highlightImageName action:(SEL)selector size:(CGSize)itemSize
{
    UIImage * image = [UIImage imageNamed:imageName];
    UIImage * highlightImage = [UIImage imageNamed:highlightImageName];
    UIButton * barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [barButton setFrame:CGRectMake(0, 0, itemSize.width, itemSize.height)];
    [barButton setImage:image forState:UIControlStateNormal];
    [barButton setImage:highlightImage forState:UIControlStateHighlighted];
    [barButton setImage:highlightImage forState:UIControlStateSelected];
    if(selector)
    {
        [barButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [barButton addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    barButton = nil;
    return item;
    
}


- (void)popVIewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToRoot
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)push:(UIViewController *)viewController
{
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Private Methods
- (void)pushBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
