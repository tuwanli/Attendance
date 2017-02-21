//
//  StudentFormDB.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/16.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "StudentFormDB.h"
#import "FMDatabase.h"

//创建代码

#define STUDENT_CREATESQL @"create table if not exists `student_form`(classId ,student_id varchar(30) ,classname varchar(30) ,startTime varchar(30) ,weekDayId varchar(30) ,teacherName varchar(40) )"
@implementation StudentFormDB
+ (instancetype)shareStudentForm
{
    
    static StudentFormDB *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
//插入数据
- (BOOL)student_insertFormData:(FormModel*)formModel
{
    
    NSString *sql = [NSString stringWithFormat:@"insert into `student_form`(classId,student_id,classname,startTime,weekDayId,teacherName) values('%@','%@','%@','%@','%@','%@')",
                     formModel.classId,
                     formModel.student_id,
                     formModel.classname,
                     formModel.startTime,
                     formModel.weekDayId,
                     formModel.teacherName
                     ];
    
    return [self base_insertData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL widthInsertSql:sql];
}

//删除学生数据
- (BOOL)student_deleteFormData:(FormModel *)model
{
    
    NSString *sql = [NSString stringWithFormat:@"delete from `student_form` where classId='%d'",[model.classId intValue]];
    return [self base_deleteData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withDeleteSql:sql];
}

//查询数据
- (BOOL)student_getFormData:(NSMutableArray *)modelArr studentId:(NSInteger)stuid weekId:(NSInteger)weekId
{
    
    NSString *sql = [NSString stringWithFormat:@"select * from `student_form` where student_id='%@' and weekDayId='%@'",@(stuid),@(weekId)];
    
    FMResultSet *f = [self base_queryData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withQuerySql:sql];
    while ([f next]) {
        //获得这个数据的model
        FormModel *model = [[FormModel alloc]init];
        model.classId = @([f intForColumn:@"classId"]);
        model.student_id = @([f intForColumn:@"student_id"]);
        
        model.classname = [f stringForColumn:@"classname"];
        model.startTime = [f stringForColumn:@"startTime"];
        model.weekDayId = @([f intForColumn:@"weekDayId"]);
        model.teacherName  =[f stringForColumn:@"teacherName"];
        //返回
        [modelArr addObject:model];
        //        [self base_closeTable];
        //        return YES;
    }
    [self base_closeTable];
    return NO;
}
@end

@implementation FormModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}
@end
