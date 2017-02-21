//
//  TeaResetWorkDB.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "BaseFMDB.h"
@class teaWorkModel;
@interface TeaResetWorkDB : BaseFMDB
+ (instancetype)shareTeaWork;
//插入数据
- (BOOL)student_insertWorkData:(teaWorkModel*)teaWork;

//删除学生数据
- (BOOL)student_deleteworkData:(teaWorkModel *)model;

//查询数据
- (BOOL)student_getworkData:(NSMutableArray *)modelArr classname:(NSString *)classname;

//更新学生数据
- (BOOL)student_updateworkData:(teaWorkModel *)model;
@end
@interface teaWorkModel : NSObject
@property(nonatomic,unsafe_unretained)NSNumber *teacher_id;//id
@property (nonatomic,unsafe_unretained)NSNumber *classId;//课程id
@property (nonatomic, copy)NSString *classname;
@property (nonatomic, copy)NSString *workContent;
@property (nonatomic, copy)NSString *photopath;
@property (nonatomic, copy)NSString *nowdateStr;

@end
