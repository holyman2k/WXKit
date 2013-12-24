//
//  NSString+Extension.h
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

+ (BOOL)isEmptyOrNil:(NSString *)string;

+ (BOOL)isEmptyOrNilOrOnlyWhiteSpace:(NSString *)string;

- (NSString *)trim;

- (CGFloat)heightForFont:(UIFont *)font andWidth:(CGFloat)width;

- (CGFloat)widthForFont:(UIFont *)font;

@end
