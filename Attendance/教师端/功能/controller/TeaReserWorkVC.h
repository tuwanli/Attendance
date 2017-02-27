//
//  TeaReserWorkVC.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  teaWorkModel;
@interface TeaReserWorkVC : UIViewController
@property (nonatomic, assign)NSInteger classId;//课程id
@property (nonatomic, copy)NSString *classname;//课程名
@property (nonatomic, assign)BOOL isteacher;//是否为教师
@property (nonatomic, assign)BOOL ismanager;//是否管理员
@property (nonatomic, strong)teaWorkModel *workModel;//
@end
