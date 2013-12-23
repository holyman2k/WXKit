//
//  NSString+Extension.m
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

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
        return [self sizeWithFont:font constrainedToSize:CGSizeMake(width, FLT_MAX)].width;
        #pragma clang diagnostic pop
        
    } else {
        return [self boundingRectWithSize:CGSizeMake(width, FLT_MAX)
                                       options: NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributesDictionary
                                       context:nil].size.width;
    }
}

- (CGFloat)widthForFont:(UIFont *)font andHeight:(CGFloat)height
{
    NSDictionary *attributesDictionary = @{NSFontAttributeName: font};
    
    if ([UIDevice currentDevice].systemVersion.floatValue  < 7) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font constrainedToSize:CGSizeMake(FLT_MAX, height)].width;
        #pragma clang diagnostic pop
        
    } else {
        return [self boundingRectWithSize:CGSizeMake(FLT_MAX, height)
                                  options: NSStringDrawingUsesLineFragmentOrigin
                               attributes:attributesDictionary
                                  context:nil].size.width;
    }
}
@end
