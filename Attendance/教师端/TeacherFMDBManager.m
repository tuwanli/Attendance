//
//  TeacherFMDBManager.m
//  LoginDemo
//
//  Created by 孙云飞 on 2017/2/14.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "TeacherFMDBManager.h"
#import "FMDatabase.h"
//存储地址
//#define TEACHERFILENAME [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"teacher.sqlite"]
//创建代码
#define TEACHER_CREATESQL @"create table if not exists `teacher`(teacher_id integer  primary key,teacher_account varchar(30) not null,teacher_pwd varchar(30) not null,teacher_name varchar(40) not null,teacher_department varchar(60) not null,teacher_title varchar(60) not null,teacher_phone varchar(40) not null)"
@implementation TeacherFMDBManager
//单例
+ (instancetype)shareTeacher{
    
    static TeacherFMDBManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

//插入数据
- (BOOL)teacher_insertData:(TeacherModel*)teacher{
    
    NSString *sql = [NSString stringWithFormat:@"insert into `teacher`(teacher_id,teacher_account,teacher_pwd,teacher_name,teacher_department,teacher_title,teacher_phone) values('%@','%@','%@','%@','%@','%@','%@')",
                     teacher.teacher_id,
                     teacher.teacher_account,
                     teacher.teacher_pwd,
                     teacher.teacher_name,
                     teacher.teacher_department,
                     teacher.teacher_title,
                     teacher.teacher_phone];
    
    return [self base_insertData:STUDENTFILENAME withCreateSql:TEACHER_CREATESQL widthInsertSql:sql];
}

//登陆是否成功
- (BOOL)teacher_justicLogin:(NSString *)account withPassword:(NSString *)pwd teaModel:(TeacherModel *)model{
    
    NSString *sql = [NSString stringWithFormat:@"select * from `teacher`"];
    FMResultSet *f = [self base_queryData:STUDENTFILENAME withCreateSql:TEACHER_CREATESQL withQuerySql:sql];
    //判断是否有相同的数据
    while ([f next]) {

        if ([[f stringForColumn:@"teacher_account"] isEqualToString:account] && [[f stringForColumn:@"teacher_pwd"] isEqualToString:pwd]) {
            
            //有对应的数据在数据库
            //获得这个数据的model
//            TeacherModel *model = [[TeacherModel alloc]init];
            model.teacher_id = @([f intForColumn:@"teacher_id"]);
            model.teacher_account = [f stringForColumn:@"teacher_account"];
            model.teacher_pwd = [f stringForColumn:@"teacher_pwd"];
            model.teacher_name = [f stringForColumn:@"teacher_name"];
            model.teacher_department = [f stringForColumn:@"teacher_department"];
            model.teacher_title = [f stringForColumn:@"teacher_title"];
            model.teacher_phone = [f stringForColumn:@"teacher_phone"];
            //返回
            [self base_closeTable];
            return YES;
        }
    }
    [self base_closeTable];
    return NO;
}
//查询数据
- (BOOL)teacher_getData:(TeacherModel *)model teacherId:(NSInteger)teaid
{
    
    NSString *sql = [NSString stringWithFormat:@"select * from `teacher` where teacher_id='%ld'",teaid];
    
    FMResultSet *f = [self base_queryData:STUDENTFILENAME withCreateSql:TEACHER_CREATESQL withQuerySql:sql];
    while ([f next]) {
        //获得这个数据的model
        model.teacher_id = @([f intForColumn:@"teacher_id"]);
        model.teacher_account = [f stringForColumn:@"teacher_account"];
        model.teacher_pwd = [f stringForColumn:@"teacher_pwd"];
        model.teacher_name = [f stringForColumn:@"teacher_name"];
        model.teacher_department = [f stringForColumn:@"teacher_department"];
        model.teacher_title = [f stringForColumn:@"teacher_title"];
        model.teacher_phone = [f stringForColumn:@"teacher_phone"];
        //返回
        [self base_closeTable];
        return YES;
    }
    [self base_closeTable];
    return NO;
}
//删除学生数据
- (BOOL)teacher_deleteData:(TeacherModel *)model{
    
    NSString *sql = [NSString stringWithFormat:@"delete from `teacher` where student_id='%d'",[model.teacher_id intValue]];
    return [self base_deleteData:STUDENTFILENAME withCreateSql:TEACHER_CREATESQL withDeleteSql:sql];
}

//更新学生数据
- (BOOL)teacher_updateData:(TeacherModel *)model{
    
    NSString *sql = [NSString stringWithFormat:@"update `teacher` set teacher_account='%@',teacher_pwd='%@,teacher_name=''%@',teacher_department='%@',teacher_title='%@',teacher_phone='%@'",
                     model.teacher_account,
                     model.teacher_pwd,
                     model.teacher_name,
                     model.teacher_department,
                     model.teacher_title,
                     model.teacher_phone];
    
    return [self base_updateData:STUDENTFILENAME withCreateSql:TEACHER_CREATESQL withUpdateSql:sql];
}
@end


//数据
@implementation TeacherModel

@end
