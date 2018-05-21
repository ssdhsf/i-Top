//
//  ProvinceDataSource.m
//  itop
//
//  Created by huangli on 2018/4/1.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "ProvinceDataSource.h"
#import "ProvinceStore.h"

@implementation ProvinceDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSLog(@"%ld",self.items.count);
    return self.items.count;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    
    SelecteProvinceModel * model = self.items[indexPath.section];
    return model.letterProvince[indexPath.row];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    SelecteProvinceModel * model = self.items[section];
        return model.letterProvince.count;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return self.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item, indexPath);
    return cell;
}

//显示索引的图标
-(NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    UILabel *tipView = [[UILabel alloc] init];
    //self(自定义view).superview（控制器的根view）
    [[UIManager keyWindow] addSubview:tipView];
    tipView.text = [NSString stringWithFormat:@"%@",title];
    tipView.font=[UIFont systemFontOfSize:60];
    CGFloat tipH = 60;
    tipView .size = CGSizeMake(tipH, tipH);
    tipView.center = [UIManager keyWindow].center;
    tipView.backgroundColor = [UIColor clearColor];
    tipView.textAlignment = NSTextAlignmentCenter;
    
    //透明度
    tipView.alpha = 0;
    //圆角
    tipView.layer.cornerRadius = 5;
    tipView.layer.masksToBounds = YES; //剪裁超过bounds的部分
    
    //动画效果
    [UIView animateWithDuration:0.1 animations:^{
        tipView.alpha = 0.9;
    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
//            tipView.alpha = 0;
//        } completion:^(BOOL finished) {
            //从父view中移除
            [tipView removeFromSuperview];
//        }];
        
    }];
    
    return index;
}


@end
