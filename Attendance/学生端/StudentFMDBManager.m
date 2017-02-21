//
//  StudentFMDBManager.m
//  LoginDemo
//
//  Created by 孙云飞 on 2017/2/12.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "StudentFMDBManager.h"
#import "FMDatabase.h"

//创建代码
#define STUDENT_CREATESQL @"create table if not exists `student`(student_id integer primary key,student_account varchar(30) not null,student_pwd varchar(30) not null,student_name varchar(40) not null,student_department varchar(60) not null,student_class varchar(60) not null,student_phone varchar(40) not null)"
@implementation StudentFMDBManager
//单例
+ (instancetype)shareStudent{

    static StudentFMDBManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

//插入数据
- (BOOL)student_insertData:(StudentModel*)student{

    NSString *sql = [NSString stringWithFormat:@"insert into `student`(student_id,student_account,student_pwd,student_name,student_department,student_class,student_phone) values('%@','%@','%@','%@','%@','%@','%@')",
                     student.student_id,
                     student.student_account,
                     student.student_pwd,
                     student.student_name,
                     student.student_department,
                     student.student_class,
                     student.student_phone];
    
    return [self base_insertData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL widthInsertSql:sql];
}

//登陆是否成功
- (BOOL)student_justicLogin:(NSString *)account withPassword:(NSString *)pwd model:(StudentModel*)model{

    NSString *sql = [NSString stringWithFormat:@"select * from `student`"];
    FMResultSet *f = [self base_queryData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withQuerySql:sql];
    //判断是否有相同的数据
    while ([f next]) {
        NSLog(@"account=%@",[f stringForColumn:@"student_account"]);
        if ([[f stringForColumn:@"student_account"] isEqualToString:account] && [[f stringForColumn:@"student_pwd"] isEqualToString:pwd]) {
            
            //有对应的数据在数据库
            //获得这个数据的model
//            StudentModel *model = [[StudentModel alloc]init];
            model.student_id = @([f intForColumn:@"student_id"]);
            model.student_account = [f stringForColumn:@"student_account"];
            model.student_pwd = [f stringForColumn:@"student_pwd"];
            model.student_name = [f stringForColumn:@"student_name"];
            model.student_department = [f stringForColumn:@"student_department"];
            model.student_class = [f stringForColumn:@"student_class"];
            model.student_phone = [f stringForColumn:@"student_phone"];
            //返回
            [self base_closeTable];
            return YES;
        }
    }
    [self base_closeTable];
    return NO;
}

//删除学生数据
- (BOOL)student_deleteData:(StudentModel *)model{

    NSString *sql = [NSString stringWithFormat:@"delete from `student` where student_id='%d'",[model.student_id intValue]];
    return [self base_deleteData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withDeleteSql:sql];
}
//查询数据
- (BOOL)student_getData:(StudentModel *)model studentId:(NSInteger)stuid
{

    NSString *sql = [NSString stringWithFormat:@"select * from `student` where student_id='%@'",@(stuid)];
    FMResultSet *f = [self base_queryData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withQuerySql:sql];
    while ([f next]) {
        //获得这个数据的model
//        StudentModel *model = [[StudentModel alloc]init];
        model.student_id = @([f intForColumn:@"student_id"]);
        model.student_account = [f stringForColumn:@"student_account"];
        model.student_pwd = [f stringForColumn:@"student_pwd"];
        model.student_name = [f stringForColumn:@"student_name"];
        model.student_department = [f stringForColumn:@"student_department"];
        model.student_class = [f stringForColumn:@"student_class"];
        model.student_phone = [f stringForColumn:@"student_phone"];
        //返回
        [self base_closeTable];
        return YES;
    }
    [self base_closeTable];
    return NO;
}
//查询数据
- (BOOL)student_getData:(NSMutableArray *)modelArr
{
    
    NSString *sql = [NSString stringWithFormat:@"select * from `student`"];
   
    FMResultSet *f = [self base_queryData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withQuerySql:sql];
    while ([f next]) {
        //获得这个数据的model
        StudentModel *model = [[StudentModel alloc]init];
        model.student_id = @([f intForColumn:@"student_id"]);
        model.student_account = [f stringForColumn:@"student_account"];
        model.student_pwd = [f stringForColumn:@"student_pwd"];
        model.student_name = [f stringForColumn:@"student_name"];
        model.student_department = [f stringForColumn:@"student_department"];
        model.student_class = [f stringForColumn:@"student_class"];
        model.student_phone = [f stringForColumn:@"student_phone"];
        [modelArr addObject:model];
        //返回
        //        [self base_closeTable];
        //        return YES;
    }
    [self base_closeTable];
    return NO;
}
//更新学生数据
- (BOOL)student_updateData:(StudentModel *)model{

    NSString *sql = [NSString stringWithFormat:@"update `student` set student_account='%@',student_pwd='%@',student_name='%@',student_department='%@',student_class='%@',student_phone='%@' where student_id='%@'",
                     model.student_account,
                     model.student_pwd,
                     model.student_name,
                     model.student_department,
                     model.student_class,
                     model.student_phone,
                     model.student_id];
    
    return [self base_updateData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withUpdateSql:sql];
}

@end



//数据模型
@implementation StudentModel
@end

