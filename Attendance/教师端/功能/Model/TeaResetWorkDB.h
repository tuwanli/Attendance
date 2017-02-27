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

//删除数据
- (BOOL)student_deleteworkData:(teaWorkModel *)model;

//查询数据
- (BOOL)student_getworkData:(NSMutableArray *)modelArr classname:(NSString *)classname;

//更新数据
- (BOOL)student_updateworkData:(teaWorkModel *)model;
@end
@interface teaWorkModel : NSObject
@property(nonatomic,unsafe_unretained)NSNumber *teacher_id;//id
@property (nonatomic,unsafe_unretained)NSNumber *classId;//课程id
@property (nonatomic, copy)NSString *classname;//课程名
@property (nonatomic, copy)NSString *workContent;//作业
@property (nonatomic, copy)NSString *photopath;//图片路径
@property (nonatomic, copy)NSString *nowdateStr;//保存时间

@end
