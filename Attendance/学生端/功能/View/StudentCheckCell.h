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
@property (weak, nonatomic) IBOutlet UIImageView *classImageView;
@property (weak, nonatomic) IBOutlet UILabel *classname;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UIButton *deleteCellBtn;
@property (nonatomic, weak)id<deleteCellDelegate>delegate;
- (IBAction)deleteCellAction:(UIButton *)sender;


@end
