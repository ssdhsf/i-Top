//
//  ProductTag.h
//  itop
//
//  Created by huangli on 2018/2/10.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ProductTag : JSONModel

@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*product_id;
@property (nonatomic, strong) NSString <Optional>*name;

//                            "id": 0,
    //                            "product_id": 0,
    //                            "name": "string"
    //                        }

@end
