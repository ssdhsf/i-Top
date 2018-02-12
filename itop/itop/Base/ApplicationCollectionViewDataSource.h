//
//  BaseCollectionViewDataSource.h
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CollectionViewCellConfigureBlock)(id cell, id data, id indexPath);
typedef void (^CollectionViewCellHeaderConfigureBlock)(id headView, id indexPath);

@interface ApplicationCollectionViewDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, copy) CollectionViewCellConfigureBlock configureCellBlock;
@property (nonatomic, copy) CollectionViewCellHeaderConfigureBlock cellHeaderConfigureCellBlock;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) NSString *headerIdentifier;

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSString *)aCellIdentifier
             headerIdentifier:(NSString *)aheaderIdentifier
           cellConfigureBlock:(CollectionViewCellConfigureBlock)aConfigureBlock
           cellHeaderConfigureCellBlock:(CollectionViewCellHeaderConfigureBlock)acellHeaderConfigureCellBlock;

-(id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
