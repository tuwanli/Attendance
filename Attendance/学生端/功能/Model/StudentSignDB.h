//
//  StudentSignDB.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/15.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "BaseFMDB.h"
@class SignModel;

@interface StudentSignDB : BaseFMDB
+ (instancetype)shareStudentSign;
//插入数据
- (BOOL)student_insertSignData:(SignModel*)sign;

//删除学生数据
- (BOOL)student_deleteSignData:(SignModel *)model;

//查询数据
- (BOOL)student_getSignData:(NSMutableArray *)modelArr studentId:(NSInteger)stuid classId:(NSInteger)classId;
//更新学生数据
- (BOOL)student_updateSignData:(SignModel *)model;
@end
