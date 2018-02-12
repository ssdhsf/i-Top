//
//  DesignerListCell.h
//  itop
//
//  Created by huangli on 2018/1/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DesignerListViewCollectionViewCell;

typedef void (^FocusUserBlock) (NSInteger index , DesignerListViewCollectionViewCell*cell );

@interface DesignerListViewCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *designerImage;
@property (weak, nonatomic) IBOutlet UILabel *designerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *designerProfessionalLabel;
@property (weak, nonatomic) IBOutlet UIButton *focusButton;
@property (strong, nonatomic) FocusUserBlock focusUserBlock;

- (void)setItmeOfModel:(DesignerList*)designerList
      DesignerListType:(DesignerListType )designerListType
                 index:(NSInteger)index;

-(void)setupFocusStateWithhFocus:(BOOL)animation;
@end
