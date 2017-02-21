//
//  TeaReserWorkVC.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "TeaReserWorkVC.h"
#import "TeaResetWorkDB.h"
@interface TeaReserWorkVC ()<UITextViewDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{

    UIImagePickerController *pickerController;
    NSString *nowdateStr;
    NSString *imagePath;
}
@property(nonatomic, strong)UITextView *textView;
@property(nonatomic, strong)UIButton *addBtn;
@property (nonatomic, strong)UILabel *classNameL;
@property (nonatomic, strong)UILabel *tipL;
@property (nonatomic, strong)teaWorkModel *model;
@end

@implementation TeaReserWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if (_isteacher) {
        self.title = @"布置作业";
    }else{
    
        self.title = @"作业详情";
    }
    
    _model = [[teaWorkModel alloc]init];
    _classNameL = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 30)];
    [_classNameL setFont:[UIFont systemFontOfSize:15]];
    [_classNameL setTextColor:[UIColor darkGrayColor]];
    [_classNameL setText:_classname];
    [_classNameL setBackgroundColor:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0]];
    [_classNameL setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_classNameL];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_classNameL.frame)+10, [UIScreen mainScreen].bounds.size.width-20, 200)];
    _textView.delegate = self;
    _textView.layer.borderColor = [UIColor colorWithRed:0 green:168/255.0 blue:1.0 alpha:1.0].CGColor;
    _textView.layer.borderWidth = 1;
    _textView.layer.cornerRadius = 4;
    _textView.clipsToBounds = YES;
    _textView.returnKeyType = UIReturnKeyDone;
    [_textView setFont:[UIFont systemFontOfSize:15]];
    [_textView setTextColor:[UIColor darkGrayColor]];
    [self.view addSubview:_textView];
    if (!_isteacher) {
        [_textView setText:_workModel.workContent];
        if (!_ismanager) {
            _textView.editable = NO;
        }
    }
    _tipL = [[UILabel alloc]initWithFrame:CGRectMake(12, 5, 200, 25)];
    [_tipL setText:[NSString stringWithFormat:@"请输入%@题",_classNameL.text]];
    [_tipL setFont:[UIFont systemFontOfSize:13]];
    [_tipL setTextColor:[UIColor lightGrayColor]];
    [_textView addSubview:_tipL];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(15, CGRectGetMaxY(_textView.frame)+15, 70, 70);
    [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(choosePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
    if (!_isteacher) {
        _tipL.hidden = YES;
        if (_workModel.photopath&&_workModel.photopath.length>0) {
            if ([self takepicture:_workModel.nowdateStr]) {
                [_addBtn setImage:[self takepicture:_workModel.nowdateStr] forState:UIControlStateNormal];
            }
            
            if (!_ismanager) {
                _addBtn.userInteractionEnabled = NO;
            }
        }else{
            if (!_ismanager) {
                _addBtn.hidden = YES;
            }
            
        }
        
    }
    if (_ismanager||_isteacher) {
        
        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        editButton.frame = CGRectMake(0,0,80,40);
        [editButton setTitle:@"发布作业" forState:UIControlStateNormal];
        [editButton setTitleColor:[UIColor colorWithRed:0 green:168/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        editButton.titleLabel.font = [UIFont systemFontOfSize:14];
        editButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [editButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem             = [[UIBarButtonItem alloc]initWithCustomView:editButton];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
    //初始化pickerController
    pickerController = [[UIImagePickerController alloc]init];
    pickerController.view.backgroundColor = [UIColor orangeColor];
    pickerController.delegate = self;
    pickerController.allowsEditing = YES;
    
    _model.classname = _classname;
    _model.classId = @(_classId);
    _model.teacher_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"teacher_id"];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateStyle:NSDateFormatterMediumStyle];
    [formatter2 setTimeStyle:NSDateFormatterShortStyle];
    [formatter2 setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    nowdateStr = [formatter2 stringFromDate:[NSDate date]];
    _model.nowdateStr = nowdateStr;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if (textView.text.length==0) {
            self.tipL.hidden = NO;
        }
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        self.tipL.hidden = YES;
        if (_ismanager) {
            _workModel.workContent = textView.text;
        }
        _model.workContent = textView.text;
    }else{
        
        self.tipL.hidden = NO;
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
- (void)saveAction
{
    //签到
    NSString *wrongStr = @"保存成功";
    if (_textView.text.length == 0) {
        wrongStr = @"请输入题目";
        return;
    }
    if (!_ismanager) {
        [[TeaResetWorkDB shareTeaWork]student_insertWorkData:_model];
    }else{
    
        [[TeaResetWorkDB shareTeaWork]student_updateworkData:_workModel];
        
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:wrongStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
    [_addBtn setImage:userImage forState:UIControlStateNormal];
    //    NSString *imageName = [NSString stringWithFormat:@"%ld",_classId];
    if (_ismanager) {
        [self saveImage:tempImage name:_workModel.nowdateStr];
    }else{
        [self saveImage:tempImage name:nowdateStr];
    }
    
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
    _model.photopath = filePath;
    if (_ismanager) {
        _workModel.photopath = filePath;
    }
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
