//
//  TeaResetWorkDB.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "TeaResetWorkDB.h"
#import "FMDatabase.h"

//创建代码
#define STUDENT_CREATESQL @"create table if not exists `teacher_work`(classId ,teacher_id varchar(30) not null,nowdateStr varchar(30),className varchar(30) not null,workContent varchar(30) not null,photopath)"
@implementation TeaResetWorkDB
+ (instancetype)shareTeaWork
{
    
    static TeaResetWorkDB *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
//插入数据
- (BOOL)student_insertWorkData:(teaWorkModel*)teaWork
{
    
    NSString *sql = [NSString stringWithFormat:@"insert into `teacher_work`(classId,teacher_id,nowdateStr,className,workContent,photopath) values('%@','%@','%@','%@','%@','%@')",
                     teaWork.classId,
                     teaWork.teacher_id,
                     teaWork.nowdateStr,
                     teaWork.classname,
                     teaWork.workContent,
                     teaWork.photopath
                     ];
    
    return [self base_insertData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL widthInsertSql:sql];
}


//查询数据
- (BOOL)student_getworkData:(NSMutableArray *)modelArr classname:(NSString *)classname
{
    
    NSString *sql = [NSString stringWithFormat:@"select * from `teacher_work` where className='%@'",classname];
    
    
    FMResultSet *f = [self base_queryData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withQuerySql:sql];
    while ([f next]) {
        //获得这个数据的model
        teaWorkModel *model = [[teaWorkModel alloc]init];
        model.classId = @([f intForColumn:@"classId"]);
        model.teacher_id = @([f intForColumn:@"teacher_id"]);
        model.nowdateStr = [f stringForColumn:@"nowdateStr"];
        model.classname = [f stringForColumn:@"className"];
        model.workContent = [f stringForColumn:@"workContent"];
        model.photopath = [f stringForColumn:@"photopath"];
        //返回
        [modelArr addObject:model];
        //        [self base_closeTable];
        //        return YES;
    }
    [self base_closeTable];
    return NO;
}
- (BOOL)student_deleteworkData:(teaWorkModel *)model
{
    
    NSString *sql = [NSString stringWithFormat:@"delete from `teacher_work` where nowdateStr='%@'",model.nowdateStr];
    return [self base_deleteData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withDeleteSql:sql];
}
//更新数据
- (BOOL)student_updateworkData:(teaWorkModel *)model
{

    NSString *sql = [NSString stringWithFormat:@"update `teacher_work` set workContent='%@',photopath='%@' where nowdateStr='%@'",model.workContent,model.photopath,model.nowdateStr];
    return [self base_deleteData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withDeleteSql:sql];
}
@end

@implementation teaWorkModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
