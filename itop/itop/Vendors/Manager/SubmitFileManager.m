//
//  SubmitFileManager.m
//  xixun
//
//  Created by huangli on 16/5/12.
//  Copyright © 2016年 3N. All rights reserved.
//

#import "SubmitFileManager.h"
#import "MessagePhotoView.h"

@interface SubmitFileManager()<MessagePhotoViewDelegate>

@property (nonatomic ,strong)NSMutableArray *pictrArr;
@property (nonatomic ,strong)NSMutableArray *fileArray;
@property (nonatomic ,strong)NSArray *picturesArray;
@property (nonatomic ,assign)NSInteger uploadImageNumber;
@property (nonatomic ,assign)NSInteger failures; //提交图片失败张数

@end

@implementation SubmitFileManager

+ (instancetype)sheardSubmitFileManager{
    static SubmitFileManager * manager = nil ;
    static dispatch_once_t oneceToken ;
    
    dispatch_once(&oneceToken ,^{
        
        manager = [[SubmitFileManager alloc]init];
    });
    
    return manager;
}

-(NSMutableArray *)pictrArr{
    if (!_pictrArr) {
        self.pictrArr = [NSMutableArray array];
    }
    return _pictrArr;
}

- (void)addPictrueViewToViewController:(UIView *)view{
    
    _photoView=[[MessagePhotoView alloc]initWithFrame:_photoViewFrame];
    _photoView.backgroundColor=[UIColor whiteColor];
    _photoView.delegate=self;
    _photoView.howMany = @"3";
    _photoView.isBrowsePictures = NO;
    [view addSubview:_photoView];
}

- (void)writingAgainAddImageToMessagePhotoViewWithUrls:(NSArray*)urls{
    
    [_photoView.urlImage removeAllObjects];
    [_photoView.urlImage addObjectsFromArray:urls];
    [_photoView collectionViewReloadData];
}

- (void)browsePicturesWithPictureArray:(NSArray*)PictureArray{

    [_photoView browsePicturesWithPictureArray:PictureArray];
}

-(NSMutableArray *)fileArray{
    
    if (!_fileArray) {
        
        self.fileArray = [NSMutableArray array];
    }
    return _fileArray;
}

- (void)popupsSelectPhotoTipsView{
    
//    if (_pictrArr.count == 3) {
//       
//        [[Global sharedSingleton]showToastInCenter: [[UIManager sharedUIManager]topViewController].view withMessage:@" 选择图片不能超过3张"];
//    } else {
    
         [_photoView openMenu];
//    }
}

#pragma mark-打开相机相册获取图片的协议方法
- (void)introductionPhoto:(ZYQAssetPickerController *)photo{
   
    [[[UIManager sharedUIManager]topViewController] presentViewController:photo animated:YES completion:^{
        
    }];
}

-(void)introductionCamera:(UIImagePickerController *)camera {

    [[[UIManager sharedUIManager]topViewController] presentViewController:camera animated:YES completion:^{
        
    }];
}

-(void)transferPictures:(NSArray *)picturesArray{
    
    [_pictrArr removeAllObjects];
//    _picturesArray = nil;
//    if (picturesArray.count!=0) {
//        if ([picturesArray[0] isKindOfClass:[NSDictionary class]]) {
//            _picturesArray = picturesArray;
//            for (NSDictionary *dic in picturesArray) {
//                if ([dic[@"urlString"] isEqualToString:@""]) {
//                    [self.pictrArr addObject:dic[@"image"]];
//                }
//            }
//            
//        } else {
//            
            [self.pictrArr addObjectsFromArray:picturesArray];
//        }
    
        if ([self.delegate respondsToSelector:@selector(compressionAndTransferPicturesWithArray:)]) {
            [self.delegate compressionAndTransferPicturesWithArray:picturesArray];
        }
}

-(NSArray *)getSelectedPicktures{
    
    return _pictrArr;
}

-(void)emptyThePictureArray{

    [_pictrArr removeAllObjects];
}

//提交图片
- (void)compressionAndTransferPicturesIfErrorShowErrorMessageWithViewController:(UIViewController*)showView andType:(NSString *)type{
    
    _uploadImageNumber = 0; //每加载该方法一次纪录提交的图片次数重新赋予初始值
    [_fileArray removeAllObjects];
//    UIImage*imge;

    for (UIImage * image in _photoView.photoMenuItems) {
        //        处理图片
//        if ([img isKindOfClass:[ALAsset class]]) {
//            ALAsset*alasset = img;
//            imge = [UIImage imageWithCGImage:alasset.defaultRepresentation.fullScreenImage];
//        }else if([img isKindOfClass:[UIImage class]]){
        
//            imge = img;
        
//        } else {
        
//            UIImageView*imageView = (UIImageView*)img;
//            imge=imageView.image;
//        }
        UIImage * compression = [[Global sharedSingleton]compressImage:image];
        NSData *imageData = UIImageJPEGRepresentation(compression,1);
        
        NSString *str = [imageData base64EncodedString];
        NSLog(@"%@",str);
        NSString *file_type =@".jpg";   //图片类型
        NSDictionary * parameters = @{@"fileName" : file_type,
                                      @"imageBase64" : str
                                      };
        [[UserManager shareUserManager] submitImageWithParameters:parameters];
//        [UserManager shareUserManager] .submitFileSuccess = ^(id obj){
//            
//            if ([obj isKindOfClass:[SubmitFile class]]) {
//                SubmitFile *file = (SubmitFile *)obj;
//                NSString*url=file.url;
//                [self.fileArray addObject:url];
//            }
//            
//            _uploadImageNumber ++;
//            //  判断上传照片张数是否等于已选择的照片
//            if (_uploadImageNumber == _pictrArr.count) {
//                
//                [self judgePicturesUploadNumber];
//            }
//
//        };
    }
    
}

//判断上传照片成功的张数
- (void)judgePicturesUploadNumber {
    
    //如果上传图片张数与返回fileID数相等等说明照片上传成功
    if (_fileArray.count == _pictrArr.count) {
        
        if ([self.delegate respondsToSelector:@selector(submitPicturesDidFinishGetPictureUrlsWithUrlString:)]) {
            
            [self.delegate submitPicturesDidFinishGetPictureUrlsWithUrlString:[self mosaicString:_fileArray]];
        }

    } else { //否侧上传照片失败
        
        if (_failures > 2) { // 如果重新提交超过2次提示用户检查网络
            _failures = 0;
            [self tipsUserOperationMessage:[NSString stringWithFormat:@"%@", @"请检查网络"]];
            
        } else {  //否则提示用户是否重新上传照片
            _failures ++;
            [self tipsUserOperationFailedMessage: @"提交图片失败" andOperationMessage:  @"是否重新提交"];
        }
    }
    
}

//AlertView的按钮的事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) { // 点击取消
        
        [self.fileArray removeAllObjects];
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    }
    else { // 点击确定
        
        _failures ++;  //  纪录重复提交次数
        [self.fileArray removeAllObjects]; //将之前提交的图片fileId移除  重新提交
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
    }
    
    if ([self.delegate respondsToSelector:@selector(submitPicturesDidFinishBedefeatedOperationAgenTodelegateWithButtonIndex:)]) {
        [self.delegate submitPicturesDidFinishBedefeatedOperationAgenTodelegateWithButtonIndex:buttonIndex];
        
        // 点击确定由代理操作再一次提交图片
    }
}

//提示用户操作信息
- (void) tipsUserOperationMessage : (NSString*)tipsMessage
{
    UIAlertView *alert =
    [UIAlertView showWithTitle:@"提示"
                       message:tipsMessage
                         style:UIAlertViewStyleDefault
             cancelButtonTitle:@"确定"
             otherButtonTitles:nil
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex){
                          
                          if ([self.delegate respondsToSelector:@selector(submitPicturesDidFinishBedefeatedOperationAgenTodelegateWithButtonIndex:)]) {
                              [self.delegate submitPicturesDidFinishBedefeatedOperationAgenTodelegateWithButtonIndex:buttonIndex];
                          }
                          
                          
                      }];
    [alert show];
}

//提示用户操作失败信息  并是否再次操作
- (void) tipsUserOperationFailedMessage : (NSString*)tipsMessage
                    andOperationMessage : (NSString*)operationMessage {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:tipsMessage
                                                    message:operationMessage
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确认",nil];
    [alert show];
    
}

//拼接字符串
- (NSString *)mosaicString:(NSArray *)stringArr{

    //新提交的图片url拼接
    NSString*jsonString;
    for (NSString*json in stringArr) {
        
        if (!jsonString) {
            jsonString = [NSString stringWithFormat:@"%@",json];
        }else{
            jsonString=[NSString stringWithFormat:@"%@,%@",jsonString,json];
        }
    }
    
    //重新提交的原有图片url拼接
    if (_picturesArray.count != 0) {
        for (NSDictionary *dic in _picturesArray) {
            if (![dic[@"urlString"] isEqualToString:@""]) {
                if (!jsonString) {
                    jsonString = [NSString stringWithFormat:@"%@",dic[@"urlString"]];
                }else{
                    jsonString=[NSString stringWithFormat:@"%@,%@",jsonString,dic[@"urlString"]];
                }
            }
        }
    }
    
    return jsonString;
}

-(void)pushViewController:(UIViewController *)photo{
    
    [[UIManager getNavigationController] pushViewController:photo animated:YES];
}

@end
