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
@property (nonatomic, copy)NSString *classname;
@property (nonatomic, copy)NSString *startTime;
@property (nonatomic, copy)NSString *endTime;
@property (nonatomic, copy)NSString *leaveStr;
@property (nonatomic, copy)NSString *leaveState;
@property (nonatomic, copy)NSString *createTime;
@end
