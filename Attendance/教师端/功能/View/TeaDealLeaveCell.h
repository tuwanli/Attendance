//
//  TeaDealLeaveCell.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol dealStuLeaveDelegate <NSObject>

- (void)dealStuLeave:(NSInteger)num cellRwo:(NSInteger)row;

@end
@interface TeaDealLeaveCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *refuseBtn;
@property (weak, nonatomic) IBOutlet UILabel *classNameL;
@property (weak, nonatomic) IBOutlet UIButton *AgreeBtn;
@property (weak, nonatomic) IBOutlet UILabel *StuNameL;
@property (weak, nonatomic) IBOutlet UILabel *LeaveTimeL;
@property (weak, nonatomic) IBOutlet UILabel *LeaveResonL;
@property (weak, nonatomic) IBOutlet UILabel *stateL;
@property (nonatomic, assign)NSInteger cellrow;
@property (nonatomic, weak)id<dealStuLeaveDelegate>delegate;
- (IBAction)agreeAction:(UIButton *)sender;
- (IBAction)refuseAction:(UIButton *)sender;


@end
