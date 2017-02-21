//
//  TeaReserWorkVC.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  teaWorkModel;
@interface TeaReserWorkVC : UIViewController
@property (nonatomic, assign)NSInteger classId;
@property (nonatomic, copy)NSString *classname;
@property (nonatomic, assign)BOOL isteacher;
@property (nonatomic, assign)BOOL ismanager;
@property (nonatomic, strong)teaWorkModel *workModel;
@end
