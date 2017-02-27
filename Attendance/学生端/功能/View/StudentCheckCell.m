//
//  StudentCheckCell.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/15.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "StudentCheckCell.h"

@implementation StudentCheckCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _classImageView.contentMode = UIViewContentModeScaleAspectFit;
}
//删除
- (IBAction)deleteCellAction:(UIButton *)sender {
    if (_delegate&&[_delegate respondsToSelector:@selector(deleteCellWithRow:)]) {
        [_delegate deleteCellWithRow:sender.tag];
    }
}
@end
