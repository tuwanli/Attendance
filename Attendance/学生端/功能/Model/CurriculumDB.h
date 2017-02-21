//
//  CurriculumDB.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/16.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "BaseFMDB.h"
@class CurriculumModel;
@interface CurriculumDB : BaseFMDB
+ (instancetype)shareStudentCurriculum;
//插入数据
- (BOOL)student_insertCurrData:(CurriculumModel*)curModel;

//删除学生数据
- (BOOL)student_deleteCurrData:(CurriculumModel *)model;

//查询数据
- (BOOL)student_getCurrData:(NSMutableArray *)modelArr;
@end

@interface CurriculumModel : NSObject
@property(nonatomic,unsafe_unretained)NSNumber *student_id;//id
@property (nonatomic,unsafe_unretained)NSNumber *CurriculumId;//课程id
@property (nonatomic, copy)NSString *Curriculumname;
@property (nonatomic, copy)NSString *classname;

@end
