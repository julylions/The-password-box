//
//  CupView.m
//  图片剪裁Test2
//
//  Created by change009 on 16/2/22.
//  Copyright © 2016年 change009. All rights reserved.
//

#import "CupView.h"

//#import "UIImage+Rotaion.h"

#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height


#define ORIGINAL_MAX_WIDTH 640.0f


@interface CupView()
@property(nonatomic,strong)CAShapeLayer *vertulLineLayer;
@property(nonatomic,strong)CAShapeLayer *fillLayer;

@end

@implementation CupView
-(instancetype)initWithFrame:(CGRect)frame inset:(UIEdgeInsets)inset{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self configer:frame];
        
    }
    return self;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self configer:frame];
        
    }
    return self;
    
}

//初始化
- (void)configer:(CGRect)rect{
    
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
    self.lineWidth = 1;
    self.lineColor = [UIColor clearColor];
    self.cupBezPath.lineWidth = self.lineWidth;
    CGFloat width = kScreenWidth-40;
    CGFloat height = width*54/85.6;
    CGFloat top = 0;
    CGFloat bottom =0;
    self.WillCupRect = CGRectMake(20, top+(rect.size.height-height-bottom-top-80)/2.0, width, height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) cornerRadius:0];
    
    self.cupBezPath = [UIBezierPath bezierPathWithRoundedRect:self.WillCupRect cornerRadius:0];
    
    [path appendPath:_cupBezPath];
    
    [path setUsesEvenOddFillRule:YES];
    [_fillLayer removeFromSuperlayer];
    _fillLayer = [CAShapeLayer layer];
    
    _fillLayer.path = path.CGPath;
    
    //中间透明
    _fillLayer.fillRule = kCAFillRuleEvenOdd;
    //半透明效果
    _fillLayer.fillColor = [UIColor colorWithWhite:0.200 alpha:0.800].CGColor;
    
    [self.layer addSublayer:_fillLayer];
    
    [_vertulLineLayer removeFromSuperlayer];
    //绘制虚线边框
    _vertulLineLayer = [CAShapeLayer layer];
    
    _vertulLineLayer.path = self.cupBezPath.CGPath;
    _vertulLineLayer.strokeColor = [UIColor whiteColor].CGColor;
    _vertulLineLayer.fillColor = [UIColor clearColor].CGColor;
    _vertulLineLayer.lineCap = kCALineCapRound;
    _vertulLineLayer.lineWidth = 1;
    //    vertulLineLayer.lineDashPattern = @[@8,@8];
    [self.layer addSublayer:_vertulLineLayer];

}
//
//- (void)drawRect:(CGRect)rect {
//
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) cornerRadius:0];
//
//    self.cupBezPath = [UIBezierPath bezierPathWithRoundedRect:self.WillCupRect cornerRadius:0];
//
//    [path appendPath:_cupBezPath];
//
//    [path setUsesEvenOddFillRule:YES];
//    [_fillLayer removeFromSuperlayer];
//    _fillLayer = [CAShapeLayer layer];
//
//    _fillLayer.path = path.CGPath;
//
//    //中间透明
//    _fillLayer.fillRule = kCAFillRuleEvenOdd;
//    //半透明效果
//    _fillLayer.fillColor = [UIColor colorWithWhite:0.200 alpha:0.800].CGColor;
//
//    [self.layer addSublayer:_fillLayer];
//
//    [_vertulLineLayer removeFromSuperlayer];
//    //绘制虚线边框
//    _vertulLineLayer = [CAShapeLayer layer];
//
//    _vertulLineLayer.path = self.cupBezPath.CGPath;
//    _vertulLineLayer.strokeColor = [UIColor whiteColor].CGColor;
//    _vertulLineLayer.fillColor = [UIColor clearColor].CGColor;
//    _vertulLineLayer.lineCap = kCALineCapRound;
//    _vertulLineLayer.lineWidth = 1;
////    vertulLineLayer.lineDashPattern = @[@8,@8];
//    [self.layer addSublayer:_vertulLineLayer];
//
//}

//- (UIImage *)clipImageWithSoucreImageView:(UIImageView *)imageView{
//    
//    CGRect foreCupRect = CGRectMake((KWidth-KCupWidth)/2, (KHeight-KCupHeight)/2, KCupWidth, KCupHeight);
//    
//    CGRect soucreRect = imageView.frame;
//    
//    UIImage *soucreImage = imageView.image;
//    
//    float zoomScale = [[imageView.layer valueForKeyPath:@"transform.scale.x"] floatValue];
//    float rotate = [[imageView.layer valueForKeyPath:@"transform.rotation.z"] floatValue];
//    
//    float _imageScale = soucreImage.size.width / KCupWidth;
//
//    
//    CGSize cropSize = CGSizeMake((foreCupRect.size.width)/zoomScale, (foreCupRect.size.height)/zoomScale);
//    
//    CGPoint cropperViewOrigin = CGPointMake((foreCupRect.origin.x - soucreRect.origin.x)/zoomScale,
//                                            (foreCupRect.origin.y - soucreRect.origin.y)/zoomScale);
//    
//    if((NSInteger)cropSize.width % 2 == 1)
//    {
//        cropSize.width = ceil(cropSize.width);
//    }
//    if((NSInteger)cropSize.height % 2 == 1)
//    {
//        cropSize.height = ceil(cropSize.height);
//    }
//    
//    
//    CGRect CropRectinImage = CGRectMake((NSInteger)(cropperViewOrigin.x)*_imageScale/2 ,(NSInteger)( cropperViewOrigin.y)*_imageScale/2, (NSInteger)(cropSize.width)*_imageScale/2,(NSInteger)(cropSize.height)*_imageScale/2);
//    
//    UIImage *rotInputImage = [soucreImage imageRotatedByRadians:rotate];
//    
//    CGImageRef tmp = CGImageCreateWithImageInRect([rotInputImage CGImage], CropRectinImage);
//    UIImage *resultImage = [UIImage imageWithCGImage:tmp scale:soucreImage.scale orientation:soucreImage.imageOrientation];
//    
//    if (!resultImage) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您剪切的区域无效，请重新剪切" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        return nil;
//    }
//    
//    CGRect imageRect = CGRectZero;
//    imageRect.size = resultImage.size;
//    
//    UIBezierPath *cupedPath;
//    UIGraphicsBeginImageContextWithOptions(imageRect.size, YES, 0.0);
//    {
//        [[UIColor blackColor] setFill];
//        UIRectFill(imageRect);
//        
//        [[UIColor whiteColor] setFill];
//        cupedPath = [UIBezierPath bezierPathWithOvalInRect:imageRect];
//        [cupedPath fill];
//    }
//    UIImage *maskImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    
//    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, 0.0);
//    {
//        CGContextClipToMask(UIGraphicsGetCurrentContext(), imageRect, maskImage.CGImage);
//        [resultImage drawAtPoint:CGPointZero];
//    }
//    UIImage *maskResultImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return maskResultImage;
//    
//}
//
//
///* 图片规定大小 */
//- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
//    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
//    CGFloat btWidth = 0.0f;
//    CGFloat btHeight = 0.0f;
//    if (sourceImage.size.width > sourceImage.size.height) {
//        btHeight = ORIGINAL_MAX_WIDTH;
//        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
//    } else {
//        btWidth = ORIGINAL_MAX_WIDTH;
//        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
//    }
//    CGSize targetSize = CGSizeMake(btWidth, btHeight);
//    
//    return [self scaleToSize:sourceImage size:targetSize];
//}
//
///*  去除图片本身自带方向 */
//- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    UIGraphicsBeginImageContext(size);
//    // 绘制改变大小的图片
//    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    // 从当前context中创建一个改变大小后的图片
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//    // 返回新的改变大小后的图片
//    return scaledImage;
//}

@end
