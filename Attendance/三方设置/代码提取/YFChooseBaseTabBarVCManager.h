//
//  YFChooseBaseTabBarVCManager.h
//  Attendance
//
//  Created by 孙云飞 on 2017/2/9.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFChooseBaseTabBarVCManager : NSObject
//单例
+ (instancetype)shareManager;

//显示学生端
- (void)windowsShowStudentManager;
//显示教师端
- (void)windowsShowTeacherManager;
//显示管理员端
- (void)windowsShowManager;
@end
