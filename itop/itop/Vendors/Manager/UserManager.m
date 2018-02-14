//
//  UserManager.m
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "UserManager.h"
#import "InterfaceBase.h"
#import "UserModel.h"

#define  GET_DATA @"加载中..."
#define  TOP_VIEW [[[UIManager sharedUIManager]topViewController]view]

#define  ERROR_MESSAGER(__id_obj)  if (_errorFailure){ \
_errorFailure(__id_obj); }

#define  SHOW_ERROR_MESSAGER(__error)  [[Global sharedSingleton]showToastInCenter: TOP_VIEW withMessage:__error];

#define  SHOW_GET_DATA [[Global sharedSingleton] createProgressHUDInView:TOP_VIEW withMessage:GET_DATA];

#define  HIDDEN_GET_DATA [MBProgressHUD hideHUDForView:TOP_VIEW animated:NO];


@implementation UserManager

+ (instancetype)shareUserManager{
    
    static UserManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

#pragma mark - 获取用户基本信息
- (UserInfomation*)crrentUserInfomation{
    
    UserInfomation * info = (UserInfomation *)[[Global sharedSingleton]
               getUserDefaultsWithKey:UD_KEY_LAST_LOGIN_USERINFOMATION ];
    return info;
}

- (BOOL)isLogin{
    
//    if ([self crrentUserInfomation] != nil) return YES;
    return NO;
//    return YES;
}

#pragma mark - 登录
- (void)loginWithUserName:(NSString *)userName passWord:(NSString *)password{
    
    SHOW_GET_DATA
    NSString *api = @"/api/user/login";
    NSDictionary *parameters = @{@"username" : userName,
                                 @"password" : password };
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            UserModel *user = [[UserModel alloc]initWithDictionary:object error:nil];
            [[Global sharedSingleton]
             setUserDefaultsWithKey:UD_KEY_LAST_LOGIN_USERINFOMATION
             andValue:[user toJSONString]];

            _loginSuccess(user);
        }

    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

-(void)loginOut{
    
    SHOW_GET_DATA
    NSString *api = @"/api/user/logout";
    NSDictionary *parameters = @{};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
//            UserModel *user = [[UserModel alloc]initWithDictionary:object error:nil];
//            [[Global sharedSingleton]
//             setUserDefaultsWithKey:UD_KEY_LAST_LOGIN_USERINFOMATION
//             andValue:[user toJSONString]];
            
            _loginSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];

}

#pragma mark - 获取验证码
- (void)getVerificationCodeWithPhone:(NSString *)phone{
    
    SHOW_GET_DATA
    NSString *api = @"/api/user/sendphonecode";
    NSDictionary *parameters = @{@"number" : phone};
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            _verificationSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
        
    }];
}

- (void)registeredWithUserName:(NSString *)userName
                      passWord:(NSString *)password
              verificationCode:(NSString *)verificationCode{
    
    SHOW_GET_DATA
    NSString *api = @"/api/user/register";
    NSDictionary *parameters = @{@"username" : userName,
                                 @"password" : password,
                                 @"name" : userName,
                                 @"phone" : userName,
                                 @"phone_code" : verificationCode
                                 };
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            _registeredSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
        
    }];

}

- (void)userInfomation{
    
    SHOW_GET_DATA
    NSString *api = @"/api/user/getinfo";
    NSDictionary *parameters = @{};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            _userInfoSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)updataInfoWithKeyValue:(NSDictionary *)parameters{
    
    SHOW_GET_DATA
    NSString *api = @"/api/user/updateinfo";
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            _updataInfoSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}


- (void)resetPasswordWithUserName:(NSString *)userName
                         passWord:(NSString *)password
                 verificationCode:(NSString *)verificationCode{
    
    SHOW_GET_DATA
    NSString *api = @"/api/user/resetpassword";
    NSDictionary *parameters = @{@"username" : userName,
                                 @"newPassword" : password,
                                 @"phoneCode" : verificationCode
                                 };
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            _resetPasswordSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)focusOnUserWithUserId:(NSString *)user_id focusType:(FocusType)focusType{
    SHOW_GET_DATA
    
    NSString *api;
    if (focusType == FocusTypeFocus) {
        
        api = @"/api/userfollow/unfollow";
        
    } else {
        
        api = @"/api/userfollow/follow";
    }
    
    NSDictionary *parameters = @{@"id" : user_id};
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            _focusOnUserSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)collectionOnHotWithHotId:(NSString *)hot_id CollectionType:(CollectionType)collectionType{
    
    SHOW_GET_DATA
    NSString *api = collectionType == CollectionTypeCollection ? @"/api/article/cancelcollection" : @"/api/article/collection";
    NSDictionary *parameters = @{@"id" : hot_id ? hot_id : @""};
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            _collectionOnHotSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];

}

- (void)homeH5ListWithType:(H5ProductType )type
                 PageIndex:(NSInteger )pageIndex
                 PageCount:(NSInteger )pageCount{
    NSString *api = @"/api/product/getpagelist";
    NSDictionary *parameters = @{@"Product_type" : @(type),
                                 @"PageIndex" : @(pageIndex),
                                 @"PageCount" : @(pageCount),
                                 };
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
            
        } else {
            
            NSArray *arr = object[@"rows"];
            _homeH5ListSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)tagH5ListWithType:(TagH5ListType )type
                 PageIndex:(NSInteger )pageIndex
                 PageCount:(NSInteger )pageCount{
    
    NSString *api = @"/api/tag/getindexlist";
    NSDictionary *parameters = @{@"Product_type" : @(type),
                                 @"PageIndex" : @(pageIndex),
                                 @"PageCount" : @(pageCount),
                                 };
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
            
        } else {
            
//            NSArray *arr = object[@"rows"];
            _tagListSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)hometagListWithType:(TagType )type{
    
//    SHOW_GET_DATA
    NSString *api = @"/api/tag/getindexlist";
    NSDictionary *parameters = @{@"tagType" : @(type)};
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
//        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
            
        } else {
            _homeTagListSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
//        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)designerlistWithPageIndex:(NSInteger )pageIndex
                        PageCount:(NSInteger )pageCount
                 designerListType:(DesignerListType)designerListType{
    
//    SHOW_GET_DATA
    
    NSString *api;
    if (designerListType == DesignerListTypeHome) {
        api = @"/api/userdesigner/getpagelist";
    }else{
        api = @"/api/userfollow/getuserlist";
    }
    NSDictionary *parameters = @{@"PageIndex" : @(pageIndex),
                                 @"PageCount" : @(pageCount),
                                 };
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
//        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
            
        } else {
            NSArray *arr = object[@"rows"];
            _designerlistSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
//        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)designerDetailWithDesigner:(NSString *)designer_id{
    
    SHOW_GET_DATA
    NSString *api = @"/api/userdesigner/getinfo";
    NSDictionary *parameters = @{@"id" : designer_id};
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
            
        } else {
            _designerDetailSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)designerProductListWithDesigner:(NSString *)designer_id
                              PageIndex:(NSInteger )pageIndex
                              PageCount:(NSInteger )pageCount{
    
//    SHOW_GET_DATA
    NSString *api = @"/api/product/getpagelist";
    NSDictionary *parameters = @{@"User_id"   : designer_id,
                                 @"PageIndex" : @(pageIndex),
                                 @"PageCount" : @(pageCount),
                                 };
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
//        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
            
        } else {
            NSArray *arr = object[@"rows"];
            _designerProductListSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
//        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)hotListWithType:(ArticleType )type
              PageIndex:(NSInteger )pageIndex
              PageCount:(NSInteger )pageCount
     getArticleListType:(GetArticleListType)getArticleListType{
//    SHOW_GET_DATA
    
    NSString *api = getArticleListType == GetArticleListTypeHot ? @"/api/article/getpagelist" :@"/api/article/getcollection";
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(pageIndex) forKey:@"PageIndex"];
    [parameters setObject:@(pageCount) forKey:@"PageCount"];
    if (type == ArticleTypeDefault || type ==ArticleTypeVideo ||type == ArticleTypeH5) {
        [parameters setObject:@(type) forKey:@"Article_type"];
    }
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
//        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            NSArray *arr = object[@"rows"];
            _hotlistSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
//        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)hotDetailWithHotDetailId:(NSString *)detail_id
                       PageIndex:(NSInteger )pageIndex
                       PageCount:(NSInteger )pageCount{
    SHOW_GET_DATA
    NSString *api = @"/api/article/get";
    NSDictionary * parameters = @{@"id" : detail_id};
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
//            NSArray *arr = object[@"rows"];
            _hotDetailSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)productDetailWithHotDetailId:(NSString *)detail_id{
    SHOW_GET_DATA
    NSString *api = @"/api/product/get";
    NSDictionary * parameters = @{@"id" : detail_id};
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            _productDetailSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)hotCommentWithHotDetailId:(NSString *)detail_id
                        PageIndex:(NSInteger )pageIndex
                        PageCount:(NSInteger )pageCount{
    SHOW_GET_DATA
    NSString *api = @"/api/article/getcomment";
    NSDictionary * parameters = @{@"id" : detail_id};
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            //NSArray *arr = object[@"rows"];
            _hotCommentSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)homeBanner{
    
//    SHOW_GET_DATA
    NSString *api = @"/api/common/getbannerlist";
    NSDictionary * parameters = @{@"type" : @(2)};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
//        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object)
        } else {
            
            _homeBannerSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
//        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}


- (void)commentHotWithHotArticleId:(NSString *)article_id
                          parentId:(NSString *)parent_id
                           content:(NSString *)content{
    SHOW_GET_DATA
    NSString *api = @"/api/article/comment";
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:article_id forKey:@"Article_id"];
    [parameters setObject:content forKey:@"Content"];
    
    if (parent_id != nil) {
        [parameters setObject:parent_id forKey:@"Parent_id"];
    }
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            _commentHotSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)myProductListWithProductType:(MyProductType )Product_type
                           PageIndex:(NSInteger )pageIndex
                           PageCount:(NSInteger )pageCount{
    
    SHOW_GET_DATA
    NSString *api = @"/api/product/getuserproduct";
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(pageIndex) forKey:@"PageIndex"];
    [parameters setObject:@(pageCount) forKey:@"PageCount"];
    if (Product_type == MyProductTypeVideo || Product_type == MyProductTypeDefault ||Product_type == MyProductTypeScenario || Product_type == MyProductTypeSinglePage) {
        [parameters setObject:@(Product_type) forKey:@"Product_type"];
    }
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            NSArray *arr = object[@"rows"];
            _myProductListSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)leaveProductWithProductId:(NSString *)product_id
                        PageIndex:(NSInteger )pageIndex
                        PageCount:(NSInteger )pageCount{
    SHOW_GET_DATA
    NSString *api = @"/api/productbook/getpagelist";
    NSDictionary *parameters = @{@"Product_id" : product_id,
                                 @"PageIndex" : @(pageIndex),
                                 @"PageCount" : @(pageCount),
                                 };
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            NSArray *arr = object[@"rows"];
            _myProductListSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

@end
