//
//  BaseFMDB.m
//  LoginDemo
//
//  Created by 孙云飞 on 2017/2/12.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "BaseFMDB.h"
#import "FMDatabase.h"
@interface BaseFMDB(){

     FMDatabase *_db;//创建一个对象
}
@end
@implementation BaseFMDB

//创建fmdb数据库
- (void)base_createTable:(NSString *)path
                 withSql:(NSString *)sql{

    _db = [FMDatabase databaseWithPath:path];
    if ([_db open]) {
        
        //创建表
        if ([_db executeUpdate:sql]) {
            
            NSLog(@"表创建成功");
        }else{
        
            NSLog(@"表创建失败");
        }
    }else{
    
        NSLog(@"数据库创建失败");
    }
}

//关闭数据库
- (void)base_closeTable{

    if ([_db close]) {
        NSLog(@"数据库关闭");
    }else{
    
        NSLog(@"数据库关闭失败");
    }
}

//插入数据
- (BOOL)base_insertData:(NSString *)path
          withCreateSql:(NSString *)sql
         widthInsertSql:(NSString *)insertSql{

    [self base_createTable:path withSql:sql];
    BOOL flag = [_db executeUpdate:insertSql];
    [self base_closeTable];
    return flag;
}

//返回数据
- (id)base_queryData:(NSString *)path
          withCreateSql:(NSString *)sql
           withQuerySql:(NSString *)querySql{

    [self base_createTable:path withSql:sql];
    FMResultSet *f = [_db executeQuery:querySql];
    //[self base_closeTable];
    return f;
}

//修改数据
- (BOOL)base_updateData:(NSString *)path
          withCreateSql:(NSString *)sql
          withUpdateSql:(NSString *)updateSql{

    [self base_createTable:path withSql:sql];
    BOOL flag = [_db executeUpdate:updateSql];
    [self base_closeTable];
    return flag;
}

//删除数据
- (BOOL)base_deleteData:(NSString *)path
          withCreateSql:(NSString *)sql
          withDeleteSql:(NSString *)deleteSql{

    [self base_createTable:path withSql:sql];
    BOOL flag = [_db executeUpdate:deleteSql];
    [self base_closeTable];
    return flag;
}

@end
