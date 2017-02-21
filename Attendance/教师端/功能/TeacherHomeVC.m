//
//  TeacherHomeVC.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/14.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "TeacherHomeVC.h"
//#import "StudentChooseClassVC.h"
#import "StudentsClassFormVC.h"
#import "TeaDealLeaveVC.h"

@interface TeacherHomeVC ()
@property (nonatomic, strong)NSMutableArray *teacherArr;
@end

@implementation TeacherHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _teacherArr = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    
    [self createCollection];
    NSDictionary *tempDictOne = @{@"title":@"查询考勤",@"iconName":@"就诊费用_icon",@"id":@"1"};
    NSDictionary *tempDictTwo = @{@"title":@"布置作业",@"iconName":@"寻医_icon",@"id":@"2"};
    NSDictionary *tempDicthree = @{@"title":@"请假处理",@"iconName":@"预约挂号_icon",@"id":@"3"};
    
    NSMutableArray *tempArr =[[NSMutableArray alloc]initWithObjects:tempDictOne,tempDictTwo,tempDicthree,nil];
    [self createDataArr:tempArr];
    _teacherArr = tempArr;
}
#pragma mark--UICollectionView
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tempdict = _teacherArr[indexPath.item];
    NSInteger fundId = [tempdict[@"id"]integerValue];
    switch (fundId) {
        case 1://考勤
        {
            StudentsClassFormVC *choosevc = [[StudentsClassFormVC alloc]init];
            choosevc.chooseIndex = 12;
            choosevc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:choosevc animated:YES];
            /*
            StudentChooseClassVC *choosevc = [[StudentChooseClassVC alloc]init];
            choosevc.hidesBottomBarWhenPushed = YES;
            choosevc.chooseIndex = 12;
            [self.navigationController pushViewController:choosevc animated:YES];*/
            
        }
            break;
        case 2:
        {
            StudentsClassFormVC *choosevc = [[StudentsClassFormVC alloc]init];
            choosevc.chooseIndex = 13;
            choosevc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:choosevc animated:YES];
            /*
            StudentChooseClassVC *choosevc = [[StudentChooseClassVC alloc]init];
            choosevc.hidesBottomBarWhenPushed = YES;
            choosevc.chooseIndex = 13;
            [self.navigationController pushViewController:choosevc animated:YES];*/
            
        }
            break;
        case 3://请假处理
        {
            TeaDealLeaveVC *dealVC = [[TeaDealLeaveVC alloc]init];
            dealVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:dealVC animated:YES];
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
