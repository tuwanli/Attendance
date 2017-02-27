//
//  StudentLeaveDB.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/16.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "BaseFMDB.h"
@class LeaveModel;
@interface StudentLeaveDB : BaseFMDB
+ (instancetype)shareStudentLeave;
//插入数据
- (BOOL)student_insertLeaveData:(LeaveModel*)leave;

//删除学生数据
- (BOOL)student_deleteLeaveData:(LeaveModel *)model;

//查询数据
- (BOOL)student_getLeaveData:(NSMutableArray *)modelArr studentId:(NSInteger)stuid;
//更新学生数据
- (BOOL)student_updateLeaveData:(LeaveModel *)model;
@end

@interface LeaveModel : NSObject
@property(nonatomic,unsafe_unretained)NSNumber *student_id;//id
@property (nonatomic,unsafe_unretained)NSNumber *classId;//课程id
@property (nonatomic, copy)NSString *classname;//课程名
@property (nonatomic, copy)NSString *startTime;//开始时间
@property (nonatomic, copy)NSString *endTime;//结束时间
@property (nonatomic, copy)NSString *leaveStr;//请假理由
@property (nonatomic, copy)NSString *leaveState;//请假状态
@property (nonatomic, copy)NSString *createTime;//创建时间
@end
