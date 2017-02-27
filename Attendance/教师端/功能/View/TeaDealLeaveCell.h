//
//  TeaDealLeaveCell.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol dealStuLeaveDelegate <NSObject>

- (void)dealStuLeave:(NSInteger)num cellRwo:(NSInteger)row;//处理学生考勤

@end
@interface TeaDealLeaveCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *refuseBtn;//拒绝
@property (weak, nonatomic) IBOutlet UILabel *classNameL;//课程名
@property (weak, nonatomic) IBOutlet UIButton *AgreeBtn;//同意
@property (weak, nonatomic) IBOutlet UILabel *StuNameL;//学生姓名
@property (weak, nonatomic) IBOutlet UILabel *LeaveTimeL;//请假时间
@property (weak, nonatomic) IBOutlet UILabel *LeaveResonL;//请假理由
@property (weak, nonatomic) IBOutlet UILabel *stateL;//状态
@property (nonatomic, assign)NSInteger cellrow;//
@property (nonatomic, weak)id<dealStuLeaveDelegate>delegate;
- (IBAction)agreeAction:(UIButton *)sender;
- (IBAction)refuseAction:(UIButton *)sender;


@end
