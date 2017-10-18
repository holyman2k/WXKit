//
//  UIColor+WXKit.h
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WXKit)
+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(float)alpha;

- (NSString *)hexColor;
@end
