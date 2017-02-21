//
//  StudentFMDBManager.h
//  LoginDemo
//
//  Created by 孙云飞 on 2017/2/12.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import"BaseFMDB.h"
@class StudentModel;
@interface StudentFMDBManager : BaseFMDB
//单例
+ (instancetype)shareStudent;

//登陆是否成功
- (BOOL)student_justicLogin:(NSString *)account withPassword:(NSString *)pwd model:(StudentModel*)model;
- (BOOL)student_getData:(NSMutableArray *)modelArr;//查询所有
//插入数据
- (BOOL)student_insertData:(StudentModel*)student;

//删除学生数据
- (BOOL)student_deleteData:(StudentModel *)model;

//查询数据
- (BOOL)student_getData:(StudentModel *)model studentId:(NSInteger)stuid;

//更新学生数据
- (BOOL)student_updateData:(StudentModel *)model;
@end

//数据模型
@interface StudentModel : NSObject
@property(nonatomic,unsafe_unretained)NSNumber *student_id;//id
@property(nonatomic,copy)NSString *student_account;//账号
@property(nonatomic,copy)NSString *student_pwd;//密码
@property(nonatomic,copy)NSString *student_name;//姓名
@property(nonatomic,copy)NSString *student_department;//院系
@property(nonatomic,copy)NSString *student_class;//班级
@property (nonatomic, copy)NSString *student_phone;//电话
@end
