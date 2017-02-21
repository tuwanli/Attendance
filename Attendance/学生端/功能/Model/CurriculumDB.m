//
//  CurriculumDB.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/16.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "CurriculumDB.h"
#import "FMDatabase.h"

//创建代码

#define STUDENT_CREATESQL @"create table if not exists `student_culum`(CurriculumId integer primary key,student_id varchar(30) ,Curriculumname varchar(30) ,classname varchar(30))"
@implementation CurriculumDB
+ (instancetype)shareStudentCurriculum
{
    
    static CurriculumDB *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
//插入数据
- (BOOL)student_insertCurrData:(CurriculumModel*)curModel
{
    
    NSString *sql = [NSString stringWithFormat:@"insert into `student_culum`(CurriculumId,student_id,Curriculumname,classname) values('%@','%@','%@','%@')",
                     curModel.CurriculumId,
                     curModel.student_id,
                     curModel.Curriculumname,
                     curModel.classname
                     ];
    
    return [self base_insertData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL widthInsertSql:sql];
}

//删除学生数据
- (BOOL)student_deleteCurrData:(CurriculumModel *)model
{
    
    NSString *sql = [NSString stringWithFormat:@"delete from `student_culum` where CurriculumId='%d'",[model.CurriculumId intValue]];
    return [self base_deleteData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withDeleteSql:sql];
}

//查询数据
- (BOOL)student_getCurrData:(NSMutableArray *)modelArr;
{
    
    NSString *sql = [NSString stringWithFormat:@"select * from `student_culum`"];
    
    FMResultSet *f = [self base_queryData:STUDENTFILENAME withCreateSql:STUDENT_CREATESQL withQuerySql:sql];
    while ([f next]) {
        //获得这个数据的model
        CurriculumModel *model = [[CurriculumModel alloc]init];
        model.CurriculumId = @([f intForColumn:@"CurriculumId"]);
        model.student_id = @([f intForColumn:@"student_id"]);
        model.Curriculumname = [f stringForColumn:@"Curriculumname"];
        model.classname = [f stringForColumn:@"classname"];
        //返回
        [modelArr addObject:model];
        //        [self base_closeTable];
        //        return YES;
    }
    [self base_closeTable];
    return NO;
}
@end

@implementation CurriculumModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
