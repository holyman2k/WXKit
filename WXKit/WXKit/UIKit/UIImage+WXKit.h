//
//  UIImage+WXKit.h
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WXKit)

- (instancetype)imageScaleToSize:(CGSize)size;

- (instancetype)imageWithBorderWithColor:(UIColor *)color andThickness:(CGFloat)thickness;

+ (instancetype)imageOfSize:(CGSize)size withColor:(UIColor *)color;

@end
