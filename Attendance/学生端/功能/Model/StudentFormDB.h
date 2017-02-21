//
//  StudentFormDB.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/16.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "BaseFMDB.h"
@class FormModel;
@interface StudentFormDB : BaseFMDB
+ (instancetype)shareStudentForm;
//插入数据
- (BOOL)student_insertFormData:(FormModel*)formModel;

//删除学生数据
- (BOOL)student_deleteFormData:(FormModel *)model;

//查询数据
- (BOOL)student_getFormData:(NSMutableArray *)modelArr studentId:(NSInteger)stuid weekId:(NSInteger)weekId;
@end

@interface FormModel : NSObject
@property(nonatomic,unsafe_unretained)NSNumber *student_id;//id
@property (nonatomic,unsafe_unretained)NSNumber *classId;//课程id
@property (nonatomic, copy)NSString *classname;
@property (nonatomic, copy)NSString *startTime;
@property (nonatomic,unsafe_unretained)NSNumber *weekDayId;
@property (nonatomic, copy)NSString *teacherName;
@end
