//
//  StudentCheckSignVC.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/15.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "StudentCheckSignVC.h"
#import "StudentCheckCell.h"
#import "StudentSignDB.h"
#import "SignModel.h"
#import "MoreView.h"
#import "StudentSignVC.h"
static NSString *StudentCheckCell_identifer = @"StudentCheckCell";
@interface StudentCheckSignVC ()<UICollectionViewDelegate,UICollectionViewDataSource,MoreViewDelegate,deleteCellDelegate>
{

    UIView *_blackView;
}
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)MoreView *moreView;
@end

@implementation StudentCheckSignVC

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    if (_isteacher) {
        [[StudentSignDB shareStudentSign]student_getSignData:tempArr studentId:-1 classId:_classId];
        _dataArr = tempArr;
    }
    if (_dataArr.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无考勤" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    [_collectionView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [[NSMutableArray alloc]init];
    if (_isteacher) {
        self.title = _classname;
    }
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame)/2-25, CGRectGetWidth(self.view.frame)/2-25);
    flowLayout.minimumLineSpacing = 20;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [_collectionView registerNib:[UINib nibWithNibName:@"StudentCheckCell" bundle:nil] forCellWithReuseIdentifier:StudentCheckCell_identifer];
    [self.view addSubview:_collectionView];
    
    
    //从本地取
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    if (!_isteacher) {
       NSInteger userid =[[[NSUserDefaults standardUserDefaults]objectForKey:@"studen_id"]integerValue];
        [[StudentSignDB shareStudentSign]student_getSignData:tempArr studentId:userid classId:-1];
        _dataArr = tempArr;
    }else{
        
        
        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        editButton.frame = CGRectMake(0,0,40,40);
        [editButton setTitle:@"更多" forState:UIControlStateNormal];
        [editButton setTitleColor:[UIColor colorWithRed:0 green:168/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        editButton.titleLabel.font = [UIFont systemFontOfSize:14];
        editButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [editButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem             = [[UIBarButtonItem alloc]initWithCustomView:editButton];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
    
}
#pragma mark--UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StudentCheckCell *cell = (StudentCheckCell *)[collectionView dequeueReusableCellWithReuseIdentifier:StudentCheckCell_identifer forIndexPath:indexPath];
    SignModel *model = _dataArr[indexPath.item];
    [cell.classImageView setImage:[self takepicture:model.createTime]];
    cell.layer.borderColor = [UIColor colorWithRed:0 green:168/255.0 blue:1.0 alpha:1.0].CGColor;
    cell.layer.borderWidth = 1;
    if (_isteacher) {
        StudentModel *studentModel = [[StudentModel alloc]init];
        cell.delegate = self;
        cell.deleteCellBtn.tag = indexPath.item;
        [[StudentFMDBManager shareStudent]student_getData:studentModel studentId:[model.student_id integerValue]];
        
        [cell.classname setText:studentModel.student_name];
    }else{
    
        cell.deleteCellBtn.hidden = YES;
        [cell.classname setText:model.className];
    }
   
    [cell.createTime setText:model.createTime];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (_isteacher) {
        SignModel *model = _dataArr[indexPath.item];
        StudentSignVC *checkVc = [[StudentSignVC alloc]init];
        checkVc.teaSignModel = model;
        checkVc.classname = model.className;
        checkVc.classId = [model.classId integerValue];
        checkVc.isteacher = YES;
        checkVc.ismodify = YES;
        StudentModel *studentModel = [[StudentModel alloc]init];
        [[StudentFMDBManager shareStudent]student_getData:studentModel studentId:[model.student_id integerValue]];
        checkVc.stumodel = studentModel;
        [self.navigationController pushViewController:checkVc animated:YES];
    }
    
}
- (void)deleteCellWithRow:(NSInteger)item
{
    NSMutableArray *tempArr = _dataArr;
    SignModel *model = tempArr[item];
    [tempArr removeObjectAtIndex:item];
    _dataArr = tempArr;
    
    [[StudentSignDB shareStudentSign]student_deleteSignData:model];
    [_collectionView reloadData];
    
}
//沙盒路径取出照片(保存)
- (UIImage *)takepicture:(NSString *)string
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", string]];   // 保存文件的名称
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    return img;
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
    }
}
//点击单元格
-(void)didSelectTableViewCellIndex:(NSInteger)index
{
    [self removeMoreView];
    if (index == 0) {//添加
        StudentSignVC *signVc = [[StudentSignVC alloc]init];
        signVc.classname = _classname;
        signVc.classId = _classId;
        signVc.isteacher = YES;
        signVc.ismodify = NO;
        [self.navigationController pushViewController:signVc animated:YES];
    }
    else if (index == 1){//删除
        for(StudentCheckCell *cell in self.collectionView.visibleCells){
            cell.deleteCellBtn.hidden = NO;
//            NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
//            //找到某一个具体的section；
//            SectionModel *section = self.dataSectionArray[indexPath.section];
//            
//            //除最后一个cell外都显示删除按钮；
//            if (indexPath.row != section.cellArray.count - 1){
//                [cell.deleteButton setHidden:false];
//            }
        }
    }
}
//移除moreView
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
