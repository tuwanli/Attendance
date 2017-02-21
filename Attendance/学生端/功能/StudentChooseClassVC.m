//
//  StudentSignVC.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/15.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "StudentChooseClassVC.h"
#import "StudentSignCell.h"
#import "StudentSignVC.h"
#import "StudentLeaveTabVC.h"
#import "CurriculumDB.h"
#import "StudentCheckSignVC.h"
#import "TeaReserWorkVC.h"
#import "StudentClassWorkVC.h"
static NSString *studentSignCell_identifer = @"StudentSignCell";
@interface StudentChooseClassVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@end

@implementation StudentChooseClassVC

- (instancetype)init
{

    if (self = [super init]) {
        _dataArr = [[NSMutableArray alloc]init];
        NSMutableArray *tempArr = [NSMutableArray new];
//        NSInteger userid = [[[NSUserDefaults standardUserDefaults]objectForKey:@"studen_id"]integerValue];
        [[CurriculumDB shareStudentCurriculum]student_getCurrData:tempArr];
        _dataArr = tempArr;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"选择课程";
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //    layout
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 2 - 33, 40);
    layout.minimumLineSpacing = 20;
    
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.frame), 60);
    layout.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.frame), 20);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"StudentSignCell" bundle:nil] forCellWithReuseIdentifier:studentSignCell_identifer];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerid"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerid"];
    [self.view addSubview:_collectionView];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return _dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CurriculumModel *model = _dataArr[section];
    NSArray *classNameArr = [model.classname componentsSeparatedByString:@","];
    return classNameArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StudentSignCell *cell = (StudentSignCell *)[collectionView dequeueReusableCellWithReuseIdentifier:studentSignCell_identifer forIndexPath:indexPath];
    CurriculumModel *model = _dataArr[indexPath.section];
    NSArray *classNameArr = [model.classname componentsSeparatedByString:@","];
    [cell.classL setText:classNameArr[indexPath.item]];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerid" forIndexPath:indexPath];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40)];
        [titleLabel setTextColor:[UIColor darkGrayColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:16]];
        [titleLabel setBackgroundColor:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0]];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        CurriculumModel *model = _dataArr[indexPath.section];
        [titleLabel setText:model.Curriculumname];
        [headerView addSubview:titleLabel];
        return headerView;
    }else{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerid" forIndexPath:indexPath];
        return footerView;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CurriculumModel *model = _dataArr[indexPath.section];
    NSArray *classNameArr = [model.classname componentsSeparatedByString:@","];
    switch (_chooseIndex) {
        case 10:
        {
            StudentSignVC *signVc = [[StudentSignVC alloc]init];
            signVc.classname = classNameArr[indexPath.item];
            signVc.classId = 10*indexPath.section+indexPath.item;
            [self.navigationController pushViewController:signVc animated:YES];
        }
            break;
        case 11:
        {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            StudentLeaveTabVC *leavevc = [story instantiateViewControllerWithIdentifier:@"leave"];
            leavevc.classname = classNameArr[indexPath.item];
            leavevc.classId = 10*indexPath.section+indexPath.item;
            [self.navigationController pushViewController:leavevc animated:YES];
        }
            break;
        case 12://教师端
        {
            StudentCheckSignVC *checkvc = [[StudentCheckSignVC alloc]init];
            checkvc.hidesBottomBarWhenPushed = YES;
            checkvc.isteacher = YES;
            checkvc.classname = classNameArr[indexPath.item];
            checkvc.classId = 10*indexPath.section+indexPath.item;
            [self.navigationController pushViewController:checkvc animated:YES];
        }
            break;
        case 13://教师端
        {
            TeaReserWorkVC *workvc = [[TeaReserWorkVC alloc]init];
            workvc.hidesBottomBarWhenPushed = YES;
            workvc.isteacher = YES;
            workvc.classname = classNameArr[indexPath.item];
            workvc.classId = 10*indexPath.section+indexPath.item;
            [self.navigationController pushViewController:workvc animated:YES];
        }
            break;
        case 14://管理员
        {
            StudentClassWorkVC *workvc =[[StudentClassWorkVC alloc]init];
            workvc.classname = classNameArr[indexPath.item];
            workvc.classId = 10*indexPath.section+indexPath.item;
            workvc.isManager = YES;
            [self.navigationController pushViewController:workvc animated:YES];
        }
            break;
        default:
            break;
    }
    
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
