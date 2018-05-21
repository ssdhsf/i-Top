//
//  Global.h
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define JXTOAST(message)           \
  {                                \
    [self.view makeToast:message]; \
  }

@class MBProgressHUD;

@interface Global : NSObject <NSCopying>

+ (Global *)sharedSingleton;

#pragma mark - 创建加载显示
- (MBProgressHUD *)createProgressHUDInView:(UIView *)view withMessage:(NSString *)message;

#pragma mark - 在View中显示Toast
- (void)showToastInCenter:(UIView *)view withMessage:(id )message;
- (void)showToastInTop:(UIView *)view withMessage:(NSString *)message;

- (void)showToastInCenter:(UIView *)view withError:(NSError *)error;

#pragma mark - 保存到userDefault
- (void)setUserDefaultsWithKey:(NSString *)key
                      andValue:(id)value;

#pragma mark - 从userDefault取出值
- (NSString *)getUserDefaultsWithKey:(NSString *)key;

#pragma mark - 从userDefault删除key
- (void)delUserDefaultsWithKey:(NSString *)key;

#pragma mark - 隐藏多余的tableView的线
- (void)setExtraCellLineHidden:(UITableView *)tableView;

#pragma mark - 补全分割线
- (void)fullSperatorLine:(UITableView *)tableView;

#pragma mark - ALAsset转UIImage
- (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset;

#pragma mark - 压缩图片
- (UIImage *)compressImage:(UIImage *)image;

#pragma mark - 手机号输入校验
- (BOOL)isMobileNumber:(NSString *)mobileNum;

#pragma mark - 获取documents下的文件路径
- (NSString *)getDocumentsPath:(NSString *)fileName;

#pragma mark - 获取string的高度 (限定宽度为width, 字体大小为fontSize)
+ (CGFloat)heightWithString:(NSString *)string
                      width:(CGFloat)width
                   fontSize:(CGFloat)fontSize;

#pragma mark - NSDate转NSString
- (NSString *)stringFromDate:(NSDate *)date pattern:(NSString*)pattern;

#pragma mark - NSString转NSDate
- (NSDate *)dateFromString:(NSString *)string pattern:(NSString*)pattern;

#pragma mark - 判断字符串是否为空
+(BOOL)stringIsNullWithString:(NSString *)string;

#pragma mark - 判断数组是否为空
+(BOOL)arrayIsNullWithArray:(NSArray *)array;

#pragma mark  Json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

#pragma mark  判断字符串是否为Json
+ (BOOL)isJsonWithJsonString:(NSString *)jsonString;

#pragma mark  加密字符串转字典
+ (id)dictionaryWithAESString:(id)responseObject;

#pragma mark 生成32位字符串
+(NSString *)ret32bitString;

#pragma mark 判断输入的内容是否是数字
+ (BOOL)validateNumber:(NSString*)number;

#pragma mark 图片转码
+ (NSString *)image2DataURL:(UIImage *) image;


#pragma mark 时间戳转时间字符串的方法
-(NSString *)timestampTotimeStringWithtimestamp:(NSString*)timestamp pattern:(NSString*)pattern;

#pragma mark 计算lab宽度
-(float) widthForString:(NSString *)value
               fontSize:(float)fontSize
              andHeight:(float)height;

#pragma mark 汉字转拼音
+ (NSString *)transform:(NSString *)chinese;

#pragma mark 时间格式转换 (同一种格式转换 2018-1-1 12:11:40 &2018-1-1)
-(NSString *)timeFormatTotimeStringFormatWithtime:(NSString*)time
                                      willPattern:(NSString*)willPattern
                                       didPattern:(NSString*)didPattern;

#pragma mark 添加虚线边框
-(CAShapeLayer *)buttonSublayerWithButton:(UIButton *)button;

#pragma mark 复制链接
-(void)copyTheLinkWithLinkUrl:(NSString *)linkUrl;

#pragma mark 判断汉字
- (BOOL)hasChinese:(NSString *)str;
@end
