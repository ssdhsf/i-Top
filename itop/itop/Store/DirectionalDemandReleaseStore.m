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
                                                        isEdit:(BOOL)isEdit{
  
    NSMutableArray *array = [NSMutableArray array];
    NSString *desginerName = [NSString string];
    NSString *productName = [NSString string];
    NSString *time = [NSString string];
    
    if (isEdit) {
        
     desginerName = [NSString stringWithFormat:@"%@",customRequirementsDetail.demand.designer_user_id];
     productName = [NSString stringWithFormat:@"%@",customRequirementsDetail.demand.demand_case_id];
        
        time = [[Global sharedSingleton]timeFormatTotimeStringFormatWithtime:customRequirementsDetail.demand.finish_datetime willPattern:TIME_PATTERN_second didPattern:TIME_PATTERN_day];
    }

    if (demandType == DemandTypeDirectional) {
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"设计师" content:desginerName sendKey:@"Designer_user_id" editType:EditTypeSelectItem pickViewType:PickViewTypeDesginer isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"参考案例" content:productName sendKey:@"Demand_case_id" editType:EditTypeSelectItem pickViewType:PickViewTypeProduct isMust:YES] ];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"预算" content:customRequirementsDetail.demand.price sendKey:@"Price" editType:EditTypeTextFied pickViewType:PickViewTypeEdit isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"活动名称" content:customRequirementsDetail.demand.title sendKey:@"Title" editType:EditTypeTextFied pickViewType:PickViewTypeEdit isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"行业" content:customRequirementsDetail.demand.trade sendKey:@"Trade" editType:EditTypeSelectItem pickViewType:PickViewTypeIndustry isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"截稿时间" content:time sendKey:@"Finish_datetime" editType:EditTypeSelectTime pickViewType:PickViewTypeDate isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"联系人" content:customRequirementsDetail.demand.contact_name sendKey:@"Contact_name" editType:EditTypeTextFied pickViewType:PickViewTypeEdit isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"电话" content:customRequirementsDetail.demand.contact_phone sendKey:@"Contact_phone" editType:EditTypeTextFied pickViewType:PickViewTypeEdit isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"需求" content:customRequirementsDetail.demand.descrip sendKey:@"Description" editType:EditTypeTextView pickViewType:PickViewTypeEdit isMust:YES]];

    } else{
        
        NSString *provinceString = [NSString stringWithFormat:@"%@,%@",customRequirementsDetail.demand.province,customRequirementsDetail.demand.city];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"活动名称" content:customRequirementsDetail.demand.title sendKey:@"Title" editType:EditTypeTextFied pickViewType:PickViewTypeEdit isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"预算" content:customRequirementsDetail.demand.price sendKey:@"Price" editType:EditTypeTextFied pickViewType:PickViewTypeEdit isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"行业" content:customRequirementsDetail.demand.trade sendKey:@"Trade" editType:EditTypeSelectItem pickViewType:PickViewTypeIndustry isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"截稿时间" content:time sendKey:@"Finish_datetime" editType:EditTypeSelectTime pickViewType:PickViewTypeDate isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"参考网站" content:customRequirementsDetail.demand.reference_url sendKey:@"Reference_url" editType:EditTypeTextFied pickViewType:PickViewTypeEdit isMust:NO]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"参考图片" content:customRequirementsDetail.demand.reference_img sendKey:@"Reference_img" editType:EditTypeSelectImage pickViewType:PickViewTypePicture isMust:NO]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"地域优先" content:provinceString sendKey:@"" editType:EditTypeSelectItem pickViewType:PickViewTypeProvince isMust:NO]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"联系人" content:customRequirementsDetail.demand.contact_name sendKey:@"Contact_name" editType:EditTypeTextFied pickViewType:PickViewTypeEdit isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"电话" content:customRequirementsDetail.demand.contact_phone sendKey:@"Contact_phone" editType:EditTypeTextFied pickViewType:PickViewTypeEdit isMust:YES]];
        [array addObject:[self setupDemandEditWithDemandEditTitle:@"需求" content:customRequirementsDetail.demand.descrip sendKey:@"Description" editType:EditTypeTextView pickViewType:PickViewTypeEdit isMust:YES] ];
    }
        return array;
}

-(DemandEdit *)setupDemandEditWithDemandEditTitle:(NSString *)title
                                            content:(NSString *)content
                                            sendKey:(NSString *)sendKey
                                       editType:(EditType)editType
                                         pickViewType:(PickViewType)pickViewType
                                           isMust:(BOOL)isMust{
    
    DemandEdit *demand = [[DemandEdit alloc]init];
    demand.title = title;
    demand.content = content;
    demand.sendKey = sendKey;
    demand.editType = editType;
    demand.isMust = isMust;
    demand.pickViewType = pickViewType;
    return demand;
}

- (NSMutableArray *)configurationCaseWitiCaseDetail:(CaseDetail *)caseDetail
                                             isEdit:(BOOL)isEdit{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[self setupDemandEditWithDemandEditTitle:@"作品名称" content:caseDetail ? caseDetail.info.title : nil sendKey:@"Title" editType:EditTypeTextFied pickViewType:PickViewTypeEdit isMust:YES]];
      [array addObject:[self setupDemandEditWithDemandEditTitle:@"案例客户" content:caseDetail ? caseDetail.info.customer_name : nil sendKey:@"Customer_name" editType:EditTypeTextFied pickViewType:PickViewTypeEdit isMust:YES]];
      [array addObject:[self setupDemandEditWithDemandEditTitle:@"价格" content:caseDetail ? caseDetail.info.price : nil sendKey:@"Price" editType:EditTypeTextFied pickViewType:PickViewTypeEdit isMust:YES]];
      [array addObject:[self setupDemandEditWithDemandEditTitle:@"案例封面" content:caseDetail ? caseDetail.info.cover_img : nil sendKey:@"Cover_img" editType:EditTypeSelectImage pickViewType:PickViewTypeEdit isMust:YES]];
      [array addObject:[self setupDemandEditWithDemandEditTitle:@"案例链接" content:caseDetail ? caseDetail.info.case_url : nil sendKey:@"Case_url" editType:EditTypeTextFied pickViewType:PickViewTypeEdit isMust:YES]];
      [array addObject:[self setupDemandEditWithDemandEditTitle:@"网盘地址" content:caseDetail ? caseDetail.info.url : nil sendKey:@"Url" editType:EditTypeTextFied pickViewType:PickViewTypeEdit isMust:YES]];
      [array addObject:[self setupDemandEditWithDemandEditTitle:@"案例介绍" content:caseDetail ? caseDetail.info.descrip : nil sendKey:@"Description" editType:EditTypeTextView pickViewType:PickViewTypeEdit isMust:YES]];
    return array;
}

@end
