//
//  StudentClassWorkVC.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "StudentClassWorkVC.h"
#import "StudentWorkCell.h"
#import "TeaResetWorkDB.h"
#import "TeaReserWorkVC.h"
#import "MoreView.h"
#import "TeaReserWorkVC.h"
static NSString *studentWorkCell_identifer = @"studentWorkCell_identifer";
@interface StudentClassWorkVC ()<UITableViewDelegate,UITableViewDataSource,MoreViewDelegate>
{

    UIView *_blackView;
    BOOL isdelete;
    UIButton *editButton;
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *deleteArr;
@property (nonatomic, strong)MoreView *moreView;
@end

@implementation StudentClassWorkVC
- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    isdelete = NO;
    [_dataArr removeAllObjects];
    //从本地取出来
    [[TeaResetWorkDB shareTeaWork]student_getworkData:_dataArr classname:_classname];
    if (_dataArr.count==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无作业" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
    
        [_tableView reloadData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"查看作业";
    _deleteArr = [[NSMutableArray alloc]init];
    _dataArr = [[NSMutableArray alloc]init];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    [_tableView registerNib:[UINib nibWithNibName:@"StudentWorkCell" bundle:nil] forCellReuseIdentifier:studentWorkCell_identifer];
    [self.view addSubview:_tableView];
    
    
    if (_isManager) {
        editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        editButton.frame = CGRectMake(0,0,40,40);
        [editButton setTitle:@"更多" forState:UIControlStateNormal];
        [editButton setTitleColor:[UIColor colorWithRed:0 green:168/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        editButton.titleLabel.font = [UIFont systemFontOfSize:14];
        editButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [editButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem             = [[UIBarButtonItem alloc]initWithCustomView:editButton];
        self.navigationItem.rightBarButtonItem = rightItem;
        _tableView.allowsMultipleSelectionDuringEditing = YES;
    }
}
#pragma mark--UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section == 0) {
        return 0.1;
    }
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:studentWorkCell_identifer];
    teaWorkModel *model = _dataArr[indexPath.section];
    [cell.workContentL setText:model.workContent];
    [cell.workTimeL setText:model.nowdateStr];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!isdelete) {
        [_tableView deselectRowAtIndexPath:indexPath animated:YES];
        teaWorkModel *model = _dataArr[indexPath.section];
        TeaReserWorkVC *workVC = [[TeaReserWorkVC alloc]init];
        workVC.classname = model.classname;
        workVC.workModel = model;
        if (_isManager) {
            workVC.ismanager = YES;
        }
        workVC.isteacher = NO;
        workVC.classId = [model.classId integerValue];
        [self.navigationController pushViewController:workVC animated:YES];
    }else{
        [_deleteArr addObject:indexPath];
    }
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_deleteArr containsObject:indexPath]) {
        [_deleteArr removeObject:indexPath];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


//选择后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //
}
#pragma mark--点击更多
- (void)editAction
{
    if ([_moreView superview]) {
        
        [UIView beginAnimations:nil context:NULL];
        _moreView.alpha=0;
        _blackView.alpha = 0;
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [_moreView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.2];
        _moreView=nil;
        _blackView = nil;
        [UIView commitAnimations];
    }
    else
    {
        if (!isdelete) {
            //出现气泡
            _moreView=[[MoreView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-150, 40, 145, (45*2)+20)];
            _moreView.titleArr = @[@"添加",@"删除"];
            _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
            _blackView.alpha = 0.3;
            _blackView.backgroundColor = [UIColor blackColor];
            UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeMoreView)];
            [_blackView addGestureRecognizer:tapges];
            _moreView.delegate=self;
            [self.navigationController.view addSubview:_blackView];
            [self.navigationController.view addSubview:_moreView];
        }else{
            if (_deleteArr.count == 0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有作业删除" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            NSMutableArray *tempdataArr = [[NSMutableArray alloc]init];
            for (int i=0; i<_deleteArr.count; i++) {
                NSIndexPath *tempPath = _deleteArr[i];
                [tempdataArr addObject:_dataArr[tempPath.section]];
                teaWorkModel *model = _dataArr[tempPath.section];
                [[TeaResetWorkDB shareTeaWork]student_deleteworkData:model];
            }
            [_dataArr removeObjectsInArray:tempdataArr];
            [_tableView reloadData];
            [_deleteArr removeAllObjects];
        }
        
    }
}
//点击单元格
-(void)didSelectTableViewCellIndex:(NSInteger)index
{
    [self removeMoreView];
    
    if (index == 0) {//添加
        TeaReserWorkVC *workvc = [[TeaReserWorkVC alloc]init];
        workvc.isteacher = YES;
        workvc.classname = _classname;
        workvc.classId = _classId;
        [self.navigationController pushViewController:workvc animated:YES];
    }
    else if (index == 1){//删除
        [_tableView setEditing:YES animated:YES];
        isdelete = YES;
        [editButton setTitle:@"删除" forState:UIControlStateNormal];
    }
}
- (void)removeMoreView
{
    
    if ([_moreView superview]) {
        
        [UIView beginAnimations:nil context:NULL];
        _moreView.alpha=0;
        _blackView.alpha = 0;
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [_moreView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.2];
        _moreView=nil;
        _blackView = nil;
        [UIView commitAnimations];
        
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
