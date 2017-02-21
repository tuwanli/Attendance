//
//  StudentSignVC.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/15.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "StudentSignVC.h"
#import "SignModel.h"
#import "StudentSignDB.h"
#import "TWLAlertView.h"
static NSString *cell_identifer = @"cell_identifer";
@interface StudentSignVC ()<UIGestureRecognizerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TWlALertviewDelegate>
{

    UIImagePickerController *pickerController;
    CGFloat tabH;
    TWLAlertView *alertView;
    NSString *stuname;
    UIButton *selectBtn;
    NSString *timeStr;
}
@property (nonatomic, strong)UIButton *imageBtn;
@property (nonatomic, strong)SignModel *model;
@property (nonatomic, copy)NSString *imagePath;
@property (nonatomic, strong)NSMutableArray *studenStrArr;
@property (nonatomic, strong)NSMutableArray *studenArr;
@end

@implementation StudentSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _imagePath = @"";
    // Do any additional setup after loading the view.
    _studenArr = [[NSMutableArray alloc]init];
    _studenStrArr = [[NSMutableArray alloc]init];
    [self.view setBackgroundColor:[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0]];
    _model = [[SignModel alloc]init];
    //照片
    _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageBtn.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2-70, 130, 140, 140);
    _imageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_imageBtn setTitle:@"选择图片" forState:UIControlStateNormal];
    [_imageBtn setTitleColor:[UIColor colorWithRed:0 green:168/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    _imageBtn.layer.cornerRadius = 70;
    [_imageBtn setBackgroundColor:[UIColor whiteColor]];
    _imageBtn.clipsToBounds = YES;
    [_imageBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_imageBtn addTarget:self action:@selector(choosePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_imageBtn];
    
    UILabel *classLable = [[UILabel alloc]initWithFrame:CGRectMake(_imageBtn.frame.origin.x-15, CGRectGetMaxY(_imageBtn.frame)+30, CGRectGetWidth(_imageBtn.frame)+30, 40)];
    classLable.layer.cornerRadius = 8;
    classLable.clipsToBounds = YES;
    [classLable setFont:[UIFont systemFontOfSize:13]];
    [classLable setTextColor:[UIColor darkGrayColor]];
    [classLable setTextAlignment:NSTextAlignmentCenter];
    [classLable setText:_classname];
    [classLable setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:classLable];
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(classLable.frame)+12, CGRectGetWidth(self.view.frame), 40)];
    [time setTextAlignment:NSTextAlignmentCenter];
    [time setTextColor:[UIColor grayColor]];
    [time setFont:[UIFont systemFontOfSize:13]];
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateStyle:NSDateFormatterMediumStyle];
    [formatter2 setTimeStyle:NSDateFormatterShortStyle];
    [formatter2 setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime2 = [formatter2 stringFromDate:date];
    [time setText:DateTime2];
    [self.view addSubview:time];
    timeStr = DateTime2;
    if (_teaSignModel.createTime&&_teaSignModel.createTime.length>0) {
        [time setText:_teaSignModel.createTime];
        timeStr = _teaSignModel.createTime;
    }
    if (_isteacher) {
        if (_ismodify) {
            _model = _teaSignModel;
            _imagePath = _teaSignModel.photopath;
        }else{
            _model.classId = @(_classId);
            _model.className = _classname;
            _model.createTime = timeStr;
        }
    }else{
    
        _model.student_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"studen_id"];
        _model.classId = @(_classId);
        _model.className = _classname;
        _model.createTime = timeStr;
    }
    selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_isteacher) {
        selectBtn.frame = CGRectMake(classLable.frame.origin.x-20, CGRectGetMaxY(time.frame), CGRectGetWidth(classLable.frame)+40, 40);
        if (_stumodel.student_name) {
            [selectBtn setTitle:_stumodel.student_name forState:UIControlStateNormal];
        }else{
            [selectBtn setTitle:@"选择学生" forState:UIControlStateNormal];
        }
        [selectBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        selectBtn.layer.borderWidth  =1;
        selectBtn.layer.borderColor = [UIColor colorWithRed:0 green:168/255.0 blue:1.0 alpha:1.0].CGColor;
        
        selectBtn.layer.cornerRadius = 8;
        selectBtn.clipsToBounds = YES;
        [selectBtn setTitleColor:[UIColor colorWithRed:0 green:168/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [selectBtn addTarget:self action:@selector(selectstuAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectBtn];
        
    }
    
    UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_isteacher) {
        signBtn.frame = CGRectMake(classLable.frame.origin.x-20, CGRectGetMaxY(selectBtn.frame)+20, CGRectGetWidth(classLable.frame)+40, 45);
    }else{
    
        signBtn.frame = CGRectMake(classLable.frame.origin.x-20, CGRectGetMaxY(time.frame), CGRectGetWidth(classLable.frame)+40, 45);
    }
    
    [signBtn setBackgroundColor:[UIColor colorWithRed:0 green:168/255.0 blue:1.0 alpha:1.0]];
    signBtn.layer.cornerRadius = 8;
    signBtn.clipsToBounds = YES;
    [signBtn setTitle:@"签到" forState:UIControlStateNormal];
    [signBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signBtn addTarget:self action:@selector(sginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signBtn];
    
    if (_isteacher) {
        
        [_imageBtn setImage:[self takepicture:[NSString stringWithFormat:@"%@",_teaSignModel.createTime]] forState:UIControlStateNormal];
        [signBtn setTitle:@"保存签到" forState:UIControlStateNormal];
        
        
    }
    
    //初始化pickerController
    pickerController = [[UIImagePickerController alloc]init];
    pickerController.view.backgroundColor = [UIColor orangeColor];
    pickerController.delegate = self;
    pickerController.allowsEditing = YES;
    
    
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    [[StudentFMDBManager shareStudent]student_getData:tempArr];
    _studenArr = tempArr;
    for (int i=0; i<tempArr.count; i++) {
        StudentModel *model = tempArr[i];
        [_studenStrArr addObject:model.student_name];
    }
}

- (void)selectstuAction:(UIButton *)btn
{
    if (alertView) {
        [alertView removeFromSuperview];
        alertView = nil;
    }
    alertView = [[TWLAlertView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    [alertView initWithTitle:@"选择学生" contentArr:_studenStrArr type:15 btnNum:2 btntitleArr:[NSArray arrayWithObjects:@"取消",@"确定", nil]];
    alertView.tag = 220;
    alertView.delegate = self;
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview: alertView];
}
- (void)didClickButtonAtIndex:(NSUInteger)index password:(NSString *)password row:(NSInteger)row
{
    if (password&&password.length>0) {
        stuname = password;
        if (stuname&&stuname.length>0) {
            [selectBtn setTitle:stuname forState:UIControlStateNormal];
            StudentModel *model = _studenArr[row];
            _model.student_id = model.student_id;
            
        }
    }
    if (index == 101) {//确定
        if (stuname&&stuname.length>0) {
            [selectBtn setTitle:stuname forState:UIControlStateNormal];
            StudentModel *model = _studenArr[row];
            _model.student_id = model.student_id;
            
        }else{
            
        }
        
    }
    
    
}
//沙盒路径取出照片(保存)
- (UIImage *)takepicture:(NSString *)string
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", string]];   // 保存文件的名称
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    return img;
}
- (void)choosePhoto
{

    UIActionSheet *menu = [[UIActionSheet alloc]initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", @"图库", nil];
    menu.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [menu showInView:[UIApplication sharedApplication].keyWindow];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            [self makePhoto];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在设置-->隐私-->相机，中开启本应用的相机访问权限！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"我知道了", nil];
            [alert show];
        }
    }else if (buttonIndex == 1){//相片
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            [self choosePicture];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在设置-->隐私-->照片，中开启本应用的相册访问权限！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"我知道了", nil];
            [alert show];
        }
    }
    else if (buttonIndex == 2){
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            [self pictureLibrary];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在设置-->隐私-->照片，中开启本应用的图库访问权限！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"我知道了", nil];
            [alert show];
        }
    }
    else
    {
        
    }
}

//跳转到imagePicker里
- (void)makePhoto
{
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:pickerController animated:YES completion:nil];
}
//跳转到相册
- (void)choosePicture
{
    pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:pickerController animated:YES completion:nil];
}
//跳转图库
- (void)pictureLibrary
{
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerController animated:YES completion:nil];
}
- (void)sginAction:(UIButton *)btn
{
    //签到
    NSString *wronsStr = @"请选择图片";
    if (_isteacher) {
        if (_imagePath.length>0) {
            wronsStr = @"保存签到成功";
            if (_ismodify) {
                [[StudentSignDB shareStudentSign]student_updateSignData:_model];
            }else{
                [[StudentSignDB shareStudentSign]student_insertSignData:_model];
            }
            
            
        }
    }else{
        if (_imagePath.length>0) {
            wronsStr = @"签到成功";
            [[StudentSignDB shareStudentSign]student_insertSignData:_model];
            
        }
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:wronsStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}
#pragma mark--用户选中图片之后的回调
//用户选中图片之后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *userImage = [self fixOrientation:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    [pickerController dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *tempImage = [self makeThumbnailFromImage:userImage scale:0.7];
    [_imageBtn setImage:userImage forState:UIControlStateNormal];
//    NSString *imageName = [NSString stringWithFormat:@"%ld",_classId];
    [self saveImage:tempImage name:timeStr];
}
//修改图像的尺寸
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark--保存照片到沙盒路径(保存)
//保存照片到沙盒路径(保存)
- (void)saveImage:(UIImage *)image name:(NSString *)iconName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //写入文件
    NSString *icomImage = iconName;
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", icomImage]];
    _imagePath = filePath;
    _model.photopath = filePath;
    // 保存文件的名称
    //    [[self getDataByImage:image] writeToFile:filePath atomically:YES];
    [UIImagePNGRepresentation(image)writeToFile: filePath  atomically:YES];
}

//修正照片方向(手机转90度方向拍照)
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
- (UIImage *)makeThumbnailFromImage:(UIImage *)srcImage scale:(double)imageScale {
    
    UIImage *thumbnail = nil;
    
    
    CGSize imageSize = CGSizeMake(srcImage.size.width * imageScale, srcImage.size.height * imageScale);
    
    if (srcImage.size.width != imageSize.width || srcImage.size.height != imageSize.height)
        
    {
        
        UIGraphicsBeginImageContext(imageSize);
        
        CGRect imageRect = CGRectMake(-4, -4, imageSize.width+8, imageSize.height+8);
        
        [srcImage drawInRect:imageRect];
        
        thumbnail = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
    else
        
    {
        thumbnail = srcImage;
    }
    return thumbnail;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
