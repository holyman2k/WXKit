//
//  UIDevice+WXKit.m
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import <sys/utsname.h>

@implementation UIDevice (WXKit)

- (NSString *)deviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

+ (NSString *)currentDeviceModel {
    return [[self currentDevice] deviceModel];
}

+ (CGFloat)currentDeviceSystemVersion {
    return [[self currentDevice] systemVersion].floatValue;
}

+ (BOOL)isCurrentDeviceIpad {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

+ (BOOL)isCurrentDeviceIphone {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}
@end

