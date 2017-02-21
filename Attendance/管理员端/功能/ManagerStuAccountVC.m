//
//  ManagerStuAccountVC.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/20.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "ManagerStuAccountVC.h"
#import "ManagerAccountCell.h"
#import "MoreView.h"
#import "RegisteredVC.h"
static NSString *ManagerAccount_identifer = @"ManagerAccount_identifer";
@interface ManagerStuAccountVC ()<UITableViewDelegate,UITableViewDataSource,MoreViewDelegate>
{

    UIView *_blackView;
    BOOL isdelete;
    UIButton *editButton;
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *stuDataArr;
@property (nonatomic, strong)MoreView *moreView;
@property (nonatomic, strong)NSMutableArray *deleteArr;

@end

@implementation ManagerStuAccountVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //本地数据
    [_stuDataArr removeAllObjects];
    [[StudentFMDBManager shareStudent]student_getData:_stuDataArr];
    [_tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号管理";
    _deleteArr = [[NSMutableArray alloc]init];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _stuDataArr = [[NSMutableArray alloc]init];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.view.frame)) style:UITableViewStyleGrouped];
    [_tableView registerNib:[UINib nibWithNibName:@"ManagerAccountCell" bundle:nil] forCellReuseIdentifier:ManagerAccount_identifer];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(0,0,40,40);
    [editButton setTitle:@"更多" forState:UIControlStateNormal];
    [editButton setTitleColor:[UIColor colorWithRed:0 green:168/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    editButton.titleLabel.font = [UIFont systemFontOfSize:14];
    editButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [editButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem             = [[UIBarButtonItem alloc]initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return _stuDataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section==0) {
        return 0.1;
    }
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    ManagerAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:ManagerAccount_identifer];
    StudentModel *model = _stuDataArr[indexPath.section];
    [cell.nameL setText:model.student_name];
    [cell.classL setText:model.student_class];
    [cell.yuanxiL setText:model.student_department];
    [cell.phoneL setText:model.student_phone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!isdelete) {
        [_tableView deselectRowAtIndexPath:indexPath animated:YES];
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RegisteredVC *registerVC = [story instantiateViewControllerWithIdentifier:@"register"];\
        registerVC.chooseIndex = 0;
        registerVC.title = @"修改学生信息";
        registerVC.ismanager = YES;
        registerVC.stumodel = _stuDataArr[indexPath.section];
        registerVC.ismodify = YES;
        [self.navigationController pushViewController:registerVC animated:YES];
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
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有账号删除" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            NSMutableArray *tempdataArr = [[NSMutableArray alloc]init];
            for (int i=0; i<_deleteArr.count; i++) {
                NSIndexPath *tempPath = _deleteArr[i];
                [tempdataArr addObject:_stuDataArr[tempPath.section]];
                StudentModel *model = _stuDataArr[tempPath.section];
                [[StudentFMDBManager shareStudent]student_deleteData:model];
            }
            [_stuDataArr removeObjectsInArray:tempdataArr];
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
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RegisteredVC *registerVC = [story instantiateViewControllerWithIdentifier:@"register"];\
        registerVC.chooseIndex = 0;
        registerVC.title = @"添加学生账户";
        registerVC.ismanager = YES;
        [self.navigationController pushViewController:registerVC animated:YES];
        
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
