//
//  NSString+Extension.m
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (BOOL)isEmptyOrNil:(NSString *)string
{
    return !string || (id)string == [NSNull null] || string.length == 0;
}

+ (BOOL)isEmptyOrNilOrOnlyWhiteSpace:(NSString *)string
{
    NSString *trimed = string.trim;
    
    return [NSString isEmptyOrNil:trimed];
}

- (NSString *)trim
{
    NSCharacterSet *trimCharSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:trimCharSet];
}

- (CGFloat)heightForFont:(UIFont *)font andWidth:(CGFloat)width
{
    NSDictionary *attributesDictionary = @{NSFontAttributeName: font};
    
    if ([UIDevice currentDevice].systemVersion.floatValue  < 7) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font constrainedToSize:CGSizeMake(width, FLT_MAX)].height;
        #pragma clang diagnostic pop
        
    } else {
        return [self boundingRectWithSize:CGSizeMake(width, FLT_MAX)
                                       options: NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributesDictionary
                                       context:nil].size.height;
    }
}

- (CGFloat)widthForFont:(UIFont *)font
{
    NSDictionary *attributesDictionary = @{NSFontAttributeName: font};
    
    if ([UIDevice currentDevice].systemVersion.floatValue  < 7) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font constrainedToSize:CGSizeMake(FLT_MAX, FLT_MAX)].width;
        #pragma clang diagnostic pop
        
    } else {
        return [self boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX)
                                  options: NSStringDrawingUsesLineFragmentOrigin
                               attributes:attributesDictionary
                                  context:nil].size.width;
    }
}
@end
