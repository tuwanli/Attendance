//
//  AppDelegate.m
//  Attendance
//
//  Created by 孙云飞 on 2017/2/9.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "AppDelegate.h"
#import "YFChooseBaseTabBarVCManager.h"
#import "LoginVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    //获取界面
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
    NSInteger num = [[[NSUserDefaults standardUserDefaults]objectForKey:@"loginState"]integerValue];
    
    
    
    switch (num) {
        case 1:
            [[YFChooseBaseTabBarVCManager shareManager]windowsShowStudentManager];
            break;
        case 2:
            [[YFChooseBaseTabBarVCManager shareManager]windowsShowTeacherManager];
            break;
        case 3:
            [[YFChooseBaseTabBarVCManager shareManager]windowsShowManager];
            break;
        default:
        {
            //从故事版获取控制器
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginVC *loginvc = [story instantiateViewControllerWithIdentifier:@"login"];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginvc];
            self.window.rootViewController = nav;
        
        }
            break;
    }
    
    return YES;
}


@end
