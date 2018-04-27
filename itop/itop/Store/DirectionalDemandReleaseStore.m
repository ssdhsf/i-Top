//
//  DirectionalDemandReleaseStore.m
//  itop
//
//  Created by huangli on 2018/4/22.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DirectionalDemandReleaseStore.h"

@implementation DirectionalDemandReleaseStore

+ (instancetype)shearDirectionalDemandReleaseStore{
    
    static DirectionalDemandReleaseStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[DirectionalDemandReleaseStore alloc]init];
    });
    return store;
}

- (NSMutableArray *)configurationDirectionalDemandReleaseEditWithDemandType:(DemandType )demandType
                                                   customRequirementsDetail:(CustomRequirementsDetail *)customRequirementsDetail
                                                               desginerList:(NSArray *)desginerList
                                                        desginerProductList:(NSArray *)desginerProductList
                                                                   province:(Province *)province
                                                                       city:(Province *)city
                                                                     isEdit:(BOOL)isEdit{
  
    NSMutableArray *array = [NSMutableArray array];
    NSString *desginerName = [NSString string];
    NSString *productName = [NSString string];
    NSString *time = [NSString string];
    
    if (isEdit) {
        
        for (DesignerList *desgin in desginerList) {
            
            if ([desgin.id isEqualToNumber:customRequirementsDetail.demand.designer_user_id]) {
                desginerName = desgin.nickname ;
            }
        }
        
        for (H5List *h5 in desginerProductList) {
            
            if ([h5.id  isEqualToNumber:customRequirementsDetail.demand.demand_case_id]) {
                productName = h5.title ;
            }
        }
        
        time = [[Global sharedSingleton]timeFormatTotimeStringFormatWithtime:customRequirementsDetail.demand.finish_datetime willPattern:TIME_PATTERN_second didPattern:TIME_PATTERN_day];
        
    }

    if (demandType == DemandTypeDirectional) {
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"设计师" content:desginerName sendKey:@"Designer_user_id" editType:EditTypeSelectItem isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"参考案例" content:productName sendKey:@"Demand_case_id" editType:EditTypeSelectItem isMust:YES] ];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"预算" content:customRequirementsDetail.demand.price sendKey:@"Price" editType:EditTypeTextFied isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"活动名称" content:customRequirementsDetail.demand.title sendKey:@"Title" editType:EditTypeTextFied isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"行业" content:customRequirementsDetail.demand.trade sendKey:@"Trade" editType:EditTypeSelectItem isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"截稿时间" content:time sendKey:@"Finish_datetime" editType:EditTypeSelectTime isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"联系人" content:customRequirementsDetail.demand.contact_name sendKey:@"Contact_name" editType:EditTypeTextFied isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"电话" content:customRequirementsDetail.demand.contact_phone sendKey:@"Contact_phone" editType:EditTypeTextFied isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"需求" content:customRequirementsDetail.demand.descrip sendKey:@"Description" editType:EditTypeTextView isMust:YES]];

    } else{
        
        NSString *provinceString = [NSString string];

        if (province !=  nil ) {
            
            provinceString = [NSString stringWithFormat:@"%@,%@",province.address,city.address];
        }

        [array addObject:[self setupDemandEditWithDemandEditTitle:@"活动名称" content:customRequirementsDetail.demand.title sendKey:@"Title" editType:EditTypeTextFied isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"预算" content:customRequirementsDetail.demand.price sendKey:@"Price" editType:EditTypeTextFied isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"行业" content:customRequirementsDetail.demand.trade sendKey:@"Trade" editType:EditTypeSelectItem isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"截稿时间" content:time sendKey:@"Finish_datetime" editType:EditTypeSelectTime isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"参考网站" content:customRequirementsDetail.demand.reference_url sendKey:@"Reference_url" editType:EditTypeTextFied isMust:NO]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"参考图片" content:customRequirementsDetail.demand.reference_img sendKey:@"Reference_img" editType:EditTypeSelectImage isMust:NO]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"地域优先" content:provinceString sendKey:@"" editType:EditTypeSelectItem isMust:NO]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"联系人" content:customRequirementsDetail.demand.contact_name sendKey:@"Contact_name" editType:EditTypeTextFied isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"电话" content:customRequirementsDetail.demand.contact_phone sendKey:@"Contact_phone" editType:EditTypeTextFied isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"需求" content:customRequirementsDetail.demand.descrip sendKey:@"Description" editType:EditTypeTextView isMust:YES] ];
    }
        return array;
}

-(DemandEdit *)setupDemandEditWithDemandEditTitle:(NSString *)title
                                            content:(NSString *)content
                                            sendKey:(NSString *)sendKey
                                       editType:(EditType)editType
                                           isMust:(BOOL)isMust{
    
    DemandEdit *demand = [[DemandEdit alloc]init];
    demand.title = title;
    demand.content = content;
    demand.sendKey = sendKey;
    demand.editType = editType;
    demand.isMust = isMust;
    return demand;
}

@end
