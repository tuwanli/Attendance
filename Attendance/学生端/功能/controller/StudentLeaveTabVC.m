//
//  StudentLeaveTabVC.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/15.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "StudentLeaveTabVC.h"
#import "StudentLeaveDB.h"
@interface StudentLeaveTabVC ()<UITextViewDelegate,UITextFieldDelegate>
{

    NSString *timerStr;
    NSInteger timeNum;
    LeaveModel *model;
}
@property (weak, nonatomic) IBOutlet UITextField *classnameL;
@property (weak, nonatomic) IBOutlet UITextField *startTimeT;
@property (weak, nonatomic) IBOutlet UITextField *endTimeT;
@property (weak, nonatomic) IBOutlet UITextView *leaveTextView;
@property (nonatomic, strong)UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (nonatomic, strong)UIView *pickView;
- (IBAction)appointAction;

@end

@implementation StudentLeaveTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_classnameL setText:_classname];
    [self.view addSubview:self.pickView];
    model = [[LeaveModel alloc]init];
    model.classname = _classname;
    model.classId = @(_classId);
    model.student_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"studen_id"];
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateStyle:NSDateFormatterMediumStyle];
    [formatter2 setTimeStyle:NSDateFormatterShortStyle];
    [formatter2 setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime2 = [formatter2 stringFromDate:date];
    model.createTime = DateTime2;
    
}
- (UIView *)pickView
{
    if (!_pickView) {
        _pickView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)+280, CGRectGetWidth(self.view.frame),280 )];
        [_pickView setBackgroundColor:[UIColor whiteColor]];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(CGRectGetWidth(self.view.frame)-100, 5, 80, 30);
        [btn setBackgroundColor:[UIColor colorWithRed:0 green:168/255.0 blue:1.0 alpha:1.0]];
        btn.layer.cornerRadius = 6;
        btn.clipsToBounds = YES;
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
        [_pickView addSubview:btn];
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(btn.frame)+5, CGRectGetWidth(self.view.frame), 240)];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        [_datePicker setTimeZone:[NSTimeZone localTimeZone]];
        [_datePicker setDate:[NSDate date] animated:YES];
        [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_pickView addSubview:_datePicker];
        [_datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        NSDate *date = _datePicker.date;
        //转换为字符串
        NSDateFormatter *format  = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm"];
        timerStr = [format stringFromDate:date];
    }
    return _pickView;
}

- (IBAction)appointAction {
    NSString *wrongStr = @"申请成功";
    if (self.startTimeT.text.length == 0) {
        wrongStr = @"请选择开始时间";
    }else if (self.endTimeT.text.length == 0){
        wrongStr = @"请选择结束时间";
    }else if (self.leaveTextView.text.length == 0){
        wrongStr = @"请输入请假理由";
    }else{
        
        //保存本地
        model.leaveStr = self.leaveTextView.text;
        model.leaveState = @"0";
        [[StudentLeaveDB shareStudentLeave]student_insertLeaveData:model];
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:wrongStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}
- (void)finishAction:(UIButton *)btn
{
    if (timeNum<0) {
        [self.startTimeT setText:timerStr];
        model.startTime = timerStr;
    }else{
        [self.endTimeT setText:timerStr];
        model.endTime = timerStr;
    }
    
    if (self.pickView.frame.origin.y<CGRectGetHeight(self.view.frame)) {
        [UIView animateWithDuration:0.3 animations:^{
            self.pickView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame)+280, CGRectGetWidth(self.view.frame),280 );
        }];
    }
    
}
- (void)datePickerValueChanged:(UIDatePicker *)picker
{
    NSDate *date = picker.date;
    //转换为字符串
    NSDateFormatter *format  = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm"];
    timerStr = [format stringFromDate:date];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (self.pickView.frame.origin.y>=CGRectGetHeight(self.view.frame)) {
        [UIView animateWithDuration:0.3 animations:^{
            self.pickView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame)-280, CGRectGetWidth(self.view.frame), 280);
        }];
    }
    if (textField == self.startTimeT) {
        timeNum = -1;
    }else if (textField == self.endTimeT){
        timeNum = 1;
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if (textView.text.length==0) {
            self.tipL.hidden = NO;
        }
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        self.tipL.hidden = YES;
        
    }else{
        
        self.tipL.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
