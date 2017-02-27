//
//  SFunctionVC.m
//  Attendance
//
//  Created by 孙云飞 on 2017/2/9.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "SFunctionVC.h"
//#import "StudentChooseClassVC.h"
#import "StudentCheckSignVC.h"
#import "StudentFormDB.h"
#import "StudentsClassFormVC.h"
@interface SFunctionVC ()
@property (nonatomic, strong)NSMutableArray *studentArr;
@end

@implementation SFunctionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createCollection];
    NSDictionary *tempDictOne = @{@"title":@"考勤",@"iconName":@"健康档案_icon",@"id":@"1"};
    NSDictionary *tempDictTwo = @{@"title":@"查询课表",@"iconName":@"健康工具_icon",@"id":@"2"};
    NSDictionary *tempDicthree = @{@"title":@"查询考勤",@"iconName":@"就诊费用_icon",@"id":@"3"};
    NSDictionary *tempDictFour = @{@"title":@"请假",@"iconName":@"我的预约单_icon",@"id":@"4"};
    
    NSMutableArray *tempArr =[[NSMutableArray alloc]initWithObjects:tempDictOne,tempDictTwo,tempDicthree,tempDictFour,nil];
    _studentArr = tempArr;
    [self createDataArr:tempArr];
    NSLog(@"%@",[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"student.sqlite"]);
    
    
}
#pragma mark--UICollectionView
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tempdict = _studentArr[indexPath.item];
    NSInteger fundId = [tempdict[@"id"]integerValue];
    switch (fundId) {
        case 1://
        {
            StudentsClassFormVC *choosevc = [[StudentsClassFormVC alloc]init];
            choosevc.chooseIndex = 10;
            choosevc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:choosevc animated:YES];
            /*
            StudentChooseClassVC *choosevc = [[StudentChooseClassVC alloc]init];
            choosevc.hidesBottomBarWhenPushed = YES;
            choosevc.chooseIndex = 10;
            [self.navigationController pushViewController:choosevc animated:YES];*/
            
        }
            break;
        case 2://课程表
        {
        
            StudentsClassFormVC *formVC = [[StudentsClassFormVC alloc]init];
            formVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:formVC animated:YES];
        }
            break;
        case 3://考勤
        {
            StudentCheckSignVC *checkvc = [[StudentCheckSignVC alloc]init];
            checkvc.hidesBottomBarWhenPushed = YES;
            checkvc.isteacher = NO;
            [self.navigationController pushViewController:checkvc animated:YES];
        }
            break;
        case 4:
        {
            StudentsClassFormVC *choosevc = [[StudentsClassFormVC alloc]init];
            choosevc.chooseIndex = 11;
            choosevc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:choosevc animated:YES];
            /*
            StudentChooseClassVC *choosevc = [[StudentChooseClassVC alloc]init];
            choosevc.chooseIndex = 11;
            choosevc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:choosevc animated:YES];*/
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

@end
