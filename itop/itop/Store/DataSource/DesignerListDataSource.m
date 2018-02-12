//
//  DesignerListDataSource.m
//  itop
//
//  Created by huangli on 2018/1/24.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "DesignerListDataSource.h"

@implementation DesignerListDataSource


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
