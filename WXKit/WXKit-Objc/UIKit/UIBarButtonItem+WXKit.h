//
//  UIBarButtonItem+WXKit.h
//  Defects
//
//  Created by Charlie Wu on 21/07/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WXKit)

+ (instancetype)flexibleSpace;
+ (instancetype)fixedSpaceOfWidth:(CGFloat)width;
+ (instancetype)plainBarButtonItemWithTitle:(NSString *)title;
+ (instancetype)doneBarButtonItemWithTitle:(NSString *)title;
+ (instancetype)borderedBarButtonItemWithTitle:(NSString *)title;
+ (instancetype)barButtonItemWithTitle:(NSString *)title andStyle:(UIBarButtonItemStyle)style;
+ (instancetype)barButtonItemWithImage:(UIImage *)image andStyle:(UIBarButtonItemStyle)style;
@end
