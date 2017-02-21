

//弹出气泡视图

//点击更多弹出气泡视图
#import <UIKit/UIKit.h>

@protocol MoreViewDelegate <NSObject>
//点击单元格
-(void)didSelectTableViewCellIndex:(NSInteger)index;

@end

@interface MoreView : UIView<UITableViewDataSource,UITableViewDelegate>
//弹出视图
@property(retain,nonatomic) UIImageView *popView;
//弹出视图中的表视图
@property(retain,nonatomic) UITableView *tableView;
//文字数组
@property (nonatomic,strong)NSArray *titleArr;
@property(retain,nonatomic) id<MoreViewDelegate>delegate;
@end
