//
//  ManagerPersonVC.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "ManagerPersonVC.h"
#import "LoginVC.h"
@interface ManagerPersonVC ()
- (IBAction)quitAction;

@end

@implementation ManagerPersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)quitAction {
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"loginState"];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginVC *loginvc = [story instantiateViewControllerWithIdentifier:@"login"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginvc];
    [self presentViewController:nav animated:YES completion:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
//    [self.navigationController pushViewController:loginvc animated:YES];
}
@end
