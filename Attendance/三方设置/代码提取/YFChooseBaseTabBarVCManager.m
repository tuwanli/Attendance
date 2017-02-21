
//
//  YFChooseBaseTabBarVCManager.m
//  Attendance
//
//  Created by 孙云飞 on 2017/2/9.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "YFChooseBaseTabBarVCManager.h"
#import <UIKit/UIKit.h>
#import "BaseTabBarVC.h"
@implementation YFChooseBaseTabBarVCManager

//单例
+ (instancetype)shareManager{

    static YFChooseBaseTabBarVCManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[self alloc]init];
    });
    return manager;
}

- (void)showManager:(NSString *)storyName withVCName:(NSString *)vcName{

    //从故事版获取控制器
    UIStoryboard *story = [UIStoryboard storyboardWithName:storyName bundle:nil];
    BaseTabBarVC *baseVC = [story instantiateViewControllerWithIdentifier:vcName];
    //显示
    [UIApplication sharedApplication].keyWindow.rootViewController = baseVC;
}

//显示学生端
- (void)windowsShowStudentManager{

    [self showManager:@"StudentStoryboard" withVCName:@"student"];
}

//显示教师端
- (void)windowsShowTeacherManager{

    [self showManager:@"TeacherStoryboard" withVCName:@"teacher"];
}

//显示管理员端
- (void)windowsShowManager{

    [self showManager:@"ManagerStoryboard" withVCName:@"manager"];
}
@end
