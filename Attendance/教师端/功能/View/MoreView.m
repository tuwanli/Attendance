//
//  MoreView.m
//
//
//  Created by app40 on 15/6/30.
//  Copyright (c) 2015年 www.xcxy.eud.cn. All rights reserved.
//

#import "MoreView.h"
#import <QuartzCore/QuartzCore.h>
//#import "common.h"

@implementation MoreView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        //添加弹出视图
        _popView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 145, (45*_titleArr.count)+20)];
        UIImage *image = [UIImage imageNamed:@"medical_popUpBox"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        _popView.image=image;
//        _popView.backgroundColor=[UIColor blueColor];
        _popView.userInteractionEnabled=YES;
        [self addSubview:_popView];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //返回四行
    return _titleArr.count;
}

//设置单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), 37)];
    lable.textAlignment = NSTextAlignmentCenter;
    [lable setText:_titleArr[indexPath.row]];
    lable.font = [UIFont boldSystemFontOfSize:16];
    lable.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [cell.contentView addSubview:lable];
    if (indexPath.row!=_titleArr.count-1) {
        UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(20, 37, CGRectGetWidth(_tableView.frame)-20, 0.7)];
        shadowView.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
        [cell.contentView addSubview:shadowView];
    }
    
    return cell;
}

//添加点击单元格事件响应
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self.delegate respondsToSelector:@selector(didSelectTableViewCellIndex:)]) {
        [self.delegate didSelectTableViewCellIndex:indexPath.row];
    }
}

- (void)setTitleArr:(NSArray *)titleArr
{
    _titleArr = titleArr;
    CGRect popViewF = _popView.frame;
    popViewF.size.height = (45*titleArr.count)+28;
    _popView.frame = popViewF;
    
    //添加表到弹出视图
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(12, 27, _popView.frame.size.width-20, _titleArr.count*38) style:UITableViewStylePlain];
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    _tableView.layer.cornerRadius=5;
    _tableView.dataSource=self;
    _tableView.rowHeight = 38;
    _tableView.delegate=self;
    
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.backgroundColor=[UIColor redColor];
    [_popView addSubview:_tableView];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
/*
 - (UIImage *)makeThumbnailFromImage:(UIImage *)srcImage scale:(double)imageScale {
 
 UIImage *thumbnail = nil;
 
 CGSize imageSize = CGSizeMake(srcImage.size.width * imageScale, srcImage.size.height * imageScale);
 
 if (srcImage.size.width != imageSize.width || srcImage.size.height != imageSize.height)
 
 {
 
 UIGraphicsBeginImageContext(imageSize);
 
 CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
 
 [srcImage drawInRect:imageRect];
 
 thumbnail = UIGraphicsGetImageFromCurrentImageContext();
 
 UIGraphicsEndImageContext();
 }
 else
 
 {
 thumbnail = srcImage;
 }
 return thumbnail;
 }*/
@end
