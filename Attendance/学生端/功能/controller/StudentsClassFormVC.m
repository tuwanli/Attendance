//
//  StudentsClassFormVC.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/15.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "StudentsClassFormVC.h"
#import "StudentFormDB.h"
#import "StudentFormCell.h"
#import "StudentClassWorkVC.h"

#import "StudentSignVC.h"
#import "StudentLeaveTabVC.h"
#import "StudentCheckSignVC.h"
#import "TeaReserWorkVC.h"
static NSString *StudentFormCell_identifer = @"StudentFormCell";
@interface StudentsClassFormVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@end

@implementation StudentsClassFormVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课程表";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    _dataArr = [[NSMutableArray alloc]init];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame)/2-25, CGRectGetWidth(self.view.frame)/2-25);
    flowLayout.minimumLineSpacing = 20;
    flowLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.frame), 60);
    flowLayout.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.frame), 20);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [_collectionView registerNib:[UINib nibWithNibName:@"StudentFormCell" bundle:nil] forCellWithReuseIdentifier:StudentFormCell_identifer];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerid"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerid"];
    [self.view addSubview:_collectionView];
    
    
    //从本地取
    NSMutableArray *tempArr1 = [[NSMutableArray alloc]init];
    NSMutableArray *tempArr2 = [[NSMutableArray alloc]init];
    NSMutableArray *tempArr3 = [[NSMutableArray alloc]init];
    NSMutableArray *tempArr4 = [[NSMutableArray alloc]init];
    NSMutableArray *tempArr5 = [[NSMutableArray alloc]init];
    NSArray *allArr = @[tempArr1,tempArr2,tempArr3,tempArr4,tempArr5];
    NSInteger userid =[[[NSUserDefaults standardUserDefaults]objectForKey:@"studen_id"]integerValue];
    NSArray *weekArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五"];
    [[StudentFormDB shareStudentForm]student_getFormData:tempArr1 studentId:userid weekId:1];//周一
    [[StudentFormDB shareStudentForm]student_getFormData:tempArr2 studentId:userid weekId:2];//周二
    [[StudentFormDB shareStudentForm]student_getFormData:tempArr3 studentId:userid weekId:3];//周三
    [[StudentFormDB shareStudentForm]student_getFormData:tempArr4 studentId:userid weekId:4];//周四
    [[StudentFormDB shareStudentForm]student_getFormData:tempArr5 studentId:userid weekId:5];//周五
    for (int i=0; i<5; i++) {
        NSDictionary *tempDict = @{@"name":weekArr[i],@"class":allArr[i]};
        [_dataArr addObject:tempDict];
    }
}
#pragma mark--UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return _dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *tempDict = _dataArr[section];
    return  [tempDict[@"class"]count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    StudentFormCell *cell = (StudentFormCell *)[collectionView dequeueReusableCellWithReuseIdentifier:StudentFormCell_identifer forIndexPath:indexPath];
    NSDictionary *tempDict = _dataArr[indexPath.section];
    FormModel *model = tempDict[@"class"][indexPath.item];
    cell.layer.borderColor = [UIColor colorWithRed:0 green:168/255.0 blue:1.0 alpha:1.0].CGColor;
    cell.layer.borderWidth = 1;
    cell.layer.cornerRadius = 10;
    cell.clipsToBounds = YES;
    [cell.classL setText:model.classname];
    [cell.timeL setText:model.startTime];
    [cell.teacherL setText:model.teacherName];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tempDict = _dataArr[indexPath.section];
    FormModel *model = tempDict[@"class"][indexPath.item];
    
    switch (_chooseIndex) {
        case 10:
        {
            StudentSignVC *signVc = [[StudentSignVC alloc]init];
            signVc.classname = model.classname;
            signVc.classId = 10*indexPath.section+indexPath.item;
            [self.navigationController pushViewController:signVc animated:YES];
        }
            break;
        case 11:
        {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            StudentLeaveTabVC *leavevc = [story instantiateViewControllerWithIdentifier:@"leave"];
            leavevc.classname = model.classname;
            leavevc.classId = 10*indexPath.section+indexPath.item;
            [self.navigationController pushViewController:leavevc animated:YES];
        }
            break;
        case 12://教师端
        {
            StudentCheckSignVC *checkvc = [[StudentCheckSignVC alloc]init];
            checkvc.hidesBottomBarWhenPushed = YES;
            checkvc.isteacher = YES;
            checkvc.classname = model.classname;
            checkvc.classId = 10*indexPath.section+indexPath.item;
            [self.navigationController pushViewController:checkvc animated:YES];
        }
            break;
        case 13://教师端
        {
            TeaReserWorkVC *workvc = [[TeaReserWorkVC alloc]init];
            workvc.hidesBottomBarWhenPushed = YES;
            workvc.isteacher = YES;
            workvc.classname = model.classname;
            workvc.classId = 10*indexPath.section+indexPath.item;
            [self.navigationController pushViewController:workvc animated:YES];
        }
            break;
        case 14://管理员
        {
            StudentClassWorkVC *workvc =[[StudentClassWorkVC alloc]init];
            workvc.classname = model.classname;
            workvc.classId = 10*indexPath.section+indexPath.item;
            workvc.isManager = YES;
            [self.navigationController pushViewController:workvc animated:YES];
        }
            break;
        default:
        {
            NSDictionary *tempDict = _dataArr[indexPath.section];
            FormModel *model = tempDict[@"class"][indexPath.item];
            StudentClassWorkVC *workvc =[[StudentClassWorkVC alloc]init];
            workvc.classname = model.classname;
            workvc.classId = [model.classId integerValue];
            [self.navigationController pushViewController:workvc animated:YES];
        }
            break;
    }
    
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerid" forIndexPath:indexPath];
        for (UIView *view in headerView.subviews) {
            [view removeFromSuperview];
        }
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, CGRectGetWidth(self.view.frame)-30, 40)];
        [titleLabel setTextColor:[UIColor darkGrayColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:16]];
        NSDictionary *tepDict = _dataArr[indexPath.section];
        
        [titleLabel setText:tepDict[@"name"]];
        [headerView addSubview:titleLabel];
        return headerView;
    }else{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerid" forIndexPath:indexPath];
        return footerView;
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
