//
//  StudentSignDB.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/15.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "StudentSignDB.h"
#import "SignModel.h"
#import "FMDatabase.h"

//创建代码
#define STUDENT_CREATESQL @"create table if not exists `student_sign`(classId ,student_id varchar(30) not null,className varchar(30) not null,createTime varchar(30) not null,photopath varchar(40) not null)"

@implementation StudentSignDB
//单例
+ (instancetype)shareStudentSign{
    
    static StudentSignDB *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

//插入数据
- (BOOL)student_insertSignData:(SignModel*)sign
{
    
    NSString *sql = [NSString stringWithFormat:@"insert into `student_sign`(classId,student_id,className,createTime,photopath) values('%@','%@','%@','%@','%@')",
                     sign.classId,
                     sign.student_id,
                     sign.className,
                     sign.createTime,
                     sign.photopath
                     ];
    
    return [self base_insertData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL widthInsertSql:sql];
}

//删除数据
- (BOOL)student_deleteSignData:(SignModel *)model{
    
    NSString *sql = [NSString stringWithFormat:@"delete from `student_sign` where createTime='%@'",model.createTime];
    return [self base_deleteData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withDeleteSql:sql];
}

//查询数据
- (BOOL)student_getSignData:(NSMutableArray *)modelArr studentId:(NSInteger)stuid classId:(NSInteger)classId{
    
    NSString *sql = [NSString stringWithFormat:@"select * from `student_sign` where student_id='%@'",@(stuid)];
    if (stuid<0) {
        sql = [NSString stringWithFormat:@"select * from `student_sign` where classId='%@'",@(classId)];
    }
    
    
    FMResultSet *f = [self base_queryData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withQuerySql:sql];
    while ([f next]) {
        //获得这个数据的model
        SignModel *model = [[SignModel alloc]init];
        model.classId = @([f intForColumn:@"classId"]);
        model.student_id = @([f intForColumn:@"student_id"]);
        
        model.className = [f stringForColumn:@"className"];
        model.createTime = [f stringForColumn:@"createTime"];
        model.photopath = [f stringForColumn:@"photopath"];
        //返回
        [modelArr addObject:model];
//        [self base_closeTable];
//        return YES;
    }
    [self base_closeTable];
    return NO;
}
- (BOOL)student_updateSignData:(SignModel *)model
{
    NSString *sql = [NSString stringWithFormat:@"update `student_sign` set student_id='%@',photopath='%@' where createTime='%@'",
                     model.student_id,
                     model.photopath,
                     model.createTime
                     ];
    
    return [self base_updateData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withUpdateSql:sql];
}

@end
