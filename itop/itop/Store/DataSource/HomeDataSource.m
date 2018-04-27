//
//  HomeDataSource.m
//  itop
//
//  Created by huangli on 2018/1/26.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "HomeDataSource.h"
#import "HomeStore.h"
#import "HomeHeaderView.h"

@implementation HomeDataSource


-(id)itemAtIndexPath:(NSInteger)section{
    
        Home *home = (Home *)self.items[section];
        return home;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.items.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    Home *home = [self itemAtIndexPath:section];
    if (section <= 3){
        return 1;
    }
    return home.itemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = nil;
    Home *home = [self itemAtIndexPath:indexPath.section];
    if (indexPath.section <= 3) {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//        id item = home.itemArray[indexPath.row];
        self.configureCellBlock(cell, home.itemArray, indexPath);

    } else {
        if ([home.itemKey isEqualToString:Type_H5]) {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"H5List" forIndexPath:indexPath];
        } else if ([home.itemKey isEqualToString:Type_Home]){
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Home" forIndexPath:indexPath];
        }else {
            
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DesignerList" forIndexPath:indexPath];
        }
        
        id item = home.itemArray[indexPath.row];
        self.configureCellBlock(cell, item, indexPath);
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            
            HomeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                withReuseIdentifier:@"HeaderView"
                                                      forIndexPath:indexPath];
            reusableview = headerView;
        }else{
            UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                    withReuseIdentifier:@"UICollectionViewHeader"
                                                                                           forIndexPath:indexPath];
            
                        reusableview = headView;

        }
    }
    
    self.cellHeaderConfigureCellBlock(reusableview,indexPath);
    return reusableview;
}

@end
