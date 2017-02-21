//
//  RegisteredVC.h
//  LoginDemo
//
//  Created by 孙云飞 on 2017/2/12.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisteredVC : UITableViewController
@property(nonatomic,assign)NSInteger chooseIndex;//选择的注册的类别
@property (nonatomic, assign)BOOL ismanager;
@property (nonatomic, assign)BOOL ismodify;
@property (nonatomic, strong)StudentModel *stumodel;
@end
