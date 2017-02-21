//
//  StudentSignVC.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/15.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SignModel;
@interface StudentSignVC : UIViewController
@property (nonatomic, copy) NSString *classname;
@property (nonatomic, assign)NSInteger classId;
@property (nonatomic, assign)BOOL isteacher;
@property (nonatomic, strong)SignModel *teaSignModel;
@property (nonatomic, strong)StudentModel *stumodel;
@property (nonatomic, assign)BOOL ismodify;
@end
