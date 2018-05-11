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
    ArticleTypeCommend,//推荐
    ArticleTypeLocal//本地
    
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
    H5ProductTypeVideo,//H5视频
    H5ProductTypeCase,//案例
    H5ProductTypeNoel//无
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
    DesignerListTypeHome = 0, //首页／搜索获取
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
    SigningTypeMarNoel //无
};

typedef NS_ENUM(NSInteger, SigningStateType) { //入驻申请状态
    SigningStateTypeUnCheck = 0, //未审核
    SigningStateTypeCheckOn = 1,//审核中
    SigningStateTypePass ,//审核通过
    SigningStateTypeUnPass //审核不通过
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
   
    FeedbackTypeOpinion = 1, //意见反馈
     FeedbackTypeCustomerService = 2,//联系客服
};

typedef NS_ENUM(NSInteger, ItemType) {//H5类型
    
    H5ItmeViewController = 0,//H5
    VideoItmeViewController = 1,//Video
};

typedef NS_ENUM(NSInteger, StatisticsType) {//统计数据类型
    
    StatisticsTypeH5Product = 0,//H5
    StatisticsTypeHot = 1,//热点
    StatisticsTypeFuns, //粉丝
    StatisticsTypePop //粉丝
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
    OrderStatusTypeReady = 0, //待接单
    OrderStatusTypeStart = 1, //进行中
    OrderStatusTypeRefuse , //拒绝
    OrderStatusTypeSucess , //完成
    OrderStatusTypeFail, //失败
    OrderStatusTypeScore , //已经评价
    OrderStatusTypePending, //待审核
    OrderStatusTypeCanceled, //已取消
    OrderStatusTypeNotPass //审核不通过
};

typedef NS_ENUM(NSInteger, DemandType) { //首页Tag类型
    DemandTypeDirectional = 0, //定向需求
    DemandTypeBidding = 1,//竞标需求
};

typedef NS_ENUM(NSInteger, CommentType) { //评价类型
    CommentTypePopularize = 0, //推广评价
    CommentTypeDemandDesginerToEnterprise = 1, //定制需求设计师评价企业
    CommentTypeDemandEnterpriseToDesginer  //定制需求企业评价设计师
};

typedef NS_ENUM(NSInteger, CustomRequirementsType) { //推广订单状态
    CustomRequirementsTypeUnAccept = 0, //待接单
    CustomRequirementsTypeAccept = 1, //已接单
    CustomRequirementsTypeRefuse , //已拒绝
    CustomRequirementsTypeBid , //竞标中
    CustomRequirementsTypeBidSucess, //竞标成功
    CustomRequirementsTypeBidFail , //竞标失败
    CustomRequirementsTypeBidCancel, //竞标取消
    CustomRequirementsTypeSucess, //验收完成
    CustomRequirementsTypeFail, //合作失败
    CustomRequirementsTypeCompletion, //已完成
    CustomRequirementsTypePending, //审核中
    CustomRequirementsTypeNotPass, //审核不通过
    CustomRequirementsTypeCanceled, //合作取消
    CustomRequirementsTypeOut, //已下架
    CustomRequirementsTypeIntervention, //平台介入
};

typedef NS_ENUM(NSInteger, PayProductType) { //支付产品价格
    PayProductType20 = 0, //20 
    PayProductType50 = 1, //50
    PayProductType100 , //100
    PayProductType200 , //200
    PayProductType500, //500
    PayProductType800 , //800
    PayProductType1000, //1000
    PayProductType2000, //2000  元
};

typedef NS_ENUM(NSInteger, BiddingPayType) { //绑定支付宝类型
    BiddingPayTypeWexinPay = 0, //微信支付
    BiddingPayTypeAliPay = 1, //支付宝
};

typedef NS_ENUM(NSInteger, GetCaseType) { //获取案例类型
    GetCaseTypeHome = 0, //首页案例
    GetCaseTypeMyCase = 1, //我的案例
};

typedef NS_ENUM(NSInteger, DemandAddType) { //获取案例类型
    DemandAddTypeOnNew = 0, //新增
    DemandAddTypeOnEdit = 1, //编辑
    DemandAddTypeOnProduct , //作品加载
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
typedef void (^PraiseHotSuccess)(id obj);
typedef void (^PraiseHotFailure)(id obj);

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
typedef void (^HotStareSuccess)(id obj);
typedef void (^HotStareFailure)(id obj);
typedef void (^CommentListSuccess)(id obj);
typedef void (^CommentListFailure)(id obj);

typedef void (^CommentSuccess)(id obj);
typedef void (^CommentFailure)(id obj);

typedef void (^HomeBannerSuccess)(id obj);
typedef void (^HomeBannerFailure)(id obj);
typedef void (^MyProductListSuccess)(id obj);
typedef void (^MyProductListFailure)(id obj);
typedef void (^MyCaseListSuccess)(id obj);
typedef void (^MyCaseListFailure)(id obj);
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

typedef void (^TradingListSuccess)(id obj);
typedef void (^TradingListFailure)(id obj);
typedef void (^EarningListSuccess)(id obj);
typedef void (^EarningListFailure)(id obj);
typedef void (^PopularizeSuccess)(id obj);
typedef void (^PopularizeFailure)(id obj);

typedef void (^UpdataProductSuccess)(id obj);
typedef void (^UpdataProductFailure)(id obj);

typedef void (^MessageListSuccess)(id obj);
typedef void (^MessageListFailure)(id obj);

typedef void (^MapLocationManagerSuccess)(id obj);//定位
typedef void (^MapLocationManagerFailure)(id obj);//定位

typedef void (^CityListSuccess)(id obj);
typedef void (^CityListFailure)(id obj);

typedef void (^CustomRequirementsSuccess)(id obj);
typedef void (^CustomRequirementsFailure)(id obj);
typedef void (^CustomRequirementsCommentsDisginSuccess)(id obj);
typedef void (^CustomRequirementsCommentsCompanySuccess)(id obj);

typedef void (^UploadProductSuccess)(id obj);
typedef void (^UploadProductFailure)(id obj);


typedef void (^ErrorFailure)(id obj);

@class UserModel;
@class InfomationModel;

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

/*----------------收藏热点/文章————————————————————————*/
@property (nonatomic, copy) PraiseHotSuccess praiseHotSuccess;
@property (nonatomic, copy) PraiseHotFailure praiseHotFailure;

/*----------------首页H5————————————————————————*/
@property (nonatomic, copy) HomeH5ListSuccess homeH5ListSuccess;
@property (nonatomic, copy) HomeH5ListFailure homeH5ListFailure;
/*----------------首页Tag————————————————————————*/
@property (nonatomic, copy) HomeTagListSuccess homeTagListSuccess;
@property (nonatomic, copy) HomeTagListFailure homeTagListFailure;
/*----------------TagList————————————————————————*/
@property (nonatomic, copy) TagListSuccess tagListSuccess;
@property (nonatomic, copy) TagListFailure tagListFailure;

/*----------------CityList————————————————————————*/
@property (nonatomic, copy) CityListSuccess cityListSuccess;
@property (nonatomic, copy) CityListFailure cityListFailure;

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
/*----------------删除／是否展示热点————————————————————————*/
@property (nonatomic, copy) HotStareSuccess hotStareSuccess;
@property (nonatomic, copy) HotStareFailure hotStareFailure;

/*----------------Home轮播图————————————————————————*/
@property (nonatomic, copy) HomeBannerSuccess homeBannerSuccess;
@property (nonatomic, copy) HomeBannerFailure homeBannerFailure;

/*----------------我的作品————————————————————————*/
@property (nonatomic, copy) MyProductListSuccess myProductListSuccess;
@property (nonatomic, copy) MyProductListFailure myProductListFailure;
/*----------------我的案例————————————————————————*/
@property (nonatomic, copy) MyCaseListSuccess myCaseListSuccess;
@property (nonatomic, copy) MyCaseListFailure myCaseListFailure;

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

/*----------------交易记录————————————————————————*/
@property (nonatomic, copy) TradingListSuccess tradingListSuccess;
@property (nonatomic, copy) TradingListFailure tradingListFailure;

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
/*----------------获取定位————————————————————————*/
@property (nonatomic, copy) MapLocationManagerSuccess mapLocationManagerSuccess;
@property (nonatomic, copy) MapLocationManagerFailure mapLocationManagerFailure;

/*----------------定制需求————————————————————————*/
@property (nonatomic, copy) CustomRequirementsSuccess customRequirementsSuccess;
@property (nonatomic, copy) CustomRequirementsFailure customRequirementsFailure;
@property (nonatomic, copy) CustomRequirementsCommentsDisginSuccess customRequirementsCommentsDisginSuccess;
@property (nonatomic, copy) CustomRequirementsCommentsCompanySuccess customRequirementsCommentsCompanySuccess;

/*----------------作品上传————————————————————————*/
@property (nonatomic, copy) UploadProductSuccess uploadProductSuccess;
@property (nonatomic, copy) UploadProductFailure uploadProductFailure;

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign) NSInteger timers;

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
 *   获取用户可编辑信息
 *
 *  @return YSE or No
 */
- (InfomationModel*)crrentInfomationModel;

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
 *  获取本用户头像
 *
 */
-(NSString *)crrentUserHeadImage;

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
 *  @param hot_id 文章／作品id
 *  @param collectionType 收藏／取消
 */
- (void)collectionOnHotWithHotId:(NSString *)hot_id
                  CollectionType:(CollectionType)collectionType;

/**
 *  点赞热点／作品
 *
 *  @param hot_id 文章／作品id
 */
- (void)praiseOnHotWithHotId:(NSString *)hot_id;

/**
 *  下架热点
 *
 *  @param hot_id 用户id
 *  @param isShow 会否展示
 */
- (void)soldOutMyHotWithHotId:(NSString *)hot_id
                       isShow:(NSNumber *)isShow;


/**
 *  删除热点
 *
 *  @param hot_id 用户id
 */
- (void)deleteMyHotWithHotId:(NSString *)hot_id;

/**
 *  首页H5
 *
 *  @param type H5类型
 *  @param pageIndex 页
 *  @param pageCount 总数／页
 *  @param tagList tag列表／首页必填
 *  @param searchKey 搜索关键字／搜索必填
 */
- (void)homeH5ListWithType:(H5ProductType )type
                 PageIndex:(NSInteger )pageIndex
                 PageCount:(NSInteger )pageCount
                   tagList:(NSArray *)tagList
                 searchKey:(NSString *)searchKey;

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
 *  获取消息列表
 *
 */
-(void)cityList;

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
 *  @param searchKey 搜索关键字／页
 */
- (void)designerlistWithPageIndex:(NSInteger )pageIndex
                        PageCount:(NSInteger )pageCount
                 designerListType:(DesignerListType)designerListType
                        searchKey:(NSString *)searchKey;
/**
 *  设计师详情
 *
 *  @param designer_id 设计师ID
 */
- (void)designerDetailWithDesigner:(NSNumber *)designer_id;

/**
 *  设计师作品列表
 *
 *  @param designer_id 设计师ID
 */
- (void)designerProductListWithDesigner:(NSNumber *)designer_id
                              PageIndex:(NSInteger )pageIndex
                              PageCount:(NSInteger )pageCount;

/**
 *  添加热点
 *
 *  @param parameters 添加的内容
 */
- (void)addHotListWithParameters:(NSDictionary *)parameters;

/**
 *  修改热点
 *
 *  @param parameters 修改的内容
 */
- (void)updateHotListWithParameters:(NSDictionary *)parameters;

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
     getArticleListType:(GetArticleListType)getArticleListType
              searchKey:(NSString *)searchKey;

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
- (void)productDetailWithHotDetailId:(NSNumber *)detail_id;

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
- (void)submitImageWithParameters:(NSDictionary *)parameters;

/**
 *  提交文件  data
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
 *   查看入驻申请
 *
 */
- (void)signingState;

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
 *  数据统计
 *
 *  @param startDate  开始日期
 *  @param endDate 结束日期
 *  @param statisticsType 统计类型
 */
-(void)dataStatisticsWithStartDate:(NSString *)startDate
                           endDate:(NSString *)endDate
                    statisticsType:(StatisticsType)statisticsType;

/**
 *  收益记录
 *
 *  @param pageIndex 页
 *  @param pageCount 条／页
 */
- (void)earningListWithPageIndex:(NSInteger )pageIndex
                       PageCount:(NSInteger )pageCount;

/**
 *  收益记录
 *
 *  @param pageIndex 页
 *  @param pageCount 条／页
 */
- (void)tradingListWithPageIndex:(NSInteger )pageIndex
                       PageCount:(NSInteger )pageCount;

/**
 *  获取推广订单分页
 *
 *  @param user_id 用户id
 *  @param order_status 订单状态
 */
- (void)popularizeListWithUserId:(NSNumber *)user_id
                     orderStatus:(OrderStatusType )order_status
                       PageIndex:(NSInteger )pageIndex
                       PageCount:(NSInteger )pageCount;
/**
 *  获取推广订单总量
 *
 *  @param user_id 用户id
 */
- (void)popularizeStatisticsCountWithUserId:(NSNumber *)user_id;

/**
 *  删除推广订单
 *
 *  @param order_id 订单id
 */
- (void)deletePopularizeWithOrderId:(NSNumber *)order_id;

/**
 *  更新推广订单状态
 *
 *  @param order_id 订单id
 *  @param state 状态
 */
- (void)updataOrderStatePopularizeWithOrderId:(NSNumber *)order_id
                                        state:(OrderStatusType)state;

/**
 *  接／拒单
 *
 *  @param order_id 订单id
 *  @param isAccept 是否接单
 */
- (void)popularizeIsAcceptWithOrderId:(NSNumber *)order_id
                             isAccept:(NSNumber *)isAccept;

/**
 *  接／拒单
 *
 *  @param order_id 订单id
 *  @param effect 是否接单
 *  @param service 是否接单
 *  @param sincerity 是否接单
 *  @param content 是否接单
 */
- (void)commentPopularizeWithOrderId:(NSNumber *)order_id
                              effect:(NSNumber *)effect
                             service:(NSNumber *)service
                           sincerity:(NSNumber *)sincerity
                             content:(NSString *)content
                         commentType:(CommentType)commentType;
/**
 *   更新作品
 *
 *  @param parameters 作品参数
 */
- (void)updataProductWithParameters:(NSDictionary *)parameters;

/**
 *  获取消息列表
 *
 */
-(void)messageList;

/**
 *  获取私信记录
 *
 *  @param user_id 用户id
 */
-(void)userMessageListWithId:(NSString *)user_id;

/**
 *  发送记录
 *
 *  @param user_id 发送对象用户id
 *  @param content 发送消息
 */
-(void)sendMessageWithUserId:(NSString *)user_id messageContent:(NSString *)content;

/*
 *  获取定制案例分页
 *
 *  @param user_id 用户id
 */
- (void)customRequirementsListWithUserId:(NSNumber *)user_id
                               PageIndex:(NSInteger )pageIndex
                               PageCount:(NSInteger )pageCount;
/*
 *  获取定制管理分页
 *
 *  @param user_id 用户id
 */
- (void)getUserCustomRequirementsListWithUserId:(NSNumber *)user_id
                                     demandType:(DemandType)demand_type
                                      PageIndex:(NSInteger )pageIndex
                                      PageCount:(NSInteger )pageCount;

/**
 *  获取定制案例详情
 *
 *  @param detail_id 用户id
 */
- (void)customRequirementsDetailWithDetailId:(NSNumber *)detail_id;

/**
 *  提交定制管理
 *
 *  @param parameters 提交定制管理参数
 *  @param isUpdata   是否更新
 */
- (void)customRequirementsParameters:(NSDictionary *)parameters demandAddType:(DemandAddType)demandAddType;

/**
 *  删除定制管理
 *
 *  @param demant_id 定制id
 */
- (void)deleteCustomRequirementsWithId:(NSNumber *)demant_id;

/**
 *  下架定制管理
 *
 *  @param demant_id 定制id
 *  @param operationType 操作类型
 */
- (void)operationCustomRequirementsWithId:(NSNumber *)demant_id  operation:(NSString * )operationType;

/**
 *  查询上传文件列表
 *
 *  @param demant_id 定制id
 */
- (void)biddingProductListWithId:(NSNumber *)demant_id;

/**
 *  定制订单(获取设计师评价分页)
 *
 *  @param demant_id 定制id
 */
- (void)demandDesginerCommentListWithId:(NSNumber *)demant_id;

/**
 *  定制订单(获取企业评价分页)
 *
 *  @param demant_id 定制id
 */
- (void)demandentErpriseCommentListWithId:(NSNumber *)demant_id;


/**
 *  获取定制订单纠纷列表
 *
 *  @param demant_id 定制id
 */
- (void)demandDemanddisputeListWithId:(NSNumber *)demant_id
                            pageIndex:(NSInteger )pageIndex
                            pageCount:(NSInteger )pageCount;

/**
 *  添加纠纷
 *
 *  @param parameters 纠纷参数 问题／图片证明／备注／demandId／UserId
 */
- (void)addDemandDemanddisputeWithParameters:(NSDictionary *)parameters;

/**
 *  我的案例
 *
 */
- (void)myCaseListWithPageIndex:(NSInteger )pageIndex
                      PageCount:(NSInteger )pageCount
                    getCaseType:(GetCaseType)getCaseType;

/**
 *  删除案例
 *
 */
-(void)deleteMyCaseWithCaseId:(NSNumber *)case_id;

/**
 *  添加案例
 *
 *  isUpdate 更新／添加
 */
-(void)editCaseWithParameters:(NSDictionary *)parameters isUpdate:(BOOL)isUpdata;

/**
 *  案例详情
 *  case_id  案例Id
 */
-(void)caseDetailWithCaseId:(NSNumber *)case_id;


/**
 *  上传作品
 *
 */
-(void)uploadfileWithParameters:(NSDictionary *)parameters;

@end
