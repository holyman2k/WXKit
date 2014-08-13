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

@end
