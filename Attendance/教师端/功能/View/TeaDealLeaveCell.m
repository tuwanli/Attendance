//
//  TeaDealLeaveCell.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "TeaDealLeaveCell.h"

@implementation TeaDealLeaveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _refuseBtn.layer.cornerRadius =_AgreeBtn.layer.cornerRadius = 4;
    _AgreeBtn.clipsToBounds = YES;
    _refuseBtn.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)agreeAction:(UIButton *)sender {
    if (_delegate&&[_delegate respondsToSelector:@selector(dealStuLeave:cellRwo:)]) {
        [_delegate dealStuLeave:1 cellRwo:sender.tag];
    }
}

- (IBAction)refuseAction:(UIButton *)sender {
    if (_delegate&&[_delegate respondsToSelector:@selector(dealStuLeave:cellRwo:)]) {
        [_delegate dealStuLeave:2 cellRwo:sender.tag];
    }
}


@end
