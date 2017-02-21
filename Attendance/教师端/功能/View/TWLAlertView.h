//
//  TWLAlertView.h
//  DefinedSelf
//
//  Created by 涂婉丽 on 15/12/15.
//  Copyright © 2015年 涂婉丽. All rights reserved.


#import <UIKit/UIKit.h>
@protocol TWlALertviewDelegate<NSObject>
@optional
-(void)didClickButtonAtIndex:(NSUInteger)index password:(NSString *)password row:(NSInteger)row;
- (void)successPassword;
- (void)skiptoRulervc;

@end
@interface TWLAlertView : UIView<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UIView *blackView;
@property (strong,nonatomic)UIView * alertview;
@property (strong,nonatomic)NSString * title;
@property (nonatomic,strong)NSArray *contentArr;
@property (nonatomic,strong)UILabel *tipLable;
@property (weak,nonatomic) id<TWlALertviewDelegate> delegate;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,assign)NSInteger numBtn;
@property (nonatomic,copy)NSString *password;
@property (nonatomic,retain)NSArray *btnTitleArr;
@property (nonatomic,retain)UITextField *textF;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,copy)NSString *selecteName;
@property (nonatomic,retain)UIButton *selectedBtn;
@property (nonatomic,assign)NSInteger row;
- (void)cancleView;
@property (nonatomic,strong)NSMutableArray *selectBtnArray;
-(void)initWithTitle:(NSString *) title contentArr:(NSArray *)content type:(NSInteger)type btnNum:(NSInteger)btnNum btntitleArr:(NSArray *)btnTitleArr;
@end
