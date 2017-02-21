//
//  ViewController.m
//  LoginDemo
//
//  Created by 孙云飞 on 2017/2/12.
//  Copyright © 2017年 孙云飞. All rights reserved.
//管理员账号：admini  密码：123

#import "LoginVC.h"
#import "RegisteredVC.h"
#import "YFChooseBaseTabBarVCManager.h"
@interface LoginVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *loginIcon;//头像
@property (weak, nonatomic) IBOutlet UITextField *nameField;//账号
@property (weak, nonatomic) IBOutlet UITextField *pwdField;//密码
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentMode;//模式
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;//注册按钮
//按钮点击事件
- (IBAction)clickLoginBtn:(id)sender;
- (IBAction)clickRegisterBtn:(id)sender;
- (IBAction)clickSegmentBtn:(UISegmentedControl *)sender;


@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置UI
    [self p_setUI];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getTheNewId];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)p_setUI{

    self.loginBtn.layer.cornerRadius = CGRectGetWidth(self.loginBtn.frame);
    self.loginBtn.layer.masksToBounds = YES;
    
    self.loginBtn.layer.cornerRadius = 5;
    self.registerBtn.layer.cornerRadius = 5;
}

//登陆事件
- (IBAction)clickLoginBtn:(id)sender {

    
    [self.view endEditing:YES];
    if (self.view.frame.origin.y<0) {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        }];
    }
    NSString *wrongStr = @"登录成功";
    BOOL flag = NO;
    if ([[self.nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        wrongStr = @"账号不能为空";
        
        
    }else if ([[self.pwdField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
        wrongStr = @"密码不能为空";
       
    }
    switch (self.segmentMode.selectedSegmentIndex) {
        case 0:
        {
            StudentModel *model = [[StudentModel alloc]init];
            flag = [[StudentFMDBManager shareStudent] student_justicLogin:self.nameField.text withPassword:self.pwdField.text model:model] ?  YES: NO ;
            
            if (flag) {
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"teacher_id"];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:model.student_id forKey:@"studen_id"];
                [defaults setObject:@(1) forKey:@"loginState"];
                [defaults synchronize];
                [[YFChooseBaseTabBarVCManager shareManager]windowsShowStudentManager];
            }else{
                wrongStr = @"用户名或者密码错误";
            }
        
        }
            
            break;
        case 1:
        {
        
            TeacherModel *model = [[TeacherModel alloc]init];
            flag = [[TeacherFMDBManager shareTeacher]teacher_justicLogin:self.nameField.text withPassword:self.pwdField.text teaModel:model]?YES: NO;
            if (flag) {
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"studen_id"];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:model.teacher_id forKey:@"teacher_id"];
                [defaults setObject:@(2) forKey:@"loginState"];
                [defaults synchronize];
                [[YFChooseBaseTabBarVCManager shareManager]windowsShowTeacherManager];
            }else{
                
                wrongStr = @"用户名或者密码错误";
            }
        
        }
            
            break;
        case 2:
            if ([[self.nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@"admini"]&&[[self.pwdField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@"123"]) {
                flag = YES;
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@(111) forKey:@"admin_id"];
                [defaults setObject:@(3) forKey:@"loginState"];
                [defaults synchronize];
            }
            if (flag) {
                [[YFChooseBaseTabBarVCManager shareManager]windowsShowManager];
            }else{
            
                wrongStr = @"用户名或者密码错误";
            }
            break;
        default:
            break;
    }
    if (!flag) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:wrongStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
}

//注册事件
- (IBAction)clickRegisterBtn:(id)sender {
    [self.view endEditing:YES];
    if (self.view.frame.origin.y<0) {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        }];
    }
   //获取mode的选择下表
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RegisteredVC *registerVC = [story instantiateViewControllerWithIdentifier:@"register"];\
    registerVC.chooseIndex = self.segmentMode.selectedSegmentIndex;
    registerVC.title = @"注 册";
    NSLog(@"%@",self.presentingViewController);
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
//选择的mode的事件
- (IBAction)clickSegmentBtn:(UISegmentedControl *)sender {
    [self getTheNewId];
    if (self.segmentMode.selectedSegmentIndex==2) {
        //管理员不能直接注册
//        [self.nameField setText:@""];
//        [self.pwdField setText:@""];
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"admin_id"]integerValue]>0) {
            [self.nameField setText:@"admini"];
            [self.pwdField setText:@"123"];
        }else{
            [self.nameField setText:@""];
            [self.pwdField setText:@""];
        }
        [UIView animateWithDuration:0.3 animations:^{
            
            self.registerBtn.alpha = 0.0;
        }];
    }else{
    
        if (self.registerBtn.alpha == 0.0) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                self.registerBtn.alpha = 1.0;
            }];
        }
    }
    
}
- (void)getTheNewId{

    switch (self.segmentMode.selectedSegmentIndex) {
        case 0:
        {
            NSUInteger studentid = [[[NSUserDefaults standardUserDefaults]objectForKey:@"studen_id"]integerValue];
            StudentModel *model = [[StudentModel alloc]init];
            [[StudentFMDBManager shareStudent]student_getData:model studentId:studentid];
            [self.nameField setText:model.student_account];
            [self.pwdField setText:model.student_pwd];
        }
            break;
        case 1:
        {
            NSUInteger teacherid = [[[NSUserDefaults standardUserDefaults]objectForKey:@"teacher_id"]integerValue];
            TeacherModel *model = [[TeacherModel alloc]init];
            [[TeacherFMDBManager shareTeacher]teacher_getData:model teacherId:teacherid];
            [self.nameField setText:model.teacher_account];
            [self.pwdField setText:model.teacher_pwd];
            
        }
            break;
        case 2:
        {
            NSUInteger adminid = [[[NSUserDefaults standardUserDefaults]objectForKey:@"admin_id"]integerValue];
            if (adminid>0) {
                [self.nameField setText:@"admini"];
                [self.pwdField setText:@"123"];
            }
            
        }
            break;
        default:
            break;
    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = CGRectMake(0, -100, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.view.frame.origin.y<0) {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        }];
    }
    [textField resignFirstResponder];
    return YES;
}
@end
