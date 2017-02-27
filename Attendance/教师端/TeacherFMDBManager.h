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
@property(nonatomic,unsafe_unretained)NSNumber *teacher_id;//教师ID
@property(nonatomic,copy)NSString *teacher_account;//教师账号
@property(nonatomic,copy)NSString *teacher_pwd;//密码
@property(nonatomic,copy)NSString *teacher_name;//姓名
@property(nonatomic,copy)NSString *teacher_department;//院系
@property(nonatomic,copy)NSString *teacher_title;//职称
@property (nonatomic, copy)NSString *teacher_phone;//电话
@end
