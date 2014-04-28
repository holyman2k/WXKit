//
//  UIDevice+WXKit.h
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (WXKit)

- (NSString *)deviceModel;

+ (NSString *)currentDeviceModel;

+ (CGFloat)currentDeviceSystemVersion;

+ (BOOL)isCurrentDeviceIpad;

+ (BOOL)isCurrentDeviceIphone;

@end
