//
//  TeaDealLeaveVC.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "TeaDealLeaveVC.h"
#import "TeaDealLeaveCell.h"
#import "StudentLeaveDB.h"
static NSString *TeaDealLeaveCell_idenfer = @"TeaDealLeaveCell_idenfer";
@interface TeaDealLeaveVC ()<UITableViewDelegate,UITableViewDataSource,dealStuLeaveDelegate>
{

    BOOL isdelete;//是否删除
    UIButton *editButton;//编辑
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *deleteArr;
@end

@implementation TeaDealLeaveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"请假信息";
    _dataArr = [[NSMutableArray alloc]init];
    _deleteArr = [[NSMutableArray alloc]init];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    [_tableView registerNib:[UINib nibWithNibName:@"TeaDealLeaveCell" bundle:nil] forCellReuseIdentifier:TeaDealLeaveCell_idenfer];
    [self.view addSubview:_tableView];
    
    //从本地取出来
    [[StudentLeaveDB shareStudentLeave]student_getLeaveData:_dataArr studentId:-1];
    if (_dataArr.count==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无请假" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    if (_ismanager) {
        editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        editButton.frame = CGRectMake(0,0,40,40);
        [editButton setTitle:@"删除" forState:UIControlStateNormal];
        [editButton setTitleColor:[UIColor colorWithRed:0 green:168/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        editButton.titleLabel.font = [UIFont systemFontOfSize:14];
        editButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [editButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem             = [[UIBarButtonItem alloc]initWithCustomView:editButton];
        self.navigationItem.rightBarButtonItem = rightItem;
        _tableView.allowsMultipleSelectionDuringEditing = YES;
    }
}
#pragma mark--UITableViewDelegate/UITabeViewDasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section == 0) {
        return 0.1;
    }
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeaDealLeaveCell *cell = [tableView dequeueReusableCellWithIdentifier:TeaDealLeaveCell_idenfer];
    LeaveModel *model = _dataArr[indexPath.section];
    StudentModel *stumodel = [[StudentModel alloc]init];
    [[StudentFMDBManager shareStudent]student_getData:stumodel studentId:[model.student_id integerValue]];
    if (!_ismanager) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.cellrow = indexPath.section;
    if ([model.leaveState integerValue]==0) {
        cell.AgreeBtn.hidden = NO;
        cell.refuseBtn.hidden = NO;
        cell.stateL.hidden = YES;
    }else{
        cell.AgreeBtn.hidden = YES;
        cell.refuseBtn.hidden = YES;
        cell.stateL.hidden = NO;
        if (model.leaveState&&[model.leaveState integerValue]==1)  {
            [cell.stateL setText:@"已批准"];
            [cell.stateL setTextColor:[UIColor colorWithRed:0 green:168/255.0 blue:1.0 alpha:1.0]];
        }else if(model.leaveState&&[model.leaveState integerValue]==2){
            [cell.stateL setText:@"已拒绝"];
            [cell.stateL setTextColor:[UIColor lightGrayColor]];
        }
    }
    
    cell.AgreeBtn.tag = indexPath.section;
    cell.refuseBtn.tag = indexPath.section;
    cell.delegate = self;
    [cell.StuNameL setText:stumodel.student_name];
    [cell.classNameL setText:model.classname];
    [cell.LeaveTimeL setText:[NSString stringWithFormat:@"%@-%@",model.startTime,[model.endTime substringFromIndex:5]]];
    if ([[model.startTime substringToIndex:10]isEqualToString:[model.endTime substringToIndex:10]]) {
        [cell.LeaveTimeL setText:[NSString stringWithFormat:@"%@-%@",model.startTime,[model.endTime substringFromIndex:10]]];
    }
    cell.LeaveTimeL.numberOfLines = 0;
    [cell.LeaveResonL setText:model.leaveStr];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (_ismanager) {
        if (isdelete) {
            [_deleteArr addObject:indexPath];
        }
    }
}
#pragma mark--dealStuLeaveDelegate处理请假
- (void)dealStuLeave:(NSInteger)num cellRwo:(NSInteger)row
{
    
    NSString *wrongStr = @"已批准";
    if (num == 1) {//批准
        wrongStr = @"已批准";
    }else{
        wrongStr = @"已拒绝";
    }
    for (TeaDealLeaveCell *cell in _tableView.visibleCells) {//修改状态
        if (row == cell.cellrow) {
            LeaveModel *model = _dataArr[row];
            
            cell.stateL.hidden = NO;
            cell.AgreeBtn.hidden = YES;
            cell.refuseBtn.hidden = YES;
            
            if (num == 1) {
                model.leaveState = @"1";
                [cell.stateL setText:@"已批准"];
                
                [cell.stateL setTextColor:[UIColor colorWithRed:0 green:168/255.0 blue:1.0 alpha:1.0]];
            }else{
                [cell.stateL setText:@"已拒绝"];
                model.leaveState = @"2";
                [cell.stateL setTextColor:[UIColor lightGrayColor]];
            
            }
            [[StudentLeaveDB shareStudentLeave]student_updateLeaveData:model];
        }
        
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请假处理" message:wrongStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
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
    if (!isdelete) {
        [_tableView setEditing:YES animated:YES];
        isdelete = YES;
    }else{
        if (_deleteArr.count == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有请假删除" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        NSMutableArray *tempdataArr = [[NSMutableArray alloc]init];
        for (int i=0; i<_deleteArr.count; i++) {
            NSIndexPath *tempPath = _deleteArr[i];
            [tempdataArr addObject:_dataArr[tempPath.section]];
            LeaveModel *model = _dataArr[tempPath.section];
            [[StudentLeaveDB shareStudentLeave]student_deleteLeaveData:model];
            
        }
        [_dataArr removeObjectsInArray:tempdataArr];
        [_tableView reloadData];
        [_deleteArr removeAllObjects];
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
