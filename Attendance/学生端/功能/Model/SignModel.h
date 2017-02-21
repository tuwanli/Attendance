//
//  SignModel.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/15.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignModel : NSObject
@property(nonatomic,unsafe_unretained)NSNumber *student_id;//id
@property (nonatomic,unsafe_unretained)NSNumber *classId;//课程id
@property (nonatomic, copy)NSString *className;//课程名
@property (nonatomic, copy)NSString *createTime;//签到时间
@property (nonatomic, copy)NSString *photopath;//图片路径
@end
