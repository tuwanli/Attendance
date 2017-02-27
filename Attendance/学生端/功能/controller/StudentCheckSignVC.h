//
//  StudentCheckSignVC.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/15.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentCheckSignVC : UIViewController
@property (nonatomic, assign)BOOL isteacher;//是否为教师
@property (nonatomic, assign)NSInteger classId;//课程 ID
@property (nonatomic, copy)NSString *classname;//课程名
@end
