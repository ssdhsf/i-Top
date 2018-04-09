//
//  Global.m
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "Global.h"
#import <AssetsLibrary/AssetsLibrary.h>
//#import "RSAUtil.h"
//#import "AESCrypt.h"
#import "AppDelegate.h"
//#import "Base64.h"

@implementation Global

+ (Global *)sharedSingleton {
  static dispatch_once_t once;
  static Global *_singleton = nil;
  dispatch_once(&once, ^{
    _singleton = [[super allocWithZone:NULL] init];
  });
  return _singleton;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
  return [self sharedSingleton];
}

#pragma mark - Implement NSCopying
- (id)copyWithZone:(NSZone *)zone {
  return self;
}

#pragma mark - Global functions
- (MBProgressHUD *)createProgressHUDInView:(UIView *)view withMessage:(NSString *)message {
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
  hud.mode = MBProgressHUDModeIndeterminate;

  if (message) {
    hud.labelText = message;
  } else {
    hud.labelText = @"正在加载";
  }

  return hud;
}

- (void)showToastInCenter:(UIView *)view withMessage:(id )message {
    
    NSString *string = [NSString stringWithFormat:@"%@",message];
  // 针对网络连接失败时的提示信息处理
  
    if ([string rangeOfString:@"NSURLErrorDomain"].location != NSNotFound || [string rangeOfString:@"NSCocoaErrorDomain"].location != NSNotFound) {
        string = @"网络连接失败";
    }
    
//  NSArray *errorDomains = @[ @"NSURLErrorDomain", @"NSCocoaErrorDomain" ];
//  if ([errorDomains containsObject:string]) {
//    string = @"网络连接失败";
//  }
  [view makeToast:string duration:1.0 position:CSToastPositionCenter];
}

- (void)showToastInTop:(UIView *)view withMessage:(NSString *)message {
  // 针对网络连接失败时的提示信息处理
    
    NSString *string = [NSString stringWithFormat:@"%@",message];
    if ([string rangeOfString:@"NSURLErrorDomain"].location != NSNotFound || [string rangeOfString:@"NSCocoaErrorDomain"].location != NSNotFound) {
        string = @"网络连接失败";
        
    }
//  NSArray *errorDomains = @[ @"NSURLErrorDomain", @"NSCocoaErrorDomain" ];
//  if ([errorDomains containsObject:message]) {
//    message = @"网络连接失败";
//  }
  [view makeToast:string duration:1.0 position:CSToastPositionCenter];
}


- (void)showToastInCenter:(UIView *)view withError:(NSError *)error;{
  //TODO 上线可能需要删掉错误码
  NSString *tips = [NSString stringWithFormat:@"%ld%@%@",(long)error.code,@":",error.domain];
  [self showToastInCenter:view withMessage:tips];
}

#pragma mark - NSUserDefaults操作

- (void)setUserDefaultsWithKey:(NSString *)key andValue:(id)value {
  
  [[NSUserDefaults standardUserDefaults] setObject:value
                                            forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSString *)getUserDefaultsWithKey:(NSString *)key {
  NSString *value = (NSString *) [[NSUserDefaults standardUserDefaults] objectForKey:key];
  return value;
}

- (void)delUserDefaultsWithKey:(NSString *)key {
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

#pragma mark - UITableView隐藏多余的分割线
- (void)setExtraCellLineHidden:(UITableView *)tableView {
  UIView *view = [[UIView alloc] init];
  view.backgroundColor = [UIColor clearColor];
  [tableView setTableFooterView:view];
  [tableView setTableHeaderView:view];
}

#pragma mark - 补全分割线
- (void)fullSperatorLine:(UITableView *)tableView {
  if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
    [tableView setSeparatorInset:UIEdgeInsetsZero];
  }

  if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
    [tableView setLayoutMargins:UIEdgeInsetsZero];
  }
}

#pragma mark - ALAsset转UIImage
- (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset {
  ALAssetRepresentation *assetRep = [asset defaultRepresentation];
  CGImageRef imgRef = [assetRep fullResolutionImage];
  UIImage *image = [UIImage imageWithCGImage:imgRef
                                       scale:assetRep.scale
                                 orientation:(UIImageOrientation) assetRep.orientation];

  return image;
}

#pragma mark - 压缩图片
- (UIImage *)compressImage:(UIImage *)image {
  CGSize size = image.size;

  // 对图片大小进行压缩
  if (size.width >= 960 || size.height >= 960) {
    float a = size.width > size.height ? size.height : size.width;
    float b = 320;
    float scaled = b / a;

    size.height *= scaled;
    size.width *= scaled;

    UIImage *imageNew = [self imageWithImage:image scaledToSize:size];
    float compressSize = 0.6;
    NSData *imageData = UIImageJPEGRepresentation(imageNew, compressSize);
    imageNew = [UIImage imageWithData:imageData];

//    if DEBUG {
      NSLog(@"Image file size: %.2fK", [self getImageFileSize:imageNew] / 960);
      NSLog(@"Image file size old: %.2fK", [self getImageFileSize:image] / 960);
//    }
    return imageNew;
  } else {
//    if DEBUG {
      NSLog(@"Image file size: %.2fK", [self getImageFileSize:image] / 960);
      NSLog(@"Image file size old: %.2fK", [self getImageFileSize:image] / 960);
//    }
    return image;
  }
}

// 获取图片大小
- (float)getImageFileSize:(UIImage *)image {
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSString *imageName = @"tmpImg";

  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *path = [paths objectAtIndex:0];
  NSString *filePath = [path stringByAppendingPathComponent:imageName];

  NSData *imageData = UIImageJPEGRepresentation(image, 1);

  BOOL ret = [fileManager createFileAtPath:filePath contents:imageData attributes:nil];
  if (ret) {
    return [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
  }
  return 0;
}

// 对图片尺寸进行压缩
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
  // Create a graphics image context
  UIGraphicsBeginImageContext(newSize);
  [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

// 手机号输入校验
- (BOOL)isMobileNumber:(NSString *)mobileNum {
  NSString *MOBILE = @"^([1][34578]\\d{9}$)";
  NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
  NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
  NSString *CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
  NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
  NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
  NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
  NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
  if (([regextestmobile evaluateWithObject:mobileNum] == YES) || ([regextestcm evaluateWithObject:mobileNum] == YES) || ([regextestct evaluateWithObject:mobileNum] == YES) || ([regextestcu evaluateWithObject:mobileNum] == YES)) {
    return YES;
  } else {
    return NO;
  }
}

- (NSString *)getDocumentsPath:(NSString *)fileName {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documents = [paths objectAtIndex:0];
  NSString *path = [documents stringByAppendingPathComponent:fileName];
  return path;
}
// 获取string的高度 (限定宽度为width, 字体大小为fontSize)
+ (CGFloat)heightWithString:(NSString *)string
                      width:(CGFloat)width
                   fontSize:(CGFloat)fontSize {
  CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:fontSize] } context:nil];

  return rect.size.height;
}
- (NSString *)stringFromDate:(NSDate *)date pattern:(NSString*)pattern{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
  [dateFormatter setDateFormat:pattern];
  NSString *dateStr = [dateFormatter stringFromDate:date];
  return dateStr;
}

- (NSDate *)dateFromString:(NSString *)string pattern:(NSString*)pattern
{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:pattern];
  NSLocale* locale = [NSLocale localeWithLocaleIdentifier: @"zh-CN"];
  [dateFormatter setLocale: locale];
  NSDate *date = [dateFormatter dateFromString:string];
  return date;
}

//判断字符串是否为空
+(BOOL)stringIsNullWithString:(NSString *)string{
  if (string == nil | string == NULL | [string isKindOfClass:[NSNull class]] | [string  isEqualToString:@""] | [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
    return YES;
  }else{
    return NO;
  }
}

//判断数组是否为空
+(BOOL)arrayIsNullWithArray:(NSArray *)array{
  if (array && ![array isKindOfClass:[NSNull class]] && array.count != 0){
    return YES;
  }else{
    return NO;
  }
}

#pragma Mark - json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
  if (jsonString == nil) {
    return nil;
  }
  NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
  NSError *err;
  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:NSJSONReadingMutableContainers
                                                        error:&err];
  if(err) {
    NSLog(@"json解析失败：%@",err);
    return nil;
  }
  return dic;
}

+ (BOOL)isJsonWithJsonString:(NSString *)jsonString{
  if (jsonString == nil) {
    return NO;
  }
  NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
  NSError *err;
  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:NSJSONReadingMutableContainers
                                                        error:&err];
  NSLog(@"%@",dic);
  if(err) {
    NSLog(@"json解析失败：%@",err);
    return NO;
  }
  return YES;
}

//+ (id)dictionaryWithAESString:(id)responseObject{
//  
//  NSLog(@"responseObject=%@",responseObject);
//  NSLog(@"SECRETKEY=%@",[[Global sharedSingleton] getUserDefaultsWithKey:SECRETKEY]);
//  if ([responseObject isKindOfClass:[NSString class]]) {
//    // AES加密
//    NSString *jsonString = [AESCrypt decrypt:responseObject password:[[Global sharedSingleton] getUserDefaultsWithKey:SECRETKEY]];
//    NSLog(@"%@",jsonString);
//    if ([jsonString isEqualToString:@""]) {
//      return nil;
//    }
//    if ([jsonString isEqualToString:@"null"]) {
//      return nil;
//    }
//    NSDictionary *jsonDic = [self dictionaryWithJsonString:jsonString];
//    
//    return jsonDic;
//  }else{
//    return responseObject;
//  }
//
//}


+(NSString *)ret32bitString

{

  char data[32];
  
  for (int x=0;x < 32;data[x++] = (char)('A' + (arc4random_uniform(57))));
  
  return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
  
}

+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

// 图片base64转码
+ (NSString *)image2DataURL:(UIImage *)image {
    
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    if  (alpha == kCGImageAlphaFirst ||
         alpha == kCGImageAlphaLast ||
        alpha == kCGImageAlphaPremultipliedFirst ||
         alpha == kCGImageAlphaPremultipliedLast){
        imageData = UIImagePNGRepresentation(image);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(image, 1.0f);
        mimeType = @"image/jpeg";
    }
    
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions: 0]];
}

-(NSString *)timestampTotimeStringWithtimestamp:(NSString*)timestamp pattern:(NSString*)pattern{
    if (timestamp == nil || [timestamp isEqualToString:@""] || [timestamp isKindOfClass:[NSNull class]] || [timestamp isEqualToString:@"0"]) {
        return timestamp = @"--" ;
    } else{
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp integerValue]];
//        NSString *str = @"2014-05-12 17:22:30";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:TIME_PATTERN_second];
        NSDate *date = [dateFormatter dateFromString:timestamp];
        NSString *time = [self stringFromDate:date pattern:pattern];
        return time;
    }
}

-(float) widthForString:(NSString *)value
               fontSize:(float)fontSize
              andHeight:(float)height {
    
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.width;
}

+ (NSString *)transform:(NSString *)chinese
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:chinese];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
//    //再转换为不带声调的拼音
//    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString] ;
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

-(NSString *)timeFormatTotimeStringFormatWithtime:(NSString*)time
                                      willPattern:(NSString*)willPattern
                                       didPattern:(NSString*)didPattern{
    
    NSDate *date =  [self dateFromString:time pattern:willPattern];
    NSString *dateString = [self stringFromDate:date pattern:didPattern];
    return dateString;
    
}

-(CAShapeLayer *)buttonSublayerWithButton:(UIButton *)button{
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, button.size.width, button.size.height);//虚线框的大小
    borderLayer.position = CGPointMake(CGRectGetMidX(button.bounds),CGRectGetMidY(button.bounds));//虚线框锚点
    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;//矩形路径
    borderLayer.lineWidth = 0.5/[[UIScreen mainScreen] scale];//虚线宽度
    //虚线边框
    borderLayer.lineDashPattern = @[@6, @3];
    //实线边框
    //    borderLayer.lineDashPattern = nil;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor grayColor].CGColor;
    return borderLayer;
}


@end
