//
//  ViewController.m
//  Attendance
//
//  Created by 孙云飞 on 2017/2/9.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "ViewController.h"
#import "YFChooseBaseTabBarVCManager.h"
@interface ViewController ()
- (IBAction)clickOne:(id)sender;
- (IBAction)clickTwo:(id)sender;
- (IBAction)clickThree:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickOne:(id)sender {
    
    [[YFChooseBaseTabBarVCManager shareManager] windowsShowStudentManager];
}

- (IBAction)clickTwo:(id)sender {
    
    [[YFChooseBaseTabBarVCManager shareManager] windowsShowTeacherManager];
}

- (IBAction)clickThree:(id)sender {
    
    [[YFChooseBaseTabBarVCManager shareManager] windowsShowManager];
}
@end
