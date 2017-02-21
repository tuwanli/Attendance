//
//  RootViewController.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/14.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "RootViewController.h"
#import "BaseCollectionCell.h"
static NSString *identifer_cell = @"BaseCollectionCell";
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createCollection];
}
- (void)createCollection
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 3 - 15, CGRectGetWidth(self.view.frame) / 3 );
    layout.minimumLineSpacing = 20;
    CGFloat height = (CGRectGetHeight(self.view.frame)-64-50)/2-10-(CGRectGetWidth(self.view.frame) / 3 - 15);//定死的两行计算
    layout.sectionInset = UIEdgeInsetsMake(height, 5, 0, 5);
   
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"BaseCollectionCell" bundle:nil] forCellWithReuseIdentifier:identifer_cell];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_collectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseCollectionCell *cell = (BaseCollectionCell*) [collectionView dequeueReusableCellWithReuseIdentifier:identifer_cell forIndexPath:indexPath];
    NSDictionary *tempDict = _dataArr[indexPath.item];
    [cell.nameLable setText:tempDict[@"title"]];
    [cell.iconImageView setImage:[UIImage imageNamed:tempDict[@"iconName"]]];
    
    return cell;
}
- (void)createDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    [_collectionView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
