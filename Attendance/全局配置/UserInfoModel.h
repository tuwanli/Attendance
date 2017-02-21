//
//  UserInfoModel.h
//  AttendanceRecord
//
//  Created by 涂欢 on 2017/2/8.
//  Copyright © 2017年 DevinTu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
@property (nonatomic, copy)NSString *userId;//用户id
@property (nonatomic, copy)NSString *userName;//用户名
@property (nonatomic, copy)NSString *password;//密码
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *identifyNum;//身份
//@property (nonatomic, copy)NSString *schooleName;
@property (nonatomic, copy)NSString *collegeName;//学院
@property (nonatomic, copy)NSString *facullyname;//系
@end
