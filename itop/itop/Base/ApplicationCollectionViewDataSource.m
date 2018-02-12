//
//  BaseCollectionViewDataSource.m
//  itop
//
//  Created by huangli on 2018/1/17.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ApplicationCollectionViewDataSource.h"

@implementation ApplicationCollectionViewDataSource

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSString *)aCellIdentifier
             headerIdentifier:(NSString *)aheaderIdentifier
           cellConfigureBlock:(CollectionViewCellConfigureBlock)aConfigureBlock
 cellHeaderConfigureCellBlock:(CollectionViewCellHeaderConfigureBlock)acellHeaderConfigureCellBlock{
    
    self = [super init];
    
    if (self) {
        
        self.items = items;
        self.cellIdentifier = aCellIdentifier;
        self.headerIdentifier = aheaderIdentifier;
        self.configureCellBlock = [aConfigureBlock copy];
        self.cellHeaderConfigureCellBlock = [acellHeaderConfigureCellBlock copy];
    }
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.items[indexPath.section][indexPath.row];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.items.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *arr = self.items[section];
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item, indexPath);
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                           withReuseIdentifier:@"UICollectionViewHeader"
                                  forIndexPath:indexPath];
    
    self.cellHeaderConfigureCellBlock(headView,indexPath);
    return headView;
}

@end
