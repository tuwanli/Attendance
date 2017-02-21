//
//  BaseCollectionView.m
//  Attendance
//
//  Created by 孙云飞 on 2017/2/9.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "BaseCollectionView.h"
#import "BaseCollectionCell.h"
static NSString *base_cell= @"BaseCollectionCell";
@interface BaseCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>
@end
@implementation BaseCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{

    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        //背景色
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:base_cell bundle:nil] forCellWithReuseIdentifier:base_cell];
        //布局
        UICollectionViewFlowLayout *f = [[UICollectionViewFlowLayout alloc]init];
        f.itemSize = CGSizeMake(CGRectGetWidth(frame) / 2 - 15, CGRectGetWidth(frame) / 2 - 15);
        f.sectionInset = UIEdgeInsetsMake(10, 5, 0, 5);
        self.collectionViewLayout = f;
    }
    return self;
}

//数据的加载
- (void)setDataArray:(NSArray *)dataArray{

    _dataArray = dataArray;
    [self reloadData];
}

//代理
- (NSInteger)numberOfItemsInSection:(NSInteger)section{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    BaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:base_cell forIndexPath:indexPath];
    return cell;
}
@end
