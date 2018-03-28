//
//  UserManager.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ArticleType) { //文章类型
    ArticleTypeDefault = 0, //资讯
    ArticleTypeH5 = 1,//H5List
    ArticleTypeVideo,//H5视频
    ArticleTypeOther//其他
};

typedef NS_ENUM(NSInteger, GetArticleListType) { //获取文章入口
    GetArticleListTypeHot = 0, //热点获取
    GetArticleListTypeFocus = 1,//收藏获取
    GetArticleListTypeMyHot //我的热点
};

typedef NS_ENUM(NSInteger, H5ProductType) { //H5作品类型
    H5ProductTypeDefault = 0, //默认
    H5ProductTypeScenario = 1,//场景H5
    H5ProductTypeSinglePage,//单页
    H5ProductTypeVideo//H5视频
};

typedef NS_ENUM(NSInteger, TagH5ListType) { //TagH5作品类型
    TagH5ListDefault = 0, //默认
    TagH5ListProduct = 1,//作品
    TagH5ListArticle ,//热点
    TagH5ListTrade ,//行业
    TagH5ListField ,//领域  《设计师用》
};

typedef NS_ENUM(NSInteger, TagType) { //首页Tag类型
    TagTypeDefault = 0, //默认
    TagTypeProduct = 1,//作品
    TagTypeArticle,//热点
    TagTypeTrade,//行业
    TagTypeField //领域
};

typedef NS_ENUM(NSInteger, MyProductType) {  //我的作品类型
    MyProductTypeDefault = 0, //默认
    MyProductTypeScenario = 1,//场景H5
    MyProductTypeSinglePage,//单页
    MyProductTypeVideo//H5视频
};

typedef NS_ENUM(NSInteger, DesignerListType) {  // 获取设计师list入口
    DesignerListTypeHome = 0, //首页获取
    DesignerListTypeFocus = 1,//我关注的设计师
};

typedef NS_ENUM(NSInteger, FocusType) {  //关注用户状态
     FocusTypeTypeCancelFocus = 0, //未关注
     FocusTypeFocus = 1,//关注
};

typedef NS_ENUM(NSInteger, CollectionType) { //收藏文章状态
     CollectionTypeCancelCollection = 0, //未收藏
     CollectionTypeCollection = 1,//收藏
};

typedef NS_ENUM(NSInteger, SigningType) { //入驻申请
    SigningTypeDesigner = 0, //设计师
    SigningTypeCompany = 1,//企业
    SigningTypeMarketing ,//自营销人
};

typedef NS_ENUM(NSInteger, UserType) { //用户类型
    UserTypeDefault = 0, //一般用户
    UserTypeDesigner = 1,//设计师
    UserTypeEnterprise,//企业
    UserTypeMarketing//自营销
};

typedef NS_ENUM(NSInteger, CheckStatusType) { //作品审核状态
    CheckStatusTypeNoel = 0, //未审核
    CheckStatusTypeOnCheck = 1,//审核中
    CheckStatusTypeOK,//通过
    CheckStatusTypeUnPass//不通过
};

typedef NS_ENUM(NSUInteger, UMS_SHARE_TYPE){ //微信分享类型
    
    UMS_SHARE_TYPE_TEXT, //文本
    UMS_SHARE_TYPE_IMAGE,//图片
    UMS_SHARE_TYPE_IMAGE_URL,//图片地址
    UMS_SHARE_TYPE_TEXT_IMAGE,//图文
    UMS_SHARE_TYPE_WEB_LINK,//链接
    UMS_SHARE_TYPE_MUSIC_LINK,//音乐地址
    UMS_SHARE_TYPE_MUSIC,//音频文件
    UMS_SHARE_TYPE_VIDEO_LINK,//视频地址
    UMS_SHARE_TYPE_VIDEO,//视频文件
    UMS_SHARE_TYPE_EMOTION,
    UMS_SHARE_TYPE_FILE,//文件
    UMS_SHARE_TYPE_MINI_PROGRAM
};

typedef NS_ENUM(NSInteger, FeedbackType) { //用户类型
    FeedbackTypeCustomerService = 1,//联系客服
    FeedbackTypeOpinion = 2, //意见反馈
};

typedef NS_ENUM(NSInteger, ItemType) {//H5类型
    
    H5ItmeViewController = 0,//H5
    VideoItmeViewController = 1,//Video
};

typedef NS_ENUM(NSInteger, StatisticsType) {//统计数据类型
    
    StatisticsTypeH5Product = 0,//H5
    StatisticsTypeHot = 1,//热点
    StatisticsTypeFuns //粉丝
};

typedef NS_ENUM(NSInteger, GetProductListType) { //获取文章入口
    GetProductListTypeHome = 0, //首页
    GetProductListTypeSelect = 1,//选择作品
    GetProductListTypeMyProduct //我的作品
};

typedef NS_ENUM(NSInteger, StatisticalDataType) { //获取数据统计入口
    StatisticalDataTypeSingle = 0, //单个作品
    StatisticalDataTypeAll,//全部 作品／热点／粉丝
};

typedef NS_ENUM(NSInteger, OrderStatusType) { //推广订单状态
    OrderStatusTypeReady = 0, //准备中
    OrderStatusTypeGoOn = 1, //进行中
    OrderStatusTypefail , //完成失败
    OrderStatusTypeSucess , //完成
    OrderStatusTypeStart, //开启中
    OrderStatusTypeNoel , //全部
};

typedef void (^LoginSuccess)(id obj);
typedef void (^LoginFailure)(id obj);
typedef void (^VerificationSuccess)(id obj);
typedef void (^VerificationFailure)(id obj);
typedef void (^BindPhoneSuccess)(id obj);
typedef void (^BindPhoneFailure)(id obj);
typedef void (^ChangePassSuccess)(id obj);
typedef void (^ChangePassFailure)(id obj);
typedef void (^RegisteredSuccess)(id obj);
typedef void (^RegisteredFailure)(id obj);
typedef void (^UserInfoSuccess)(id obj);
typedef void (^UserInfoFailure)(id obj);
typedef void (^UpdataInfoSuccess)(id obj);
typedef void (^UpdataInfoFailure)(id obj);
typedef void (^ResetPasswordSuccess)(id obj);
typedef void (^ResetPasswordFailure)(id obj);

typedef void (^HomeH5ListSuccess)(id obj);
typedef void (^HomeH5ListFailure)(id obj);
typedef void (^HomeTagListSuccess)(id obj);
typedef void (^HomeTagListFailure)(id obj);
typedef void (^TagListSuccess)(id obj);
typedef void (^TagListFailure)(id obj);

typedef void (^FocusOnUserSuccess)(id obj);
typedef void (^FocusOnUserFailure)(id obj);
typedef void (^CollectionOnHotSuccess)(id obj);
typedef void (^CollectionOnHotFailure)(id obj);

typedef void (^DesignerlistSuccess)(id obj);
typedef void (^DesignerlistFailure)(id obj);
typedef void (^DesignerDetailSuccess)(id obj);
typedef void (^DesignerDetailFailure)(id obj);
typedef void (^DesignerProductListSuccess)(id obj);
typedef void (^DesignerProductListFailure)(id obj);

typedef void (^AddHotSuccess)(id obj);
typedef void (^AddHotFailure)(id obj);

typedef void (^HotlistSuccess)(id obj);
typedef void (^HotlistFailure)(id obj);
typedef void (^HotDetailSuccess)(id obj);
typedef void (^HotDetailFailure)(id obj);
typedef void (^ProductDetailSuccess)(id obj);
typedef void (^ProductDetailFailure)(id obj);
typedef void (^HotCommentSuccess)(id obj);
typedef void (^HotCommentFailure)(id obj);
typedef void (^CommentListSuccess)(id obj);
typedef void (^CommentListFailure)(id obj);

typedef void (^CommentSuccess)(id obj);
typedef void (^CommentFailure)(id obj);

typedef void (^HomeBannerSuccess)(id obj);
typedef void (^HomeBannerFailure)(id obj);
typedef void (^MyProductListSuccess)(id obj);
typedef void (^MyProductListFailure)(id obj);
typedef void (^LeaveProductSuccess)(id obj);
typedef void (^LeaveProductFailure)(id obj);
typedef void (^SubmitFileSuccess)(id obj);
typedef void (^SubmitFileFailure)(id obj);
typedef void (^SigningSuccess)(id obj);
typedef void (^SigningFailure)(id obj);
typedef void (^CustomerServiceSuccess)(id obj);
typedef void (^CustomerServiceFailure)(id obj);
typedef void (^DeledeProductSuccess)(id obj);
typedef void (^DeledeProductFailure)(id obj);

typedef void (^StatisticsSuccess)(id obj);
typedef void (^StatisticsFailure)(id obj);

typedef void (^EarningListSuccess)(id obj);
typedef void (^EarningListFailure)(id obj);
typedef void (^PopularizeSuccess)(id obj);
typedef void (^PopularizeFailure)(id obj);

typedef void (^UpdataProductSuccess)(id obj);
typedef void (^UpdataProductFailure)(id obj);

typedef void (^MessageListSuccess)(id obj);
typedef void (^MessageListFailure)(id obj);

typedef void (^ErrorFailure)(id obj);

@class UserModel;
@interface UserManager : NSObject
/*----------------全局错误信息————————————————————————*/
@property (nonatomic, copy) ErrorFailure  errorFailure;

/*----------------登录————————————————————————*/
@property (nonatomic, copy) LoginSuccess loginSuccess;
@property (nonatomic, copy) LoginFailure loginFailure;

/*----------------获取验证码————————————————————————*/
@property (nonatomic, copy) VerificationSuccess verificationSuccess;
@property (nonatomic, copy) VerificationFailure verificationFailure;

/*----------------bindPhone————————————————————————*/
@property (nonatomic, copy) BindPhoneSuccess bindPhoneSuccess;
@property (nonatomic, copy) BindPhoneFailure bindPhoneFailure;

/*----------------ChangePass————————————————————————*/
@property (nonatomic, copy) ChangePassSuccess changePassSuccess;
@property (nonatomic, copy) ChangePassFailure changePassFailure;

/*----------------注册————————————————————————*/
@property (nonatomic, copy) RegisteredSuccess registeredSuccess;
@property (nonatomic, copy) RegisteredFailure registeredFailure;
/*----------------获取个人信息————————————————————————*/
@property (nonatomic, copy) UserInfoSuccess userInfoSuccess;
@property (nonatomic, copy) UserInfoFailure userInfoFailure;
/*----------------更新个人信息————————————————————————*/
@property (nonatomic, copy) UpdataInfoSuccess updataInfoSuccess;
@property (nonatomic, copy) UpdataInfoFailure updataInfoFailure;

/*----------------重置密码————————————————————————*/
@property (nonatomic, copy) ResetPasswordSuccess resetPasswordSuccess;
@property (nonatomic, copy) ResetPasswordFailure resetPasswordFailure;
/*----------------关注用户————————————————————————*/
@property (nonatomic, copy) FocusOnUserSuccess focusOnUserSuccess;
@property (nonatomic, copy) FocusOnUserFailure focusOnUserFailure;
/*----------------收藏热点————————————————————————*/
@property (nonatomic, copy) CollectionOnHotSuccess collectionOnHotSuccess;
@property (nonatomic, copy) CollectionOnHotFailure collectionOnHotFailure;
/*----------------首页H5————————————————————————*/
@property (nonatomic, copy) HomeH5ListSuccess homeH5ListSuccess;
@property (nonatomic, copy) HomeH5ListFailure homeH5ListFailure;
/*----------------首页Tag————————————————————————*/
@property (nonatomic, copy) HomeTagListSuccess homeTagListSuccess;
@property (nonatomic, copy) HomeTagListFailure homeTagListFailure;
/*----------------TagList————————————————————————*/
@property (nonatomic, copy) TagListSuccess tagListSuccess;
@property (nonatomic, copy) TagListFailure tagListFailure;

/*----------------设计师列表————————————————————————*/
@property (nonatomic, copy) DesignerlistSuccess designerlistSuccess;
@property (nonatomic, copy) DesignerlistFailure designerlistFailure;

/*----------------设计师详情————————————————————————*/
@property (nonatomic, copy) DesignerDetailSuccess designerDetailSuccess;
@property (nonatomic, copy) DesignerDetailFailure designerDetailFailure;
/*----------------设计师作品列表————————————————————————*/
@property (nonatomic, copy) DesignerProductListSuccess designerProductListSuccess;
@property (nonatomic, copy) DesignerProductListFailure designerProductListFailure;

/*----------------添加热点————————————————————————*/
@property (nonatomic, copy) AddHotSuccess addHotSuccess;
@property (nonatomic, copy) AddHotFailure addHotFailure;

/*----------------热点列表————————————————————————*/
@property (nonatomic, copy) HotlistSuccess hotlistSuccess;
@property (nonatomic, copy) HotlistFailure hotlistFailure;
/*----------------热点详情————————————————————————*/
@property (nonatomic, copy) HotDetailSuccess hotDetailSuccess;
@property (nonatomic, copy) HotDetailFailure hotDetailFailure;
/*----------------作品预览详情————————————————————————*/
@property (nonatomic, copy) ProductDetailSuccess productDetailSuccess;
@property (nonatomic, copy) ProductDetailFailure productDetailFailure;
/*----------------热点评论列表————————————————————————*/
@property (nonatomic, copy) HotCommentSuccess hotCommentSuccess;
@property (nonatomic, copy) HotCommentFailure hotCommentFailure;
/*----------------我的-评论列表————————————————————————*/
@property (nonatomic, copy) CommentListSuccess commentListSuccess;
@property (nonatomic, copy) CommentListFailure commentListFailure;

/*----------------评论热点————————————————————————*/
@property (nonatomic, copy) CommentSuccess commentSuccess;
@property (nonatomic, copy) CommentFailure commentFailure;

/*----------------Home轮播图————————————————————————*/
@property (nonatomic, copy) HomeBannerSuccess homeBannerSuccess;
@property (nonatomic, copy) HomeBannerFailure homeBannerFailure;

/*----------------我的作品————————————————————————*/
@property (nonatomic, copy) MyProductListSuccess myProductListSuccess;
@property (nonatomic, copy) MyProductListFailure myProductListFailure;

/*----------------作品留资————————————————————————*/
@property (nonatomic, copy) LeaveProductSuccess leaveProductSuccess;
@property (nonatomic, copy) LeaveProductFailure LeaveProductFailure;
/*----------------提交base64文件————————————————————————*/
@property (nonatomic, copy) SubmitFileSuccess submitFileSuccess;
@property (nonatomic, copy) SubmitFileFailure submitFileFailure;
/*----------------入驻————————————————————————*/
@property (nonatomic, copy) SigningSuccess signingSuccess;
@property (nonatomic, copy) SigningFailure signingFailure;
/*----------------反馈和客服————————————————————————*/
@property (nonatomic, copy) CustomerServiceSuccess customerServiceSuccess;
@property (nonatomic, copy) CustomerServiceFailure customerServiceFailure;

/*----------------反馈和客服————————————————————————*/
@property (nonatomic, copy) DeledeProductSuccess deledeProductSuccess;
@property (nonatomic, copy) DeledeProductFailure deledeProductFailure;

/*----------------数据统计————————————————————————*/
@property (nonatomic, copy) StatisticsSuccess statisticsSuccess;
@property (nonatomic, copy) StatisticsFailure statisticsFailure;
/*----------------收益记录————————————————————————*/
@property (nonatomic, copy) EarningListSuccess earningListSuccess;
@property (nonatomic, copy) EarningListFailure earningListFailure;

/*----------------推广管理————————————————————————*/
@property (nonatomic, copy) PopularizeSuccess popularizeSuccess;
@property (nonatomic, copy) PopularizeFailure popularizeFailure;

/*----------------更行作品————————————————————————*/
@property (nonatomic, copy) UpdataProductSuccess updataProductSuccess;
@property (nonatomic, copy) UpdataProductFailure updataProductFailure;

/*----------------消息获取————————————————————————*/
@property (nonatomic, copy) MessageListSuccess messageListSuccess;
@property (nonatomic, copy) MessageListFailure messageListFailure;


+ (instancetype)shareUserManager;

/**
 *  判断用户是否登录
 *
 *  @return YSE or No
 */
- (BOOL)isLogin;

/**
 *  判断用户是否微信登录
 *
 *  @return YSE or No
 */
- (BOOL)isWechatLogin;

/**
 *  获取本用户
 *
 */
- (UserModel*)crrentUserInfomation;

/**
 *  获取本用户类型
 *
 */
-(NSInteger)crrentUserType;

/**
 *  获取本用户id
 *
 */
-(NSNumber *)crrentUserId;

/**
 *  用户登录
 *
 *  @param userName 用户帐号
 *  @param password 密码
 */
- (void)loginWithUserName:(NSString *)userName passWord:(NSString *)password;

/**
 *  微信授权后上传code到服务器
 *
 *  @param code 微信授权后的code
 */
-(void)wechatLoginWithCallBackCode:(NSString *)code;

/**
 *  绑定手机号码
 *
 *  @param mobili 手机号码
 *  @param verificationCode 验证码
 */
- (void)bindPhoneWithMobili:(NSString *)mobili
           verificationCode:(NSString *)verificationCode;

/**
 *  绑定手机号码
 *
 *  @param originalPass 旧密码
 *  @param newPass 新密码
 */
- (void)changePassWithOriginalPass:(NSString *)originalPass
                           newPass:(NSString *)newPass;

/**
 *  用户登出
 *
 */
-(void)loginOut;

/**
 *  获取验证码
 *
 *  @param phone 手机号码
 */
- (void)getVerificationCodeWithPhone:(NSString *)phone;

/**
 *  注册
 *
 *  @param userName 用户帐号
 *  @param password 密码
 *  @param verificationCode 验证码
 */
- (void)registeredWithUserName:(NSString *)userName
                      passWord:(NSString *)password
              verificationCode:(NSString *)verificationCode;

/**
 *  获取用户信息
 *  @param user_type 用户类型
 */
- (void)userInfomationWithUserType:(UserType)user_type;

/**
 *  注册
 *
 *  @param parameters 需要修改的itme
 */
- (void)updataInfoWithKeyValue:(NSDictionary *)parameters
                      userType:(UserType)userType;

/**
 *  重置
 *
 *  @param userName 用户帐号
 *  @param password 密码
 *  @param verificationCode 验证码
 */
- (void)resetPasswordWithUserName:(NSString *)userName
                         passWord:(NSString *)password
                 verificationCode:(NSString *)verificationCode;
/**
 *  关注用户
 *
 *  @param user_id 用户id
 */
- (void)focusOnUserWithUserId:(NSString *)user_id focusType:(FocusType)focusType;

/**
 *  收藏热点
 *
 *  @param hot_id 用户id
 *  @param collectionType 收藏／取消
 */
- (void)collectionOnHotWithHotId:(NSString *)hot_id
                  CollectionType:(CollectionType)collectionType;


/**
 *  首页H5
 *
 *  @param type H5类型
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 */
- (void)homeH5ListWithType:(H5ProductType )type
                 PageIndex:(NSInteger )pageIndex
                 PageCount:(NSInteger )pageCount;

/**
 *  tagList
 *
 *  @param type tag类型
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 */
- (void)tagH5ListWithType:(TagH5ListType )type
                PageIndex:(NSInteger )pageIndex
                PageCount:(NSInteger )pageCount;

/**
 *  首页Tag
 *
 *  @param type Tag类型
 */
- (void)hometagListWithType:(TagType )type;

/**
 *  首页轮播图
 *
 */
- (void)homeBanner;

/**
 *  设计师列表
 *
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 */
- (void)designerlistWithPageIndex:(NSInteger )pageIndex
                        PageCount:(NSInteger )pageCount
                 designerListType:(DesignerListType)designerListType;
/**
 *  设计师详情
 *
 *  @param designer_id 设计师ID
 */
- (void)designerDetailWithDesigner:(NSString *)designer_id;

/**
 *  设计师作品列表
 *
 *  @param designer_id 设计师ID
 */
- (void)designerProductListWithDesigner:(NSString *)designer_id
                              PageIndex:(NSInteger )pageIndex
                              PageCount:(NSInteger )pageCount;

/**
 *  添加热点
 *
 *  @param parameters 添加的内容
 */
- (void)addHotListWithParameters:(NSDictionary *)parameters;


/**
 *  热点列表
 *
 *  @param type 文章类型
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 *  @param getArticleListType 获取入口  热点／收藏
 */
- (void)hotListWithType:(ArticleType )type
              PageIndex:(NSInteger )pageIndex
              PageCount:(NSInteger )pageCount
     getArticleListType:(GetArticleListType)getArticleListType;

/**
 *  热点详情
 *
 *  @param detail_id 热点详情 id
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 */
- (void)hotDetailWithHotDetailId:(NSString *)detail_id
                       PageIndex:(NSInteger )pageIndex
                       PageCount:(NSInteger )pageCount;
/**
 *  作品详情
 *
 *  @param detail_id 详情 id
 */
- (void)productDetailWithHotDetailId:(NSString *)detail_id;

/**
 *  获取热点评论列表
 *
 *  @param detail_id 热点详情 id
 *  @param pageIndex 页 预留
 *  @param pageCount 总数／页  预留
 */
- (void)hotCommentWithHotDetailId:(NSString *)detail_id
                        PageIndex:(NSInteger )pageIndex
                        PageCount:(NSInteger )pageCount;

/**
 *  获取我的作品评论列表
 *
 *  @param product_id 作品 id
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 */
- (void)commentListWithProductId:(NSString *)product_id
                       PageIndex:(NSInteger )pageIndex
                       PageCount:(NSInteger )pageCount;


/**
 *  评论热点
 *
 *  @param Article_id 文章 id
 *  @param parent_id 回复评论ID
 *  @param content 回复内容
 */
- (void)commentHotWithHotArticleId:(NSString *)Article_id
                          parentId:(NSString *)parent_id
                          content:(NSString *)content;

/**
 *  评论作品
 *
 *  @param product_id 作品 id
 *  @param parent_id 回复评论ID
 *  @param content 回复内容
 */
- (void)commentProductWithHotProductId:(NSString *)product_id
                              parentId:(NSString *)parent_id
                               content:(NSString *)content;

/**
 *  我的作品
 *
 *  @param product_type 作品详情
 *  @param checkStatusType 审核状态
 *  @param isShow 是否展示
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 */
- (void)myProductListWithProductType:(MyProductType )product_type
                     checkStatusType:(CheckStatusType)checkStatusType
                              isShow:(NSInteger )isShow
                           PageIndex:(NSInteger )pageIndex
                           PageCount:(NSInteger )pageCount;


/**
 *  作品留资
 *
 *  @param product_id 作品详情
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 */
- (void)leaveProductWithProductId:(NSString *)product_id
                        PageIndex:(NSInteger )pageIndex
                        PageCount:(NSInteger )pageCount;

/**
 *  提交Base64文件
 *
 *  @param parameters 文件参数 Base64文件／尾缀
 */
- (void)submitFileWithParameters:(NSDictionary *)parameters;

/**
 *  提交入驻申请
 *
 *  @param parameters 文件参数
 *  @param signingType 申请类型
 */
- (void)submitSigningWithParameters:(NSDictionary *)parameters signingType:(SigningType)signingType;

/**
 *  提交意见反馈
 *
 *  @param content 提交内容
 *  @param feedbackType 联系客服／意见反馈
 */
-(void)opinionCustomerServiceWithContent:(NSString *)content feedbackType:(FeedbackType)feedbackType;

/**
 *  删除作品
 *
 *  @param product_id 作品id
 */
-(void)deleteProductWithProductId:(NSString *)product_id;

/**
 *  删除作品
 *
 *  @param startDate  开始日期
 *  @param endDate 结束日期
 *  @param statisticsType 统计类型
 */
-(void)dataStatisticsWithStartDate:(NSString *)startDate
                           endDate:(NSString *)endDate
                    statisticsType:(StatisticsType)statisticsType;

/**
 *  删除作品
 *
 *  @param pageIndex 页
 *  @param pageCount 条／页
 */
- (void)earningListWithPageIndex:(NSInteger )pageIndex
                       PageCount:(NSInteger )pageCount;

/**
 *  删除作品
 *
 *  @param user_id 用户id
 *  @param order_status 订单状态
 */
- (void)popularizeListWithUserId:(NSNumber *)user_id
                     orderStatus:(OrderStatusType )order_status
                       PageIndex:(NSInteger )pageIndex
                       PageCount:(NSInteger )pageCount;

/**
 *  更新作品
 *
 *  @param parameters 作品参数
 */
- (void)updataProductWithParameters:(NSDictionary *)parameters;

/**
 *  获取消息
 *
 */
-(void)messageList;

@end
