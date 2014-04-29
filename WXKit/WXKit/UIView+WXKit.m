//
//  UIView+WXKit.m
//  Defects
//
//  Created by Charlie Wu on 29/04/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import "UIView+WXKit.h"

@implementation UIView (WXKit)

- (UIImage *)screenshot
{
    UIGraphicsBeginImageContext(self.bounds.size);
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();

    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

    return image;
}

@end
