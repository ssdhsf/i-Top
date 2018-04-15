//
//  ZBShareMenuView.m
//  MessageDisplay
//
//  Created by zhoubin@moshi on 14-5-13.
//  Copyright (c) 2014年 Crius_ZB. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "MessagePhotoView.h"
#import "ZYQAssetPickerController.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import "MSSCollectionViewCell.h"
#import "PYNavigationController.h"
#import "OrganizationManagement.h"
#import "MSSBrowseDefine.h"

//#import "NofirstTimeAttendancesViewController.h"

// 每行有4个
#define kZBMessageShareMenuPerRowItemCount 4
#define kZBMessageShareMenuPerColum 2

#define kZBShareMenuItemIconSize 60
#define KZBShareMenuItemHeight 80

#define MaxItemCount 3
#define ItemWidth 72
#define ItemHeight 72

#define IMAGE_KEY @"image"

@interface MessagePhotoView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIViewControllerTransitioningDelegate,MSSBrowseBaseViewDelegate>{
    
}

@property (nonatomic, weak) UIButton *btnviewphoto;
@property (nonatomic, assign) BOOL requetUrlImage;

@property (nonatomic,strong)UICollectionView *collectionView;

@end

@implementation MessagePhotoView

@synthesize photoMenuItems;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (NSMutableArray *)urlImage{
    
    if (!_urlImage) {
        _urlImage = [NSMutableArray array];
    }
    return _urlImage;
}

- (NSMutableArray *)browsePicturesArray{
    
    if (!_browsePicturesArray) {
       self.browsePicturesArray = [NSMutableArray array];
    }
    return _browsePicturesArray;
}

- (void)setup{
//
    photoMenuItems = [NSMutableArray array];
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
//    flowLayout.minimumLineSpacing = 0;
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
//    flowLayout.itemSize = CGSizeMake(self.size.height, self.size.height);
//    flowLayout.minimumLineSpacing = 0;
//    
//    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:flowLayout];
//    _collectionView.delegate = self;
//    _collectionView.dataSource = self;
//    _collectionView.backgroundColor = [UIColor clearColor];
//    //cell注册
//    [_collectionView registerClass:[MSSCollectionViewCell class] forCellWithReuseIdentifier:@"MSSCollectionViewCell"];
//    [self addSubview:_collectionView];
//    [_collectionView reloadData];
//    
//    _requetUrlImage=YES;
//    self.backgroundColor = [UIColor colorWithRed:248.0f/255 green:248.0f/255 blue:255.0f/255 alpha:1.0];
//    
//    if (self.photoMenuItems.count < 3 && !_isBrowsePictures) {
//        UIImage *image = [UIImage imageNamed:@"signin_cam"];
//        [self.photoMenuItems addObject:image];
//    }
//    
//    [_collectionView reloadData];
}

//通过拍摄
- (void)reloadDataWithImage:(UIImage *)image{
    
//    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ItemWidth, ItemWidth)];
//    img.image = image;
    [photoMenuItems removeAllObjects];
    [photoMenuItems addObject:image];
//
//    if (_urlImage.count!=0) {
//          NSDictionary*dic = [NSDictionary dictionaryWithObjectsAndKeys: @"", @"urlString",img, IMAGE_KEY,nil];
//        [self.photoMenuItems insertObject:dic atIndex:self.photoMenuItems.count-1];
//        
//    }else{
//        [self.photoMenuItems insertObject:img atIndex:self.photoMenuItems.count-1];
//    }
    [_collectionView reloadData];
    [self delegateRespondsToSelector];
}

////重新编辑选择的图片
//- (void)urlToPictre{
//    
//    for (int i=0; i<_urlImage.count; i++) {
//        UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ItemWidth, ItemWidth)];
//        NSDictionary*dic2=_urlImage[i];
//        NSString*urlStr=dic2[@"file_url"];
//        img = [RequestDataManager RequestPictureWithUrl:urlStr placeholderImage:PlaceholderImageselection andImageView:img];
//        NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:urlStr, @"urlString",img,IMAGE_KEY, nil];
//        [self.photoMenuItems insertObject:dic atIndex:self.photoMenuItems.count-1];
//    }
//}

- (void)collectionViewReloadData{
    
//    if (_urlImage.count!=0) {
//        if (_requetUrlImage) {
//            [self urlToPictre];
//        }
//    }
    [_collectionView reloadData];
}

- (void)browsePicturesWithPictureArray:(NSArray *)pictureArray{
    
    NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
//    int i = 0;
//    for(i = 0;_isBrowsePictures ? i < [self.photoMenuItems count] : i < [self.photoMenuItems count] -1;i++)
//    {
//        UIImageView *imageView = [self viewWithTag:i + 100];
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        //        browseItem.bigImageLocalPath 建议传本地图片的路径来减少内存使用
        browseItem.bigImage = [photoMenuItems lastObject] ;// 大图赋值
//        browseItem.smallImageView = imageView;// 小图
        [browseItemArray addObject:browseItem];
//    }
//    MSSCollectionViewCell *cell = (MSSCollectionViewCell *)[_collectionView cellForItemAtIndexPath:0];
    MSSBrowseLocalViewController *bvc = [[MSSBrowseLocalViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:0];
    bvc.delegate = self;
    bvc.isBrowsePictures = _isBrowsePictures;
    if ( _isBrowsePictures ) {
        
        [bvc showBrowseViewController];
        
    } else {
        
        PYNavigationController *nav = [[PYNavigationController alloc] initWithRootViewController:bvc];
        
        [[UIManager getNavigationController] presentViewController:nav animated:NO completion:^{
            
        }];
        
    }

//    [self.photoMenuItems removeAllObjects];
//    [self.photoMenuItems addObjectsFromArray:pictureArray];
//    [_collectionView reloadData];
}

- (void)openMenu{
    
    completion_organization _completion = ^(NSString *organization_name){
        
        if ([organization_name isEqualToString:@"打开照相机"]) {
            
            [self takePhoto];
        } else {
            
            [self localPhoto];
        }
    };
    
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithObjects:@"打开照相机",@"从手机相册获取",nil];
    [[OrganizationManagement sharedOrganizationManagement]selectObjWithObjTitleArray:titleArray currentObj:nil title:nil Completion:_completion];
}

//开始拍照
- (void)takePhoto{

    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        if ([self.delegate respondsToSelector:@selector(introductionCamera:)]) {
            [self.delegate introductionCamera:picker];
        }
        
        if (![self JudgeAppWhetherAccessCamera]) {
            [self tipsUserOperationMessage:[NSString stringWithFormat:@"相机访问受限\n请打开设置-隐私－相机,允许i-Top访问您的相机。"]];
        }
    
    }else{
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

/*
 *  打开相册，可以多选，选择张数通过count自定义
 */

- (void)localPhoto{
    
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc]init];
//    选择照片张数
    if ([_howMany isEqualToString:@"1"]) {
        
        picker.maximumNumberOfSelection = 1;
    }else{
        picker.maximumNumberOfSelection = 4 - photoMenuItems.count;
    }
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject,NSDictionary *bindings){
        if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType]isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration]doubleValue];
            return duration >= 5;
        }else{
            return  YES;
        }
    }];
    [self.delegate introductionPhoto:picker];
}

/*
 从相册中得到选中的图片
 */
#pragma mark - ZYQAssetPickerController Delegate

-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    for (ALAsset *asset in assets) {
        UIImage*image=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
//        UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ItemWidth, ItemWidth)];
//        img.image = image;
        [photoMenuItems removeAllObjects];
        [photoMenuItems addObject:image];
//        if (_urlImage.count!=0) {
//            NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys: @"", @"urlString",img, IMAGE_KEY,nil];
//            [self.photoMenuItems insertObject:dic atIndex:self.photoMenuItems.count - 1];
//        } else {
//            
//            [self.photoMenuItems insertObject:image atIndex:self.photoMenuItems.count - 1];
//        }
    }
    
    [_collectionView reloadData];
    [self delegateRespondsToSelector];
}


//拍摄照片之后

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if([type isEqualToString:@"public.image"]){
        //先把图片转成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self reloadDataWithImage:image];
       
        //保存图片到相册
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//            NSData *datas;
//            if(UIImagePNGRepresentation(image)==nil){
//                datas = UIImageJPEGRepresentation(image, 0.6);
//            }else{
//                datas = UIImagePNGRepresentation(image);
//            }
//            
//            //        图片保存的路径
//            //        这里将图片放在沙盒的documents文件夹中
//            NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//            //        文件管理器
//            NSFileManager *fileManager = [NSFileManager defaultManager];
//            ////        把刚才图片转换的data对象拷贝至沙盒中,并保存为image.png
//            [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
//            [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:datas attributes:nil];
//            //        得到选择后沙盒中图片的完整路径
//            filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,@"/image.png"];
//
//        
//        });
        
    }
}
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    UIAlertView *alert;
    
    if (error)
    {
        NSLog(@"%@",@"保存失败");
//        alert = [[UIAlertView alloc] initWithTitle:@"错误"
//                                           message:@"保存失败"
//                                          delegate:self cancelButtonTitle:@"确定"
//                                 otherButtonTitles:nil];
    }
    else
    {
        NSLog(@"%@",@"保存成功");
//        alert = [[UIAlertView alloc] initWithTitle:@"成功"
//                                           message:@"保存成功"
//                                          delegate:self cancelButtonTitle:@"确定"
//                                 otherButtonTitles:nil];
    }
    [alert show];
}

//取消选择
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//判断APP是否获得相机相册的访问权限
- (BOOL)JudgeAppWhetherAccessCamera{
    NSString *mada = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mada];
    if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
        NSLog(@"相机权限受限");
        return NO;
    
    } else {
        return YES;
    }
}

//提示用户允许app访问相机
- (void) tipsUserOperationMessage : (NSString*)tipsMessage
{
    UIAlertView *alert = [UIAlertView showWithTitle:@"提示"
                                            message:tipsMessage
                                              style:UIAlertViewStyleDefault
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil
                                           tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex){
                                           }];
    [alert show];
    
}

#pragma mark - ShowBigViewControllerDelegate

- (void)deleteImageIndex:(NSInteger)index{
    
    [self.photoMenuItems removeObjectAtIndex:index];
    [self delegateRespondsToSelector];
    [_collectionView reloadData];

}

- (void)delegateRespondsToSelector {
    
    if ([self.delegate respondsToSelector:@selector(transferPictures:)]) {
        
//        [self.delegate transferPictures: [self.photoMenuItems subarrayWithRange:NSMakeRange(0, self.photoMenuItems.count-1)]];
        [self.delegate transferPictures:photoMenuItems];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.photoMenuItems.count > 3) {
        
        return self.photoMenuItems.count - 1;
    } else {
        
        return self.photoMenuItems.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSSCollectionViewCell" forIndexPath:indexPath];
    if (cell) {
        
        if ([self.photoMenuItems[indexPath.row] isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dic = self.photoMenuItems[indexPath.row];
            UIImageView *imageView = dic[IMAGE_KEY];
            cell.imageView.image = imageView.image;
        
        } else if ([self.photoMenuItems[indexPath.row] isKindOfClass:[NSString class]]){
            
//          [RequestDataManager RequestPictureWithUrl:self.photoMenuItems[indexPath.row] placeholderImage:PlaceholderImageselection andImageView:cell.imageView];
            
        } else if ([self.photoMenuItems[indexPath.row] isKindOfClass:[UIImageView class]]){
            
            UIImageView *view = self.photoMenuItems[indexPath.row];
            cell.imageView.image = view.image;

        }else {
          
            cell.imageView.image = self.photoMenuItems[indexPath.row];
        }
        cell.imageView.tag = indexPath.row + 100;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.clipsToBounds = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    //选择 图片

    if (self.photoMenuItems.count < 4 && indexPath.row == self.photoMenuItems.count - 1 && !_isBrowsePictures) {
        
         [self openMenu];
        
    } else {  //浏览图片
    
//        // 加载网络图片
//            NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
//            int i = 0;
//            for(i = 0;i < [self.photoMenuItems count];i++)
//            {
//                UIImageView *imageView = [self viewWithTag:i + 100];
//                MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
//        //        browseItem.bigImageUrl = bigUrlArray[i];// 加载网络图片大图地址
//                browseItem.smallImageView = imageView;// 小图
//                [browseItemArray addObject:browseItem];
//            }
//            MSSCollectionViewCell *cell = (MSSCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
//            MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:cell.imageView.tag - 100];
//            //    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
//            [bvc showBrowseViewController];
      // 加载本地图片
        NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
        int i = 0;
        for(i = 0;_isBrowsePictures ? i < [self.photoMenuItems count] : i < [self.photoMenuItems count] -1;i++)
        {
            UIImageView *imageView = [self viewWithTag:i + 100];
            MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
    //        browseItem.bigImageLocalPath 建议传本地图片的路径来减少内存使用
            browseItem.bigImage = imageView.image;// 大图赋值
            browseItem.smallImageView = imageView;// 小图
            [browseItemArray addObject:browseItem];
        }
        MSSCollectionViewCell *cell = (MSSCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
        MSSBrowseLocalViewController *bvc = [[MSSBrowseLocalViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:cell.imageView.tag - 100];
        bvc.delegate = self;
        bvc.isBrowsePictures = _isBrowsePictures;
        if ( _isBrowsePictures ) {
            
            [bvc showBrowseViewController];
            
        } else {
           
            PYNavigationController *nav = [[PYNavigationController alloc] initWithRootViewController:bvc];
            
            [[UIManager getNavigationController] presentViewController:nav animated:NO completion:^{
                
            }];

        }
    }
}


@end
