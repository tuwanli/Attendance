//
//  TeacherFMDBManager.h
//  LoginDemo
//
//  Created by 孙云飞 on 2017/2/14.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "BaseFMDB.h"
@class TeacherModel;
@interface TeacherFMDBManager : BaseFMDB
//单例
+ (instancetype)shareTeacher;

//登陆是否成功
- (BOOL)teacher_justicLogin:(NSString *)account withPassword:(NSString *)pwd teaModel:(TeacherModel *)model;

//插入数据
- (BOOL)teacher_insertData:(TeacherModel*)student;

//删除教师数据
- (BOOL)teacher_deleteData:(TeacherModel *)model;

//查询
- (BOOL)teacher_getData:(TeacherModel *)model teacherId:(NSInteger)teaid;

//更新教师数据
- (BOOL)teacher_updateData:(TeacherModel *)model;
@end

//数据
@interface TeacherModel : NSObject
@property(nonatomic,unsafe_unretained)NSNumber *teacher_id;
@property(nonatomic,copy)NSString *teacher_account;
@property(nonatomic,copy)NSString *teacher_pwd;
@property(nonatomic,copy)NSString *teacher_name;
@property(nonatomic,copy)NSString *teacher_department;
@property(nonatomic,copy)NSString *teacher_title;
@property (nonatomic, copy)NSString *teacher_phone;
@end
