//
//  StudentSignVC.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/15.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SignModel;
@interface StudentSignVC : UIViewController
@property (nonatomic, copy) NSString *classname;//课程名
@property (nonatomic, assign)NSInteger classId;//课程 ID
@property (nonatomic, assign)BOOL isteacher;//是否教师
@property (nonatomic, strong)SignModel *teaSignModel;//
@property (nonatomic, strong)StudentModel *stumodel;//
@property (nonatomic, assign)BOOL ismodify;//是否修改状态
@end
