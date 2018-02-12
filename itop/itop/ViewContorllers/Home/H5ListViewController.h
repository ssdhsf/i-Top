//
//  H5ListViewController.h
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "BaseCollectionViewController.h"


typedef NS_ENUM(NSInteger, GetH5ListType) { //获取H5List入口
    GetH5ListTypeProduct = 0, //获取作品H5
    GetH5ListTypeTag = 1,//获取TagH5
};

@interface H5ListViewController : BaseCollectionViewController

@property (nonatomic, assign)H5ProductType h5ProductType;
@property (nonatomic, assign)TagH5ListType tagH5LisType;
@property (nonatomic, assign)GetH5ListType getH5ListType;
@property (nonatomic, strong)NSString * titleStr;

@end
