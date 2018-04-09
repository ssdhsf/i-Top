//
//  ProtocolViewController.m
//  itop
//
//  Created by huangli on 2018/3/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ProtocolViewController.h"

@interface ProtocolViewController ()

@property (weak, nonatomic) IBOutlet UITextView *protocolTextView;
@property (strong, nonatomic) IBOutlet UILabel *protocolLabel;
@property (strong, nonatomic) IBOutlet UILabel *designerProtocolLabel;
@property (strong, nonatomic) IBOutlet UILabel *marktProtocolLabel;

@end

@implementation ProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initNavigationBarItems{
    
    self.title = @"入驻协议";
}

-(void)initData{
    
    [super initData];
    
    _protocolType = ProtocolTypeDesginer;
    
    NSArray *boldTextArray = [NSArray array];
    NSString *protocol = [NSString string];
    _protocolTextView.editable = NO;
    
    switch (_protocolType) {
            case ProtocolTypeDesginer:
            boldTextArray = @[@"i-Top设计师协议",
                              @"本服务条款是设计师与广东智合创享营销策划有限公司(下称i-Top)之间的协议。",
                              @"(一) 关于版权",
                              @"(二) 声明及保证",
                              @"(三) 合作期限",
                              @"(四) 签约流程",
                              @"(五) 模板审核",
                              @"(六) 佣金和定价",
                              @"(七) 双方权利和义务",
                              @"(八) 用户举报",
                              @"(九) 解除条款",
                              @"(十) 违约责任",
                              @"(十一) 其他"];
            protocol = _designerProtocolLabel.text;
            break;
            case ProtocolTypeCompany:
            boldTextArray = @[@"i-Top企业协议",
                              @"本服务条款是您与广东智合创享营销策划有限公司(下称i-Top)之间的协议。",
                              @"(一) 声明及保证",
                              @"(二) 企业服务申请流程",
                              @"(三) 企业服务内容",
                              @"(四) H5推广内容的审核",
                              @"(五) 双方权利和义务",
                              @"(六) 结算条款",
                              @"(七) 保密条款",
                              @"(八) 反商业贿赂条款",
                              @"(九) 其他"];
            protocol = _protocolLabel.text;
            break;
            case ProtocolTypeMarkting:
            boldTextArray = @[@"i-Top 自营销人协议",
                              @"本服务条款是自营销人与广东智合创享营销策划有限公司(下称i-Top)之间的协议。",
                              @"(一) 声明及保证",
                              @"(二) 合作期限",
                              @"(三) 签约流程",
                              @"(四) 佣金和定价",
                              @"(五) 双方权利和义务",
                              @"(六) 知识产权",
                              @"(七) 隐私政策",
                              @"(八) 解除条款",
                              @"(九) 其他"];
            protocol = _marktProtocolLabel.text;
            break;
        default:
            break;
    }
    
    NSRange range;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    //    paragraphStyle.firstLineHeadIndent = 20.0f;//首行缩进
    paragraphStyle.alignment = NSTextAlignmentLeft;//（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;//结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
    paragraphStyle.headIndent = 0;//整体缩进(首行除外)
    //    paragraphStyle.tailIndent = 20;//
    paragraphStyle.minimumLineHeight = 10;//最低行高
    paragraphStyle.maximumLineHeight = 10;//最大行高
    paragraphStyle.paragraphSpacing = 0;//段与段之间的间距
    paragraphStyle.paragraphSpacingBefore = 22.0f;//段首行空白空间/* Distance between the bottom of the previous paragraph (or the end of its paragraphSpacing, if any) and the top of this paragraph. */
    paragraphStyle.baseWritingDirection = NSLineBreakByClipping;//从左到右的书写方向（一共三种）
    paragraphStyle.lineHeightMultiple = 15;/* Natural line height is multiplied by this factor (if positive) before being constrained by minimum and maximum line height. */
    paragraphStyle.hyphenationFactor = 1;//连字属性 在iOS，唯一支持的值分别为0和1
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:protocol];
    
    for (int i = 0; i < boldTextArray.count ; i ++) {
        
        range = [protocol rangeOfString:boldTextArray[i]];
        
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                                     NSParagraphStyleAttributeName:paragraphStyle,
                                     
                                     };
        [attributedStr setAttributes:attributes range:range];
    }
    
    _protocolTextView.attributedText = attributedStr;
}

@end
