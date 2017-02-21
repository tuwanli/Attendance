//
//  BaseCollectionCell.m
//  Attendance
//
//  Created by 孙云飞 on 2017/2/9.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "BaseCollectionCell.h"
@interface BaseCollectionCell()


@end
@implementation BaseCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
}

@end
