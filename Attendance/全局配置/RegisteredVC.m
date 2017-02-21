//
//  RegisteredVC.m
//  LoginDemo
//
//  Created by 孙云飞 on 2017/2/12.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "RegisteredVC.h"
#import "YFChooseBaseTabBarVCManager.h"
#import "StudentFormDB.h"
#import "CurriculumDB.h"
static NSInteger studendid = 0;
static NSInteger teacherid = 0;
@interface RegisteredVC ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountField;//账号
@property (weak, nonatomic) IBOutlet UITextField *pwdField;//密码
@property (weak, nonatomic) IBOutlet UITextField *nameField;//姓名
@property (weak, nonatomic) IBOutlet UITextField *departmentsField;//院系
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;//注册按钮
@property (weak, nonatomic) IBOutlet UITextField *classField;//班级
@property (weak, nonatomic) IBOutlet UITextField *phoneT;//电话
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *titleBtns;//职称按钮
@property(nonatomic,unsafe_unretained,nonnull)NSString *titleString;//职称
//按钮事件
- (IBAction)clickTitleBtn:(UIButton *)sender;
- (IBAction)clickRegisterBtn:(id)sender;

@end

@implementation RegisteredVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.registerBtn.layer.cornerRadius = 5;
    studendid = [[[NSUserDefaults standardUserDefaults]objectForKey:@"studen_id"]integerValue];
    teacherid = [[[NSUserDefaults standardUserDefaults]objectForKey:@"teacher_id"]integerValue];
    if (_ismanager&&_ismodify) {
        [self.accountField setText:_stumodel.student_account];
        [self.pwdField setText:_stumodel.student_pwd];
        [self.nameField setText:_stumodel.student_name];
        [self.phoneT setText:_stumodel.student_phone];
        [self.classField setText:_stumodel.student_class];
        [self.departmentsField setText:_stumodel.student_department];
        [_registerBtn setTitle:@"保存" forState:UIControlStateNormal];
        studendid = [_stumodel.student_id integerValue];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//判断是教师注册还是学生注册
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (self.chooseIndex) {
        case 0:
            //学生
            if (indexPath.row == 4) {
                return 0;
            }
            break;
        case 1:
            if (indexPath.row == 5) {
                return 0;
            }
            break;
        default:
            //默认高度
            return 44;
    }
    return 44;
}

//教师选择职称
- (IBAction)clickTitleBtn:(UIButton *)sender {
    
    //1.首先所有的按钮的状态都改为默认状态
    for (UIButton *btn in self.titleBtns) {
        btn.selected = NO;
    }
    //2.把当前选择的按钮的状态变为selected
    sender.selected = YES;
    //3.保留选择的职称
    self.titleString = sender.titleLabel.text;
}

//注册
- (IBAction)clickRegisterBtn:(id)sender {
    
    //所有课表
    
    NSString *fileName = [[NSBundle mainBundle]pathForResource:@"curriculum" ofType:@"plist"];
    NSMutableArray *temArr = [[NSMutableArray alloc]initWithContentsOfFile:fileName];
    
    for (NSDictionary *tempDict in temArr) {
        CurriculumModel *model = [[CurriculumModel alloc]init];
        model.Curriculumname = tempDict[@"name"];
        model.CurriculumId = tempDict[@"CurriculumId"];
        model.student_id = @([[[NSUserDefaults standardUserDefaults]objectForKey:@"studen_id"]integerValue]);
        NSArray *classArr = tempDict[@"class"];
        NSString *classStr  =[classArr componentsJoinedByString:@","];
        model.classname = classStr;
        [[CurriculumDB shareStudentCurriculum]student_insertCurrData:model];
    }
    
    switch (self.chooseIndex) {
        case 0:
            //学生注册
        {
        
            if (!_ismanager&&!_ismodify) {
                studendid+=1;
            }
            
            StudentModel *model = [[StudentModel alloc] init];
            model.student_id = @(studendid);
            model.student_account = [self.accountField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            model.student_pwd = [self.pwdField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            model.student_name = self.nameField.text;
            model.student_department = self.departmentsField.text;
            model.student_class = self.classField.text;
            model.student_phone = self.phoneT.text;
            if (_ismanager&&_ismodify) {
                [[StudentFMDBManager shareStudent]student_updateData:model];
            }else{
                [[StudentFMDBManager shareStudent] student_insertData:model];
            }
            
            if (!_ismanager) {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"studen_id"];
            }
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@(studendid) forKey:@"studen_id"];
            [defaults synchronize];
            
            
            //课程表
            NSString *filename = [[NSBundle mainBundle]pathForResource:@"StudentForm" ofType:@"plist"];
            NSArray *formArr = [[NSArray alloc]initWithContentsOfFile:filename];
            for (NSDictionary *tempDict in formArr) {
                FormModel *model = [[FormModel alloc]init];
                [model setValuesForKeysWithDictionary:tempDict];
                model.student_id = @(studendid);
                [[StudentFormDB shareStudentForm]student_insertFormData:model];
            }
            
            
            
        
        }
            break;
        case 1:
        {
            teacherid+=1;
            TeacherModel *model = [[TeacherModel alloc] init];
            model.teacher_id = @(teacherid);
            model.teacher_account = self.accountField.text;
            model.teacher_pwd = self.pwdField.text;
            model.teacher_name = self.nameField.text;
            model.teacher_department = self.departmentsField.text;
            model.teacher_title = self.titleString;
            model.teacher_phone = self.phoneT.text;
            [[TeacherFMDBManager shareTeacher] teacher_insertData:model];
            if (!_ismanager) {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"teacher_id"];
            }
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@(teacherid) forKey:@"teacher_id"];
            [defaults synchronize];
        }
            break;
        default:
            break;
    }
    if (!_ismanager) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注册成功" message:@"是否登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"返回登录", nil];
        [alert show];
    }else{
    
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"添加成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
