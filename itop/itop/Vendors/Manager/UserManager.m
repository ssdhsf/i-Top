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

#pragma mark - 获取用户登录基本信息
- (UserModel*)crrentUserInfomation{
    
    NSString * infoString = [[Global sharedSingleton]
               getUserDefaultsWithKey:UD_KEY_LAST_LOGIN_USERINFOMATION];
    UserModel *user= [[UserModel alloc]initWithString:infoString error:nil];
    return user;
}

- (InfomationModel*)crrentInfomationModel{
    
    NSString * infoString = [[Global sharedSingleton]
                             getUserDefaultsWithKey:INFOMATION_EDIT_MODEL([[UserManager shareUserManager]crrentUserId])];
    InfomationModel *user= [[InfomationModel alloc]initWithString:infoString error:nil];
    return user;
}

-(NSInteger)crrentUserType{
    
    UserModel *user = [self crrentUserInfomation];
    NSInteger user_type = [user.user_type integerValue];
    return user_type;
}

-(NSNumber *)crrentUserId{
    
    UserModel *user = [self crrentUserInfomation];
    NSNumber *user_id = user.user_info.user_id ;
    return user_id;
}

-(NSString *)crrentUserHeadImage{
    
    UserModel *user = [self crrentUserInfomation];
    NSString *head_img = user.user_info.head_img ;
    return head_img;
}

-(NSNumber *)crrentMessageCount {
    
    UserModel *user = [self crrentUserInfomation];
    NSNumber *message_count = user.user_operation.message_count;
    return message_count;
}

-(NSNumber *)crrentCommentCount {
    
    UserModel *user = [self crrentUserInfomation];
    NSNumber *comment_count = user.user_operation.comment_count;
    return comment_count;
}

-(NSNumber *)crrentFollowCount {
    
    UserModel *user = [self crrentUserInfomation];
    NSNumber *follow_count = user.user_operation.follow_count;
    return follow_count;
}

- (BOOL)isLogin{
    
    if ([self crrentUserInfomation] != nil) return YES;
    return NO;
}

- (BOOL)isWechatLogin{
    
    NSString *string = [[Global sharedSingleton]
                        getUserDefaultsWithKey:UD_KEY_LAST_WECHTLOGIN_CODE];
    if (string != nil) return YES;
    return NO;
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

-(void)wechatLoginWithCallBackCode:(NSString *)code{
    
    SHOW_GET_DATA
    NSString *api = @"/api/user/wechatlogin";
    NSDictionary *parameters = @{@"code" : code,
                                 @"type" : @"app" };
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
//            _loginFailure(object);
            
        } else {
            
            _loginSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)bindPhoneWithMobili:(NSString *)mobili
              verificationCode:(NSString *)verificationCode{
    
    SHOW_GET_DATA
    NSString *api = @"/api/user/bindphone";
    NSString *cacheKey = [[Global sharedSingleton]
                          getUserDefaultsWithKey:WECHTLOGIN_CACHE_KEY];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:mobili forKey:@"phone"];
    [parameters setObject:verificationCode forKey:@"phoneCode"];
    if (cacheKey != nil) {
        
       [parameters setObject:cacheKey forKey:@"cacheKey"];
    }
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            _bindPhoneSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
        
    }];
}

- (void)changePhoneWithMobili:(NSString *)newPhone
                 newPhoneCode:(NSString *)newPhoneCode
                 oldPhoneCode:(NSString *)oldPhoneCode{
    
    SHOW_GET_DATA
    NSString *api = @"/api/user/changphone";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:newPhone forKey:@"newPhone"];
    [parameters setObject:newPhoneCode forKey:@"newPhoneCode"];
    [parameters setObject:oldPhoneCode forKey:@"oldPhoneCode"];
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            _bindPhoneSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
        
    }];
}

- (void)changePassWithOriginalPass:(NSString *)originalPass
                           newPass:(NSString *)newPass {
    
    SHOW_GET_DATA
    NSString *api = @"/api/user/changepassword";
    NSDictionary *parameters = @{@"oldPassword" : originalPass,
                                 @"newPassword" : newPass};
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            _changePassSuccess(object);
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

- (void)userInfomationWithUserType:(UserType)user_type{
    
    SHOW_GET_DATA
    NSString *api = @"/api/user/getinfo";
    
//    switch (user_type) {
//        case UserTypeDefault:
//            api = @"/api/user/getinfo";
//            break;
//        case UserTypeDesigner:
//            api = @"/api/userdesigner/get";
//            break;
//        case UserTypeEnterprise:
//            api = @"/api/userenterprise/get";
//            break;
//        case UserTypeMarketing:
//            api = @"/api/usermarketing/getinfo";
//            break;
//            
//        default:
//            break;
//    }
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:nil completion:^(id object) {
        
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

- (void)updataInfoWithKeyValue:(NSDictionary *)parameters
                      userType:(UserType)userType{
    
    SHOW_GET_DATA
    NSString *api = [NSString string];
    switch (userType) {
            
        case UserTypeEnterprise:
            api = @"/api/userenterprise/updateinfo";
            break;
        case UserTypeMarketing:
            api = @"/api/usermarketing/updateinfo";
            break;
        case UserTypeDesigner:
            api = @"/api/userdesigner/updateinfo";
            break;
        case UserTypeDefault:
            api = @"/api/user/updateinfo";
            break;
        default:
            break;
    }

    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            if (userType == UserTypeDefault) {
                
                _updataInfoSuccess(object);
            } else {
                
                _updataUserInfoSuccess(object);
            }
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

- (void)praiseOnHotWithHotId:(NSString *)hot_id{

    SHOW_GET_DATA
    NSString *api = @"/api/article/praise";
    NSDictionary *parameters = @{@"id" : hot_id};
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            _praiseHotSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)soldOutMyHotWithHotId:(NSString *)hot_id
                       isShow:(NSNumber *)isShow{
    
    
    SHOW_GET_DATA
    NSString *api = @"/api/article/show";
    NSDictionary *parameters = @{@"id" : hot_id,
                                 @"isShow": isShow};
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            _hotStareSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)deleteMyHotWithHotId:(NSString *)hot_id{
    
    
    SHOW_GET_DATA
    NSString *api = @"/api/article/delete";
    NSDictionary *parameters = @{@"id" : hot_id};
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            _hotStareSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)homeH5ListWithType:(H5ProductType )type
                 PageIndex:(NSInteger )pageIndex
                 PageCount:(NSInteger )pageCount
                   tagList:(NSArray *)tagList
                 searchKey:(NSString *)searchKey
                    isShow:(BOOL)isShow{
    
    NSString *api = @"/api/product/getpagelist";
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
   
    [parameters setObject:@(pageIndex) forKey:@"PageIndex"];
    [parameters setObject:@(pageCount) forKey:@"pageCount"];
    
    if(isShow){

        [parameters setObject:@"true" forKey:@"Commend"];
    } else {
        
        [parameters setObject:@"false" forKey:@"Commend"];
    }
    
    if (tagList.count != 0) {
        [parameters setObject:tagList forKey:@"TagList"];
    }else {
        
        if (type != H5ProductTypeNoel) {
            [parameters setObject:@(type) forKey:@"Product_type"];
        }
    }
    if (searchKey != nil) {
        [parameters setObject:searchKey forKey:@"Keyword"];
    }
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
            
        } else {
            
            NSArray *arr = object[@"rows"];
            _homeH5ListSuccess(arr,[NSNumber numberWithInteger:type]);
        }
        
    } failure:^(NSError *error) {
        
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)tagH5ListWithType:(TagH5ListType )type
                 PageIndex:(NSInteger )pageIndex
                 PageCount:(NSInteger )pageCount{
    
    NSString *api = @"/api/tag/getlist";
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
    NSString *api = @"/api/tag/getlist";
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

- (void)homeProductTagListWithType:(NSNumber *)parent_id{
    
    //    SHOW_GET_DATA
    NSString *api = @"/api/tag/getlistbyparentid";
    NSDictionary *parameters = @{@"tagType" : parent_id};
    
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


-(void)cityList{

    SHOW_GET_DATA
    NSString *api = @"/api/article/getcitylist";
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:nil completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
            
        } else {
            NSArray *arr = object[@"rows"];
            _cityListSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)designerlistWithPageIndex:(NSInteger )pageIndex
                        PageCount:(NSInteger )pageCount
                 designerListType:(DesignerListType)designerListType
                        searchKey:(NSString *)searchKey{
    
    NSString *api;
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(pageIndex) forKey:@"PageIndex"];
    [parameters setObject:@(pageCount) forKey:@"pageCount"];

    if (designerListType == DesignerListTypeHome) {
        
        api = @"/api/userdesigner/getpagelist";
        if (searchKey != nil) {
           [parameters setObject:searchKey forKey:@"Keyword"];
        }
    }else{
        
        api = @"/api/userfollow/getuserlist";
    }
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
            
        } else {
            NSArray *arr = object[@"rows"];
            _designerlistSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)designerDetailWithDesigner:(NSNumber *)designer_id{
    
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

- (void)designerProductListWithDesigner:(NSNumber *)designer_id
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

- (void)addHotListWithParameters:(NSDictionary *)parameters{
    
    SHOW_GET_DATA
    NSString *api = @"/api/article/add";
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
                HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
//            NSArray *arr = object[@"rows"];
            _addHotSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
                HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)updateHotListWithParameters:(NSDictionary *)parameters{
    
     SHOW_GET_DATA
    NSString *api = @"/api/article/update";
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
                HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            _addHotSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}


- (void)hotListWithType:(ArticleType )type
              PageIndex:(NSInteger )pageIndex
              PageCount:(NSInteger )pageCount
     getArticleListType:(GetArticleListType)getArticleListType
              searchKey:(NSString *)searchKey{
//    SHOW_GET_DATA
    
    NSString *api =  [NSString string];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(pageIndex) forKey:@"PageIndex"];
    [parameters setObject:@(pageCount) forKey:@"PageCount"];

    switch (getArticleListType) {
       
        case GetArticleListTypeHot:
            api = @"/api/article/getpagelist";
            if (searchKey != nil) {
               [parameters setObject:searchKey forKey:@"Title"]; //搜索字段
            }
             [parameters setObject:@"true" forKey:@"Show"];
            break;
        case GetArticleListTypeFocus:
            api = @"/api/article/getcollection";
            break;
        case GetArticleListTypeMyHot:
            api = @"/api/article/getuserarticle";
            break;

        default:
            break;
    }
    if (type == ArticleTypeDefault || type ==ArticleTypeVideo ||type == ArticleTypeH5) { //默认／H5/视频
        [parameters setObject:@(type) forKey:@"Article_type"];
    }

    if (type == ArticleTypeLocal) { //本地
        
        Province *city = [[CompanySigningStore shearCompanySigningStore]cityWithCityCode:[MapLocationManager sharedMapLocationManager].location provinceCode:[MapLocationManager sharedMapLocationManager].province];
        [parameters setObject:city.code forKey:@"City_code"];
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

- (void)productDetailWithHotDetailId:(NSNumber *)detail_id{
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

- (void)commentListWithProductId:(NSString *)product_id
                       PageIndex:(NSInteger )pageIndex
                       PageCount:(NSInteger )pageCount{
    SHOW_GET_DATA
    NSString *api = @"/api/article/getcommentlist";
    NSDictionary * parameters = @{@"id" : product_id,
                                  @"PageIndex" : @(pageIndex),
                                  @"PageCount" : @(pageCount)
                                  };

    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            NSArray *arr = object[@"rows"];
            _commentListSuccess(arr);
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
            
            _commentSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}


- (void)commentProductWithHotProductId:(NSString *)product_id
                              parentId:(NSString *)parent_id
                               content:(NSString *)content{
    SHOW_GET_DATA
    NSString *api = @"/api/product/comment";
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:product_id forKey:@"Product_id"];
    [parameters setObject:content forKey:@"Content"];
    
    if (parent_id != nil) {
        [parameters setObject:parent_id forKey:@"Parent_id"];
    }
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            _commentSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)myProductListWithProductType:(MyProductType )product_type
                     checkStatusType:(CheckStatusType)checkStatusType
                              isShow:(NSInteger )isShow
                           PageIndex:(NSInteger )pageIndex
                           PageCount:(NSInteger )pageCount{
    
//    SHOW_GET_DATA
    NSString *api = @"/api/product/getuserproduct";
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(pageIndex) forKey:@"PageIndex"];
    [parameters setObject:@(pageCount) forKey:@"PageCount"];
    if (product_type == MyProductTypeVideo || product_type == MyProductTypeDefault ||product_type == MyProductTypeScenario || product_type == MyProductTypeSinglePage) {
        [parameters setObject:@(product_type) forKey:@"Product_type"];
    }
    if (checkStatusType == CheckStatusTypeOK || checkStatusType == CheckStatusTypeNoel || checkStatusType == CheckStatusTypeUnPass || checkStatusType == CheckStatusTypeOnCheck ) {
        
        [parameters setObject:@(checkStatusType) forKey:@"Check_status"];
    }
    
    if (isShow == 0 || isShow == 1) {
        
        [parameters setObject:@(isShow) forKey:@"Show"];
    }
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
//        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            NSArray *arr = object[@"rows"];
            _myProductListSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
//        HIDDEN_GET_DATA
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
            _leaveProductSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}


- (void)submitImageWithParameters:(NSDictionary *)parameters{
    
    SHOW_GET_DATA
    NSString *api =@"/api/common/uploadbase64";
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {

            NSString *string = [NSString stringWithFormat:@"%@",object];
            _submitFileSuccess(string);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)submitFileWithParameters:(NSDictionary *)parameters{
    
    SHOW_GET_DATA
    NSString *api =@"/api/common/uploadfile";
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            NSString *string = [NSString stringWithFormat:@"%@",object];
            _submitFileSuccess(string);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)submitSigningWithParameters:(NSDictionary *)parameters signingType:(SigningType)signingType{
    
    SHOW_GET_DATA
    NSString *api =  [NSString string];
    
    switch (signingType) {
        
        case SigningTypeDesigner:
            api = @"/api/userdesigner/apply";
            break;
        case SigningTypeCompany:
            api = @"/api/userenterprise/apply";
            break;
        case SigningTypeMarketing:
            api = @"/api/usermarketing/apply";
            break;
        default:
            break;
    }
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            NSString *string = [NSString stringWithFormat:@"%@",object];
            _signingSuccess(string);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];

}

- (void)signingState{
    SHOW_GET_DATA
    NSString *api = @"/api/user/getapplyinfo";
    NSDictionary *parameters = nil;
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
//            NSString *string = [NSString stringWithFormat:@"%@",object];
            _signingSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
    
}

-(void)opinionCustomerServiceWithContent:(NSString *)content feedbackType:(FeedbackType)feedbackType{
   
    SHOW_GET_DATA
    NSString *api =  [NSString string];
    
//    if (feedbackType == FeedbackTypeOpinion) {
    
        api = @"/api/userfeedback/add";
//    }else {
//        
//        api = @"/api/userfeedback/add";
//    }
//    
    NSDictionary *parameters = @{@"Content" : content,
                                 @"FeedBackType" : @(feedbackType)};

    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            NSString *string = [NSString stringWithFormat:@"%@",object];
            _customerServiceSuccess(string);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

-(void)deleteProductWithProductId:(NSString *)product_id{
    
    SHOW_GET_DATA
    NSString *api =  [NSString string];
    
    api = @"/api/product/delete";
    
    NSDictionary *parameters = @{@"id" : product_id,};
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            NSString *string = [NSString stringWithFormat:@"%@",object];
            _deledeProductSuccess(string);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

-(void)dataStatisticsWithStartDate:(NSString *)startDate
                           endDate:(NSString *)endDate
                    statisticsType:(StatisticsType)statisticsType{
    
    SHOW_GET_DATA
    NSString *api;

    switch (statisticsType ) {
        case StatisticsTypeH5Product:
            api = @"/api/count/product";
            break;
        case StatisticsTypeHot:
            api = @"/api/count/article";
            break;
        case StatisticsTypeFuns:
            api = @"/api/count/fansattr";
            break;
        case StatisticsTypePop:
            api = @"/api/count/order";
            break;
        default:
            break;
    }
    NSDictionary *parameters = @{@"startDate" : startDate,
                                 @"endDate" : endDate,
                                 };
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            _statisticsSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)earningListWithPageIndex:(NSInteger )pageIndex
                       PageCount:(NSInteger )pageCount{
//    SHOW_GET_DATA
    NSString *api = @"/api/rewardrecord/getpagelist";
    NSDictionary *parameters = @{@"PageIndex" : @(pageIndex),
                                 @"PageCount" : @(pageCount),
                                 };
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            NSArray *arr = object[@"rows"];
            _earningListSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)tradingListWithPageIndex:(NSInteger )pageIndex
                       PageCount:(NSInteger )pageCount{
    
    NSString *api = @"/api/payment/getrecordlist";
    NSDictionary *parameters = @{@"PageIndex" : @(pageIndex),
                                 @"PageCount" : @(pageCount),
                                 };
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            NSArray *arr = object[@"rows"];
            _tradingListSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)popularizeListWithUserId:(NSNumber *)user_id
                     orderStatus:(OrderStatusType )order_status
                       PageIndex:(NSInteger )pageIndex
                       PageCount:(NSInteger )pageCount{
    //    SHOW_GET_DATA
    NSString *api = @"/api/order/getuserlist";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(pageCount) forKey:@"PageCount"];
    [parameters setObject:@(pageIndex) forKey:@"PageIndex"];
//    if (order_status != OrderStatusTypeNoel) {
////       [parameters setObject:@(order_status) forKey:@"Order_status"];
//    }
//  @{@"PageIndex" : @(pageIndex),
//                                 @"PageCount" : @(pageCount),
//                                 @"Order_status" : @(order_status),
////                                 @"User_id" : user_id,
//                                 };
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            NSArray *arr = object[@"rows"];
            _popularizeSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)popularizeStatisticsCountWithUserId:(NSNumber *)user_id{
    
//    SHOW_GET_DATA
    NSString *api = @"/api/count/orderforuserid";
    NSDictionary *parameters = @{@"user_id" : user_id};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
//        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            _popularizeSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
//        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)deletePopularizeWithOrderId:(NSNumber *)order_id {
    
    SHOW_GET_DATA
    NSString *api = @"/api/order/delete";
    NSDictionary *parameters = @{@"id" : order_id};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            _popularizeSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)updataOrderStatePopularizeWithOrderId:(NSNumber *)order_id
                                        state:(OrderStatusType)state{
    
    SHOW_GET_DATA
    NSString *api = @"/api/order/updateorderstatus";
    NSDictionary *parameters = @{@"id" : order_id, @"orderStatus" : @(state)};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            _popularizeSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)popularizeIsAcceptWithOrderId:(NSNumber *)order_id
                             isAccept:(NSNumber *)isAccept{
    
    SHOW_GET_DATA
    NSString *api = @"/api/order/acceptorder";
    NSDictionary *parameters = @{@"id" : order_id,
                                 @"isAccept" : isAccept};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
//            NSArray *arr = object[@"rows"];
            _popularizeSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)commentPopularizeWithOrderId:(NSNumber *)order_id
                              effect:(NSNumber *)effect
                             service:(NSNumber *)service
                           sincerity:(NSNumber *)sincerity
                             content:(NSString *)content
                         commentType:(CommentType)commentType{
    SHOW_GET_DATA
    NSString *api = [NSString string];
    NSDictionary *parameters = [NSDictionary dictionary];
    
    switch (commentType) {
        case CommentTypePopularize:
            api = @"/api/order/score";
            parameters = @{@"order_id" : order_id,
                           @"effect" : effect,
                           @"service" : service,
                           @"sincerity" : sincerity,
                           @"content" : content};

            break;
        case CommentTypeDemandEnterpriseToDesginer: //企业评价设计师接口
            api = @"/api/demand/enterprisescore";
            parameters = @{@"demand_id" : order_id,
                           @"quality" : effect,
                           @"time" : service,
                           @"profession" : sincerity,
                           @"content" : content};
        
            break;
        case CommentTypeDemandDesginerToEnterprise: //设计师评价企业接口
    
            api = @"/api/demand/designerscore";
            parameters = @{@"demand_id" : order_id,
                           @"specific" : effect,
                           @"change" : service,
                           @"attitude" : sincerity,
                           @"content" : content};
      
            break;
            
        default:
            break;
    }
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            _popularizeSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)updataProductWithParameters:(NSDictionary *)parameters{
  
    SHOW_GET_DATA
    NSString *api =@"/api/product/update";
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            NSString *string = [NSString stringWithFormat:@"%@",object];
            _updataProductSuccess(string);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}


-(void)messageList{
    
    NSString *api = @"/api/usermessage/getuserlist";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
//            NSArray *arr = object[@"rows"];
            _messageListSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

-(void)userMessageListWithId:(NSString *)user_id{
    
    NSString *api = @"/api/usermessage/getlist";
    NSDictionary *parameters = @{@"id":user_id};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            //            NSArray *arr = object[@"rows"];
            _messageListSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

-(void)sendMessageWithUserId:(NSString *)user_id messageContent:(NSString *)content {
    
    NSString *api = @"/api/usermessage/sendmessage";
    NSDictionary *parameters = @{@"Receive_user_id":user_id,
                                 @"Message" : content};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
//        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            //            NSArray *arr = object[@"rows"];
            _messageListSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
//        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)customRequirementsListWithUserId:(NSNumber *)user_id
                               PageIndex:(NSInteger )pageIndex
                               PageCount:(NSInteger )pageCount{
    
    NSString *api = @"/api/demand/getpagelist";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(pageCount) forKey:@"PageCount"];
    [parameters setObject:@(pageIndex) forKey:@"PageIndex"];
    
    if (user_id != nil) {
       
        [parameters setObject:user_id forKey:@"User_id"];
    }
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            NSArray *arr = object[@"rows"];
            _customRequirementsSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)getUserCustomRequirementsListWithUserId:(NSNumber *)user_id
                                    demandType:(DemandType)demand_type
                                      PageIndex:(NSInteger )pageIndex
                                      PageCount:(NSInteger )pageCount{
   
    NSString *api = [NSString string];
    if ([[UserManager shareUserManager] crrentUserType] == UserTypeDesigner) {

        api = @"/api/demand/getdesignerpagelist";//设计师用户
    } else {

        api = @"/api/demand/getuserlist"; //企业用户接口
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(pageCount) forKey:@"PageCount"];
    [parameters setObject:@(pageIndex) forKey:@"PageIndex"];
    [parameters setObject:@(demand_type) forKey:@"Demand_type"];
    
    if (user_id != nil) {
        
        [parameters setObject:user_id forKey:@"User_id"];
    }
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            NSArray *arr = object[@"rows"];
            _customRequirementsSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)customRequirementsDetailWithDetailId:(NSNumber *)detail_id{
    
    SHOW_GET_DATA
    NSString *api = @"/api/demand/get";
    NSDictionary *parameters = @{@"id":detail_id};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
                HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            //            NSArray *arr = object[@"rows"];
            _customRequirementsSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
                HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)customRequirementsParameters:(NSDictionary *)parameters demandAddType:(DemandAddType)demandAddType{
    
    SHOW_GET_DATA
    
    NSString *api  = [NSString string];
    if (demandAddType == DemandAddTypeOnEdit) {
        api = @"/api/demand/update";
    }else {
        api = @"/api/demand/add";
    }
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            _customRequirementsSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)operationCustomRequirementsWithId:(NSNumber *)demant_id  operation:(NSString * )operationType{
    
    SHOW_GET_DATA
    NSString *api = [NSString string];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:demant_id forKey:@"id"];
    if ([operationType isEqualToString:@"删除"]) {
        api = @"/api/demand/delete";
    }
    
    if ([operationType isEqualToString:@"下架"]) {
        api = @"/api/demand/off";
    }
    
    if ([operationType isEqualToString:@"上架"]) {
        api = @"/api/demand/shelves";
    }
    
    if ([operationType isEqualToString:@"验收完成"]) {
        api = @"/api/demand/sucess";
    }
    
    if ([operationType isEqualToString:@"取消合作"]) {
        api = @"/api/demand/canceldemand";
        [parameters setObject:@"true" forKey:@"isCancel"];
    }

    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            _customRequirementsSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)operationCustomRequirementsWithId:(NSNumber *)demant_id  isAccept:(BOOL)isAccept{
    
    SHOW_GET_DATA
    NSString *api = @"/api/demand/acceptdemand";
    NSString *isAcceptString = isAccept ? @"true" : @"false";
    NSDictionary *parameters = @{@"id":demant_id,@"isAccept":isAcceptString};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            _customRequirementsSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];

    
}

- (void)biddingProductListWithId:(NSNumber *)demant_id{
  
    NSString *api = @"/api/demand/filelist";
    NSDictionary *parameters = @{@"id":demant_id};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
//            NSArray *arr = object[@"rows"];
            _customRequirementsSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)demandDesginerCommentListWithId:(NSNumber *)demant_id{
    
    NSString *api  = [NSString string];
    api = @"/api/demand/getdesignerscorepagelist";
    NSDictionary *parameters = @{@"id":demant_id};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            NSArray *arr = object[@"rows"];
            _customRequirementsCommentsDisginSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)demandentErpriseCommentListWithId:(NSNumber *)demant_id{
    
    NSString *api  = [NSString string];
    api = @"/api/demand/getenterprisescorepagelist";
    NSDictionary *parameters = @{@"id":demant_id , @"PageCount" : @100000,@"PageIndex" : @1};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            NSArray *arr = object[@"rows"];
            _customRequirementsCommentsCompanySuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)demandDemanddisputeListWithId:(NSNumber *)demant_id
                            pageIndex:(NSInteger )pageIndex
                            pageCount:(NSInteger )pageCount{
    
    NSString *api  = [NSString string];
    api = @"/api/demanddispute/getpagelist";
    NSDictionary *parameters = @{@"Demand_id":demant_id,@"PageIndex" : @(pageIndex) , @"PageCount" : @(pageCount)};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            NSArray *arr = object[@"rows"];
            _customRequirementsSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)selectCooperationDesginerWithId:(NSNumber *)demant_id desginerId:(NSNumber *)desginer_id{
    
    NSString *api  = [NSString string];
    api = @"/api/demand/selectebid";
    NSDictionary *parameters = @{@"id":demant_id,@"designerUserId" : desginer_id};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            _customRequirementsSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)addDemandDemanddisputeWithParameters:(NSDictionary *)parameters{
   
    SHOW_GET_DATA
    NSString *api  = [NSString string];
    api = @"/api/demanddispute/add";
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
//           NSArray *arr = object[@"rows"];
            _customRequirementsSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

- (void)myCaseListWithPageIndex:(NSInteger )pageIndex
                      PageCount:(NSInteger )pageCount
                    getCaseType:(GetCaseType)getCaseType
                         userId:(NSNumber *)user_id
                         isShow:(BOOL)isShow{
    
    //    SHOW_GET_DATA
    NSString *api = [NSString string];
    if (getCaseType == GetCaseTypeHome || getCaseType == GetCaseTypeOtherCase) {
       
        api = @"/api/demandcase/getpagelist";
    }else {

        api = @"/api/demandcase/getuserlist";
    }
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(pageIndex) forKey:@"PageIndex"];
    [parameters setObject:@(pageCount) forKey:@"PageCount"];
    if (getCaseType == GetCaseTypeOtherCase) {
        [parameters setObject:user_id forKey:@"User_id"];
    }
    
    if(isShow){
        
        [parameters setObject:@"true" forKey:@"Commend"];
    } else {
        
        [parameters setObject:@"false" forKey:@"Commend"];
    }
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        //        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            ERROR_MESSAGER(object);
        } else {
            
            NSArray *arr = object[@"rows"];
            _myCaseListSuccess(arr);
        }
        
    } failure:^(NSError *error) {
        
        //        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

-(void)deleteMyCaseWithCaseId:(NSNumber *)case_id{
    
    SHOW_GET_DATA
    NSString *api = @"/api/demandcase/delete";;
   
    NSDictionary *parameters = @{@"id" : case_id,};
    
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            NSString *string = [NSString stringWithFormat:@"%@",object];
            _deledeProductSuccess(string);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

-(void)editCaseWithParameters:(NSDictionary *)parameters isUpdate:(BOOL)isUpdata{
    
    SHOW_GET_DATA
    NSString *api  = [NSString string];
    if (isUpdata) {
        api = @"/api/demandcase/update";
    }else {
        api = @"/api/demandcase/add";
    }

    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            NSString *string = [NSString stringWithFormat:@"%@",object];
            _myCaseListSuccess(string);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

-(void)caseDetailWithCaseId:(NSNumber *)case_id{
    
    SHOW_GET_DATA
    NSString *api = @"/api/demandcase/get";
    NSDictionary *parameters = @{@"id" : case_id};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            _myCaseListSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

-(void)tenderWithDemandId:(NSNumber *)demand_id isCancel:(BOOL)isCancel{
    
    SHOW_GET_DATA
    NSString *api = @"/api/demand/bid";
    
    if (isCancel) {
        api = @"/api/demand/unbid";
    }
    
    NSDictionary *parameters = @{@"id" : demand_id};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            _customRequirementsSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

-(void)uploadfileWithParameters:(NSDictionary *)parameters{
    
    SHOW_GET_DATA
    NSString *api  = @"/api/demand/uploadfile";
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            NSString *string = [NSString stringWithFormat:@"%@",object];
            _uploadProductSuccess(string);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

-(void)checkcodeWithCode:(NSString *)code{
    
    SHOW_GET_DATA
    NSString *api  = @"/api/user/checkcode";
    NSString *phone = [[UserManager shareUserManager]crrentUserInfomation].phone;
    NSDictionary *parameters = @{@"Phone":phone , @"Phone_code":code};
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
//            NSString *string = [NSString stringWithFormat:@"%@",object];
            _checkCodeSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

-(void)payWithParameters:(NSDictionary *)parameters{
    
    SHOW_GET_DATA
    NSString *api  = @"/api/payment/pay";
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:parameters completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            _paySuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

-(void)getuserwallet{
    
    SHOW_GET_DATA
    NSString *api  = @"/api/user/getuserwallet";
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:nil completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            _balanceSuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

-(void)demandAuthority{
    
    SHOW_GET_DATA
    NSString *api  = @"/api/demand/authority";
    [[InterfaceBase sheardInterfaceBase]requestDataWithApi:api parameters:nil completion:^(id object) {
        
        HIDDEN_GET_DATA
        if ([object isKindOfClass:[NSError class]]) {
            
            _demandAuthorityFailure(object);
//            [[Global sharedSingleton]showToastInCenter:[[UIManager sharedUIManager]topViewController].view withError:object];
            
        } else {
            
            _demandAuthoritySuccess(object);
        }
        
    } failure:^(NSError *error) {
        
        
        
        HIDDEN_GET_DATA
        SHOW_ERROR_MESSAGER(error);
    }];
}

@end
