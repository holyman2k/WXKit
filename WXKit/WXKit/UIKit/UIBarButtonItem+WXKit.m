//
//  UIBarButtonItem+WXKit.m
//  Defects
//
//  Created by Charlie Wu on 21/07/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import "UIBarButtonItem+WXKit.h"

@implementation UIBarButtonItem (WXKit)

+ (instancetype)flexibleSpace
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

+ (instancetype)fixedSpaceOfWidth:(CGFloat)width
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item.width = width;
    return item;
}

+ (instancetype)plainBarButtonItemWithTitle:(NSString *)title
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [[UIBarButtonItem alloc] initWithTitle:title
                                            style:[UIDevice currentDeviceSystemVersion] < 7 ? UIBarButtonItemStyleBordered : UIBarButtonItemStylePlain
                                           target:nil
                                           action:nil];
#pragma clang diagnostic pop
}

+ (instancetype)borderedBarButtonItemWithTitle:(NSString *)title
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [[UIBarButtonItem alloc] initWithTitle:title
                                            style:[UIDevice currentDeviceSystemVersion] < 7 ? UIBarButtonItemStyleBordered : UIBarButtonItemStylePlain
                                           target:nil
                                           action:nil];
#pragma clang diagnostic pop
}

+ (instancetype)doneBarButtonItemWithTitle:(NSString *)title
{
    return [[UIBarButtonItem alloc] initWithTitle:title
                                            style:UIBarButtonItemStyleDone
                                           target:nil
                                           action:nil];
}

+ (instancetype)barButtonItemWithTitle:(NSString *)title andStyle:(UIBarButtonItemStyle)style
{
    return [[UIBarButtonItem alloc] initWithTitle:title
                                            style:style
                                           target:nil
                                           action:nil];
}
@end
