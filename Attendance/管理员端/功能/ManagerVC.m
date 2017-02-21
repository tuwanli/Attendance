//
//  ManagerVC.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/14.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "ManagerVC.h"
#import "StudentCheckSignVC.h"
//#import "StudentChooseClassVC.h"
#import "StudentsClassFormVC.h"
#import "TeaDealLeaveVC.h"
#import "ManagerStuAccountVC.h"
@interface ManagerVC ()
@property (nonatomic, strong)NSMutableArray *managerArr;
@end

@implementation ManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createCollection];
    NSDictionary *tempDictOne = @{@"title":@"账号管理",@"iconName":@"就诊费用_icon",@"id":@"1"};
    NSDictionary *tempDictTwo = @{@"title":@"查询考勤",@"iconName":@"体检报告_icon",@"id":@"2"};
    NSDictionary *tempDicthree = @{@"title":@"请假信息管理",@"iconName":@"寻医_icon",@"id":@"3"};
    NSDictionary *tempDicfour = @{@"title":@"作业管理",@"iconName":@"预约挂号_icon",@"id":@"4"};
    
    _managerArr =[[NSMutableArray alloc]initWithObjects:tempDictOne,tempDictTwo,tempDicthree,tempDicfour,nil];
    [self createDataArr:_managerArr];
}
#pragma mark--UICollectionView
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tempdict = _managerArr[indexPath.item];
    NSInteger fundId = [tempdict[@"id"]integerValue];
    switch (fundId) {
        case 1://账号管理
        {
            
            ManagerStuAccountVC *managervc = [[ManagerStuAccountVC alloc]init];
            managervc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:managervc animated:YES];
        }
            break;
        case 2://查询考勤
        {
            StudentsClassFormVC *choosevc = [[StudentsClassFormVC alloc]init];
            choosevc.chooseIndex = 12;
            choosevc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:choosevc animated:YES];
            /*
            StudentChooseClassVC *choosevc = [[StudentChooseClassVC alloc]init];
            choosevc.chooseIndex = 12;
            choosevc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:choosevc animated:YES];*/
            
        }
            break;
        case 3://请假处理
        {
            TeaDealLeaveVC *dealVC = [[TeaDealLeaveVC alloc]init];
            dealVC.ismanager = YES;
            dealVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:dealVC animated:YES];
        }
            break;
        case 4://作业管理
        {
            /*
            StudentChooseClassVC *choosevc = [[StudentChooseClassVC alloc]init];
            choosevc.chooseIndex = 14;
            choosevc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:choosevc animated:YES];*/
            StudentsClassFormVC *choosevc = [[StudentsClassFormVC alloc]init];
            choosevc.chooseIndex = 14;
            choosevc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:choosevc animated:YES];
            
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
