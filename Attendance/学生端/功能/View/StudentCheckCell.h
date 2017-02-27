//
//  StudentCheckCell.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/15.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol deleteCellDelegate <NSObject>

- (void)deleteCellWithRow:(NSInteger)item;

@end
@interface StudentCheckCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *classImageView;//考勤图片
@property (weak, nonatomic) IBOutlet UILabel *classname;//课程名
@property (weak, nonatomic) IBOutlet UILabel *createTime;//创建时间
@property (weak, nonatomic) IBOutlet UIButton *deleteCellBtn;//删除按钮
@property (nonatomic, weak)id<deleteCellDelegate>delegate;
- (IBAction)deleteCellAction:(UIButton *)sender;//删除


@end
