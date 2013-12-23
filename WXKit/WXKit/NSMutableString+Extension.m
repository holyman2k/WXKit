//
//  NSMutableString+Extension.m
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import "NSMutableString+Extension.h"
#import "NSString+Extension.h"

@implementation NSMutableString (Extension)

- (void)trim
{
    NSCharacterSet *trimCharSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *string = [self stringByTrimmingCharactersInSet:trimCharSet];
    [self setString:string];
}
@end
