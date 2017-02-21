//
//  RootViewController.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/14.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArr;
- (void)createCollection;
- (void)createDataArr:(NSMutableArray *)dataArr;
@end
