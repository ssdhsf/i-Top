//
//  DesignerInfo.h
//  itop
//
//  Created by huangli on 2018/2/3.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DesignerInfo : JSONModel

@property (nonatomic, strong) NSString <Optional>*nickname;
@property (nonatomic, strong) NSString <Optional>*head_img;
@property (nonatomic, strong) NSString <Optional>*level;
@property (nonatomic, strong) NSString <Optional>*sale_total;
@property (nonatomic, strong) NSString <Optional>*field;
@property (nonatomic, strong) NSString <Optional>*follow_total;
@property (nonatomic, strong) NSString <Optional>*fans_total;
@property (nonatomic, strong) NSNumber <Optional>*follow;
@property (nonatomic, strong) NSNumber <Optional>*user_id;




//"head_img": "http://192.168.7.100:8028/files/img/20180129/201801291921400799.png",
//"nickname": "普通用户188888",
//"level": 0,
//"field": "企业宣传",
//"sale_total": 8,
//"fans_total": 8,
//"follow_total": 2,
//"follow": false

@end
