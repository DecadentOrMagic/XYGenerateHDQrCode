//
//  ViewController.m
//  XYGenerateHDQrCode
//
//  Created by 薛尧 on 15/9/7.
//  Copyright © 2015年 薛尧. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -- 生成二维码的 button点击事件
- (IBAction)productCodeBtnDidClicked:(id)sender {
    
    /* 1.创建过滤器对象 */
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    NSString *str = self.textField.text;
    /* 2.转成二进制对象 */
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    /* 3.把所要操作的二进制对象赋值给过滤器  */
    [filter setValue:data forKey:@"inputMessage"];
    /* 4.取出二维码图片 */
    CIImage *image = [filter outputImage];
    
    // 创建底板,绘制图片的底板
    CGColorSpaceRef csf = CGColorSpaceCreateDeviceGray();
    // 所要绘制图片的配置信息
    CGContextRef ref = CGBitmapContextCreate(nil, 200, 200, 8, 0, csf, kCGImageAlphaNone);
    // 创建绘制图片的上下文
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:image fromRect:image.extent];
    // 上下文采用默认配置
    CGContextSetInterpolationQuality(ref, kCGInterpolationNone);
    // 绘制图片
    CGContextDrawImage(ref, self.twoImageView.bounds, imageRef);
    
    //最后取出制作完成的图片
    CGImageRef lastImage = CGBitmapContextCreateImage(ref);
    
    /* 5.赋值 */
    self.twoImageView.image = [UIImage imageWithCGImage:lastImage];
    
    
    
    
    
}

@end
