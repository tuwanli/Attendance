//
//  StudentSignCell.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/15.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "StudentSignCell.h"

@implementation StudentSignCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _classL.layer.cornerRadius = 5;
    _classL.clipsToBounds = YES;
    _classL.layer.borderColor = [UIColor colorWithRed:0 green:168/255.0 blue:255/255.0 alpha:1.0].CGColor;
    _classL.layer.borderWidth = 1;
}

@end
