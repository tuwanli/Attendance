//
//  StudentLeaveDB.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/16.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "StudentLeaveDB.h"
#import "FMDatabase.h"

//创建代码
#define STUDENT_CREATESQL @"create table if not exists `student_leave`(classId integer primary key,student_id varchar(30) not null,classname varchar(30) not null,startTime varchar(30) not null,endTime varchar(30) not null,leaveStr varchar(40) not null,leaveState varchar(30),createtime varchar(30))"
@implementation StudentLeaveDB
//单例
+ (instancetype)shareStudentLeave{
    
    static StudentLeaveDB *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

//插入数据
- (BOOL)student_insertLeaveData:(LeaveModel*)leave
{
    
    NSString *sql = [NSString stringWithFormat:@"insert into `student_leave`(classId,student_id,classname,startTime,endTime,leaveStr,leaveState,createtime) values('%@','%@','%@','%@','%@','%@','%@','%@')",
                     leave.classId,
                     leave.student_id,
                     leave.classname,
                     leave.startTime,
                     leave.endTime,
                     leave.leaveStr,
                     leave.leaveState,
                     leave.createTime
                     ];
    
    return [self base_insertData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL widthInsertSql:sql];
}

//删除学生数据
- (BOOL)student_deleteLeaveData:(LeaveModel *)model
{
    
    NSString *sql = [NSString stringWithFormat:@"delete from `student_leave` where classId='%@' and createtime='%@'",model.classId,model.createTime];
    return [self base_deleteData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withDeleteSql:sql];
}

//查询数据
- (BOOL)student_getLeaveData:(NSMutableArray *)modelArr studentId:(NSInteger)stuid
{
    
    NSString *sql = [NSString stringWithFormat:@"select * from `student_leave` where student_id='%@'",@(stuid)];
    if (stuid<0) {
        sql = [NSString stringWithFormat:@"select * from `student_leave`"];
    }
    
    FMResultSet *f = [self base_queryData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withQuerySql:sql];
    while ([f next]) {
        //获得这个数据的model
        LeaveModel *model = [[LeaveModel alloc]init];
        model.classId = @([f intForColumn:@"classId"]);
        model.student_id = @([f intForColumn:@"student_id"]);
        
        model.classname = [f stringForColumn:@"classname"];
        model.startTime = [f stringForColumn:@"startTime"];
        model.endTime = [f stringForColumn:@"endTime"];
        model.leaveStr = [f stringForColumn:@"leaveStr"];
        model.leaveState = [f stringForColumn:@"leaveState"];
        model.createTime = [f stringForColumn:@"createtime"];
        //返回
        [modelArr addObject:model];
        //        [self base_closeTable];
        //        return YES;
    }
    [self base_closeTable];
    return NO;
}
- (BOOL)student_updateLeaveData:(LeaveModel *)model
{
    NSString *sql = [NSString stringWithFormat:@"update `student_leave` set leaveState='%@' where student_id='%@' and classId='%@' and createtime='%@'",
                     model.leaveState,
                     model.student_id,
                     model.classId,
                     model.createTime
                     ];
    
    return [self base_updateData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withUpdateSql:sql];
}
@end

@implementation LeaveModel

@end
