//
//  H5ListDataSource.m
//  itop
//
//  Created by huangli on 2018/1/25.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "H5ListDataSource.h"

@implementation H5ListDataSource

- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.items[indexPath.row];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.items.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

@end
