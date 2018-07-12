//
//  UIImage+WXKit.m
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

@implementation UIImage (WXKit)

- (instancetype)imageScaleToSize:(CGSize)size {
    CGFloat screenScale = [UIScreen mainScreen].scale;
    size = CGSizeMake(size.width * screenScale, size.height * screenScale);
    CGFloat scale = size.width / self.size.width;
    if (self.size.height * scale > size.height || self.size.width * scale > size.width) scale = size.height / self.size.height;
    UIImage *scaledImage = [UIImage imageWithCGImage:self.CGImage scale:1 / scale orientation:self.imageOrientation];
    return scaledImage;
}

- (instancetype)imageWithBorderWithColor:(UIColor *)color andThickness:(CGFloat)thickness {
    CGSize size = CGSizeMake(self.size.width, self.size.height);
    UIGraphicsBeginImageContext(size);

    CGPoint thumbPoint = CGPointMake(0, 0);

    [self drawAtPoint:thumbPoint];


    UIGraphicsBeginImageContext(size);
    CGImageRef imgRef = self.CGImage;
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width, size.height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    CGPoint starredPoint = CGPointMake(0, 0);
    [imageCopy drawAtPoint:starredPoint];
    UIImage *imageC = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageC;
}

+ (instancetype)imageOfSize:(CGSize)size withColor:(UIColor *)color {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
