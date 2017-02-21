//
//  BaseFMDB.h
//  LoginDemo
//
//  Created by 孙云飞 on 2017/2/12.
//  Copyright © 2017年 孙云飞. All rights reserved.
//
//基础fmdb类
#import <Foundation/Foundation.h>

@interface BaseFMDB : NSObject

//插入数据
- (BOOL)base_insertData:(NSString *)path
          withCreateSql:(NSString *)sql
         widthInsertSql:(NSString *)insertSql;

//返回数据
- (id)base_queryData:(NSString *)path
          withCreateSql:(NSString *)sql
           withQuerySql:(NSString *)querySql;

//修改数据
- (BOOL)base_updateData:(NSString *)path
          withCreateSql:(NSString *)sql
          withUpdateSql:(NSString *)updateSql;

//删除数据
- (BOOL)base_deleteData:(NSString *)path
          withCreateSql:(NSString *)sql
          withDeleteSql:(NSString *)deleteSql;

//关闭数据库
- (void)base_closeTable;
@end
