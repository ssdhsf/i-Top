//
//  DesignerList.h
//  itop
//
//  Created by huangli on 2018/1/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DesignerList : JSONModel

//测试字段
@property (nonatomic, strong) NSString <Optional>*designerImageUrl;
@property (nonatomic, strong) NSString <Optional>*designerName;
@property (nonatomic, strong) NSString <Optional>*designerProfessional;

@property (nonatomic, strong) NSNumber <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*head_img;
@property (nonatomic, strong) NSString <Optional>*nickname;
@property (nonatomic, strong) NSString <Optional>*level;
@property (nonatomic, strong) NSString <Optional>*field;//一般显示
@property (nonatomic, strong) NSNumber <Optional>*follow;
@property (nonatomic, strong) NSString <Optional>*follow_user_id;
@property (nonatomic, strong) NSString <Optional>*user_type;//用户类型，关注查询显示


//"id": 26,
//"head_img": "",
//"nickname": "普通用户117717",
//"level": 0,
//"field": "企业宣传,企业招聘,产品介绍,促销活动"
@end
