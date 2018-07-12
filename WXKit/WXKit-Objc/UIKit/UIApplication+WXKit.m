//
//  UIApplication+WXKit.m
//  Defects
//
//  Created by Charlie Wu on 14/08/2015.
//  Copyright © 2015 WebFM Pty Ltd. All rights reserved.
//

@implementation UIApplication (WXKit)

+ (BOOL)isSmallDisplayMode {
    if ([UIDevice currentDeviceSystemVersion] < 8) {
        return [UIDevice isCurrentDeviceIphone];
    } else {
        return [[[[self sharedApplication] windows] firstObject] traitCollection].horizontalSizeClass == UIUserInterfaceSizeClassCompact;
    }

}

+ (BOOL)isLargeDisplayMode {
    if ([UIDevice currentDeviceSystemVersion] < 8) {
        return [UIDevice isCurrentDeviceIpad];
    } else {
        BOOL isHorizontalSizeClassRegular = [[[[self sharedApplication] windows] firstObject] traitCollection].horizontalSizeClass == UIUserInterfaceSizeClassRegular;
        return [UIDevice isCurrentDeviceIpad] && isHorizontalSizeClassRegular;
    }
}
@end
