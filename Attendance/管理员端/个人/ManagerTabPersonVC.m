//
//  ManagerTabPersonVC.m
//  Attendance
//
//  Created by 涂欢 on 2017/2/20.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "ManagerTabPersonVC.h"
#import "LoginVC.h"
@interface ManagerTabPersonVC ()<UIGestureRecognizerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{

    NSInteger userid;
    UIImagePickerController *pickerController;
}
@property (weak, nonatomic) IBOutlet UILabel *accountL;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIButton *quitBtn;
- (IBAction)quitAction;

@end

@implementation ManagerTabPersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.accountL setText:@"admini"];
    
    _headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeStuHeadImage)];
    [_headImageView addGestureRecognizer:tap];
    _headImageView.layer.cornerRadius = CGRectGetWidth(_headImageView.frame)/2;
    _headImageView.clipsToBounds = YES;
    _quitBtn.layer.cornerRadius = 4;
    _quitBtn.clipsToBounds = YES;
    NSString *headImagePath = [[NSUserDefaults standardUserDefaults]objectForKey:@"adminiHeaderImage"];
    [_headImageView setImage:[UIImage imageNamed:@"testIcon"]];
    if (headImagePath&&headImagePath.length>0) {
        [_headImageView setImage:[self takepicture:@"adminiHeaderImage"]];
    }
    
    //初始化pickerController
    pickerController = [[UIImagePickerController alloc]init];
    pickerController.view.backgroundColor = [UIColor orangeColor];
    pickerController.delegate = self;
    pickerController.allowsEditing = YES;
}

- (void)changeStuHeadImage
{
    
    UIActionSheet *menu = [[UIActionSheet alloc]initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", @"图库", nil];
    menu.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [menu showInView:[UIApplication sharedApplication].keyWindow];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark--用户选中图片之后的回调
//用户选中图片之后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *userImage = [self fixOrientation:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    [pickerController dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *tempImage = [self makeThumbnailFromImage:userImage scale:0.7];
    [_headImageView setImage:userImage];
    //    NSString *imageName = [NSString stringWithFormat:@"%ld",_classId];
    [self saveImage:tempImage name:@"adminiHeaderImage"];
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
    NSUserDefaults *userDe = [NSUserDefaults standardUserDefaults];
    [userDe setObject:filePath forKey:@"adminiHeaderImage"];
    [userDe synchronize];
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
//沙盒路径取出照片(保存)
- (UIImage *)takepicture:(NSString *)string
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", string]];   // 保存文件的名称
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    return img;
}

- (IBAction)quitAction {
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"loginState"];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginVC *loginvc = [story instantiateViewControllerWithIdentifier:@"login"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginvc];
    [self presentViewController:nav animated:YES completion:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    //    [self.navigationController pushViewController:loginvc animated:YES];
}
@end
