//
//  StudentClassWorkVC.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentClassWorkVC : UIViewController
@property (nonatomic, copy) NSString *classname;//课程名
@property (nonatomic, assign)NSInteger classId;//课程id
@property (nonatomic, assign)BOOL isManager;//是否管理员
@end
