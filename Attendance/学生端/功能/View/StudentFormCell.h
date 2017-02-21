//
//  StudentFormCell.h
//  Attendance
//
//  Created by 涂欢 on 2017/2/16.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentFormCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *classL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *teacherL;

@end
