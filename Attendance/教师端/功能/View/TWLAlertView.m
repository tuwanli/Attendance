//
//  TWLAlertView.m
//  DefinedSelf
//
//  Created by 涂婉丽 on 15/12/15.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//eregfg

#import "TWLAlertView.h"
#define k_w [UIScreen mainScreen].bounds.size.width
#define k_h [UIScreen mainScreen].bounds.size.height
@implementation TWLAlertView

- (id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        //创建遮罩
        _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, k_w, k_h)];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(blackClick)];
        [self.blackView addGestureRecognizer:tap];
        [self addSubview:_blackView];
//        _selectBtnArray = [[NSMutableArray alloc]init];
        //创建alert
        self.alertview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 270, 190)];
        self.alertview.center = self.center;
//        UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
//        self.alertview.center = CGPointMake(CGRectGetMidX(keywindow.frame), -CGRectGetMidY(keywindow.frame));
        
        
        self.alertview.layer.cornerRadius = 17;
        self.alertview.clipsToBounds = YES;
        self.alertview.backgroundColor = [UIColor whiteColor];
        [self addSubview:_alertview];
        [self exChangeOut:self.alertview dur:0.5];
        
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _tipLable = [[UILabel alloc]init];
//    _tipLable = [[UILabel alloc]initWithFrame:CGRectMake(0,0,270,43)];
    _tipLable.frame = CGRectMake(0,0,CGRectGetWidth(self.alertview.frame),43);
    _tipLable.textAlignment = NSTextAlignmentCenter;
    [_tipLable setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    _tipLable.text = _title;
    [_tipLable setFont:[UIFont systemFontOfSize:18]];
    [_tipLable setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
    switch (_type) {
        case 10:
            self.alertview.frame = CGRectMake(0, 0, 270, 250);
            _tipLable.frame = CGRectMake(0,0,CGRectGetWidth(self.alertview.frame),43);
//            self.alertview.center = CGPointMake(self.center.x, self.center.y);
            [self creatViewInAlert];
            break;
        case 11:
            self.alertview.frame = CGRectMake(0, 0, 270, 170);
            _tipLable.frame = CGRectMake(0,0,CGRectGetWidth(self.alertview.frame),43);
            [self creatViewWithAlert];
            break;
        case 12:
            [self creatViewWithPidAlert];
            break;
        case 13:
            [self creatViewWithAppointAlert];
            break;
        case 14:
            [_tipLable setBackgroundColor:[UIColor colorWithRed:0/255.0 green:168/255.0 blue:255/255.0 alpha:1.0]];
           self.alertview.frame = CGRectMake(0, 0, 223, 125);
            _tipLable.frame = CGRectMake(0,0,CGRectGetWidth(self.alertview.frame),43);
            [_tipLable setFont:[UIFont systemFontOfSize:15]];
            [_tipLable setTextColor:[UIColor whiteColor]];
            [self creatViewWithAttenView];
            break;
        case 15://就诊信息
            self.alertview.frame = CGRectMake(0, 0, 270, _contentArr.count*50+CGRectGetHeight(_tipLable.frame)+55);
            [self appointInfoSelectPerson];
            break;
        default:
            break;
    }
    self.alertview.center = CGPointMake(self.center.x, self.center.y);
    
    [self.alertview addSubview:_tipLable];
    [self createBtnTitle:_btnTitleArr];
}

- (void)creatViewInAlert
{
    
    UILabel *isCreate = [[UILabel alloc]initWithFrame:CGRectMake(20, _tipLable.frame.origin.y+8+ _tipLable.frame.size.height, self.alertview.frame.size.width-40, 30)];
    isCreate.text = @"是否创建一个就诊号？";
    isCreate.font = [UIFont boldSystemFontOfSize:16];
    UILabel *attenL = [[UILabel alloc]initWithFrame:CGRectMake(isCreate.frame.origin.x, isCreate.frame.origin.y+20, self.alertview.frame.size.width-40, 130)];
    attenL.font = [UIFont systemFontOfSize:15];
    attenL.text = _contentArr[0];
//    attenL.text = @"注：新建就诊号，以前的就诊信息无法查询，第一次在手机挂号到医院分诊台分诊时需要出示身份证，如果挂号填写的就诊人信息和身份证信息不符，医院有权利拒绝提供就诊服务，挂号费用不退";
    attenL.numberOfLines = 0;
    attenL.font = [UIFont systemFontOfSize:14];
    attenL.textColor = [UIColor redColor];
    [self.alertview addSubview:attenL];
    [self.alertview addSubview:isCreate];
}
- (void)creatViewWithAlert
{
    _textF =[[UITextField alloc]initWithFrame:CGRectMake(15, _tipLable.frame.origin.y+20+ _tipLable.frame.size.height, self.alertview.frame.size.width-30, 40)];
    _textF.placeholder = @"登录密码";
    _textF.secureTextEntry = YES;
    _textF.borderStyle = UITextBorderStyleRoundedRect;
    _textF.returnKeyType = UIReturnKeyDone;
    _textF.delegate = self;
    [_textF becomeFirstResponder];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_textF.frame)+20, self.alertview.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.alertview addSubview:_textF];

}

- (void)creatViewWithPidAlert
{
    UILabel *showL = [[UILabel alloc]initWithFrame:CGRectMake(20, _tipLable.frame.origin.y+_tipLable.frame.size.height, self.alertview.frame.size.width-40, self.alertview.frame.size.height-43-48)];
    [showL setTextColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0]];
    showL.numberOfLines = 0;
    [showL setFont:[UIFont systemFontOfSize:18]];
    [showL setText:_contentArr[0]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:showL.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:9];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, showL.text.length)];
    
    showL.attributedText = attributedString;
    showL.textAlignment = NSTextAlignmentCenter;
    
    
    [self.alertview addSubview:showL];
    
}
- (void)creatViewWithAttenView
{
    UILabel *showL = [[UILabel alloc]initWithFrame:CGRectMake(20, _tipLable.frame.origin.y+_tipLable.frame.size.height, self.alertview.frame.size.width-40, self.alertview.frame.size.height-43-48)];
    [showL setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
    showL.numberOfLines = 0;
    [showL setFont:[UIFont systemFontOfSize:15]];
    [showL setText:_contentArr[0]];
    showL.textAlignment = NSTextAlignmentCenter;
    [self.alertview addSubview:showL];
    
}

- (void)creatViewWithAppointAlert
{
    UILabel *showL = [[UILabel alloc]initWithFrame:CGRectMake(20, _tipLable.frame.origin.y+_tipLable.frame.size.height, self.alertview.frame.size.width-40, self.alertview.frame.size.height-43-48)];
    [showL setTextColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0]];
    showL.numberOfLines = 0;
    [showL setFont:[UIFont systemFontOfSize:16]];
    
    [showL setText:_contentArr[0]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:showL.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:9];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, showL.text.length)];

    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(attributedString.length-7, 7)];
    showL.attributedText = attributedString;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(skiptoruler)];
    tap.numberOfTapsRequired = 1;
    [self.alertview addGestureRecognizer:tap];
    [self.alertview addSubview:showL];
    
}

- (void)appointInfoSelectPerson
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _tipLable.frame.origin.y+_tipLable.frame.size.height, self.alertview.frame.size.width, self.alertview.frame.size.height-CGRectGetHeight(self.tipLable.frame))];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.alertview addSubview:_tableView];
    
    
    //分割线
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
}
- (void)createBtnTitle:(NSArray *)titleArr
{

    CGFloat m = self.alertview.frame.size.width;
    
    for (int i=0; i<_numBtn; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (_numBtn == 1) {
            btn.frame = CGRectMake(20, self.alertview.frame.size.height-48,(m-40), 33);
            if (_type == 14) {
                btn.frame = CGRectMake(56.5, self.alertview.frame.size.height-48,(m-113), 34);
            }
            
        }else{
        
            btn.frame = CGRectMake(20+i*(20+(m-60)/2), self.alertview.frame.size.height-48, (m-60)/2, 33);
        }
        
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.tag = 100+i;
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        if ([titleArr[i] isEqualToString:@"退出"]||[titleArr[i] isEqualToString:@"确定"]||[titleArr[i] isEqualToString:@"退出页面"]||[titleArr[i] isEqualToString:@"否"]||[titleArr[i]isEqualToString:@"更新"]||[titleArr[i] isEqualToString:@"前往AppStore"]) {
            [btn setBackgroundColor:[UIColor colorWithRed:0/255.0 green:168/255.0 blue:255/255.0 alpha:1.0]];
        }else{
            
            [btn setBackgroundColor:[UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
        }
        [self.alertview addSubview:btn];
    }
}
- (void)blackClick
{
    [self cancleView];
}
- (void)cancleView
{

    [UIView animateWithDuration:0.2 animations:^{
        self.alertview.transform = CGAffineTransformScale(self.alertview.transform, 2.2f, 2.2f);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alertview = nil;
    }];

}
-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
}

-(void)clickButton:(UIButton *)button{
//    DLog(@"%ld",button.tag);
    if ([self.delegate respondsToSelector:@selector(didClickButtonAtIndex:password:row:)]) {
        if (_password == nil) {
            [self textFieldShouldEndEditing:_textF];
            [_textF resignFirstResponder];
        }
        if ([button.titleLabel.text isEqualToString:@"退出页面"]||[button.titleLabel.text isEqualToString:@"退出"]||[button.titleLabel.text isEqualToString:@"是"]||[button.titleLabel.text isEqualToString:@"前往AppStore"]) {
            button.tag = 101;
        }
        [self.delegate didClickButtonAtIndex:button.tag password:_password row:_row];
    }
    [self cancleView];
}
-(void)initWithTitle:(NSString *) title contentArr:(NSArray *)content type:(NSInteger)type btnNum:(NSInteger)btnNum btntitleArr:(NSArray *)btnTitleArr

{
    _title = title;
    _type = type;
    _numBtn = btnNum;
    _btnTitleArr = btnTitleArr;
    _contentArr = content;
    if (type == 15) {
        if (_selectBtnArray.count==0) {
            for (int i =0; i<_contentArr.count; i++) {
                [_selectBtnArray addObject:@(0)];
            }
        }
        
    }
    
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
   
//    DLog(@"%@",textField.text);
    _password = textField.text;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return YES;
}
- (void)skiptoruler
{

    if ([self.delegate respondsToSelector:@selector(skiptoRulervc)]) {
        [self.delegate skiptoRulervc];
        [self cancleView];
    }
}
#pragma mark--UITableViewDelegate/UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _contentArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"TWLAlertCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = _contentArr[indexPath.row];
    [cell.textLabel setFont:[UIFont systemFontOfSize:15.0]];
    [cell.textLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, WIDTH(self.alertview), 1.0)];
//    lineView.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
//    [cell.contentView addSubview:lineView];
    //添加按钮
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(CGRectGetWidth(self.alertview.frame)-37, 50/2-10, 20, 20);
    selectBtn.selected = [_selectBtnArray[indexPath.row] integerValue];
    if (selectBtn.selected) {
        _selectedBtn = selectBtn;
    }
    [selectBtn setImage:[UIImage imageNamed:@"chioce"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"chioceactive"] forState:UIControlStateSelected];
    selectBtn.tag = indexPath.row+200;
    [cell.contentView addSubview:selectBtn];

    return cell;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell1 = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIButton *btn=  (UIButton *)[cell1 viewWithTag:indexPath.row+200];
    NSInteger isSelect = [_selectBtnArray[indexPath.row] integerValue];
    [btn setSelected:isSelect];
    [_selectBtnArray removeAllObjects];
    for (int i =0; i<_contentArr.count; i++) {
        [_selectBtnArray addObject:@(0)];
    }
    if (btn.selected) {
        btn.selected = YES;
        _selecteName = _contentArr[btn.tag-200];;
    }else{
        _selectedBtn.selected = NO;
        [btn setSelected:YES];
        _selecteName = _contentArr[btn.tag-200];
    }
    
    [_selectBtnArray replaceObjectAtIndex:btn.tag-200 withObject:@(btn.selected)];
    if (_selectedBtn!=nil) {
        [_selectBtnArray replaceObjectAtIndex:_selectedBtn.tag-200 withObject:@(_selectedBtn.selected)];
    }
    _selectedBtn = btn;
    if (_delegate && [_delegate respondsToSelector:@selector(didClickButtonAtIndex:password:row:)]) {
        _row = indexPath.row;
        [self.delegate didClickButtonAtIndex:indexPath.row password:_selecteName row:indexPath.row];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
