//
//  UIColor+WXKit.m
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

@implementation UIColor (WXKit)

+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(float)alpha {
    if (hexString.length > 0 && [hexString characterAtIndex:0] == '#') hexString = [hexString substringFromIndex:1];
    if (hexString.length != 6) {
        return nil;
    }

    // Brutal and not-very elegant test for non hex-numeric characters
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-fA-F|0-9]" options:0 error:NULL];
    NSUInteger match = [regex numberOfMatchesInString:hexString options:NSMatchingReportCompletion range:NSMakeRange(0, [hexString length])];

    if (match != 0) {
        return nil;
    }

    NSRange redRange = NSMakeRange(0, 2);
    NSString *redComponent = [hexString substringWithRange:redRange];
    unsigned int redValue = 0;
    NSScanner *redScanner = [NSScanner scannerWithString:redComponent];
    [redScanner scanHexInt:&redValue];
    float redPercentageValue = (float) redValue / 254;


    NSRange greenRange = NSMakeRange(2, 2);
    NSString *greenComponent = [hexString substringWithRange:greenRange];
    unsigned int greenValue = 0;
    NSScanner *greenScanner = [NSScanner scannerWithString:greenComponent];
    [greenScanner scanHexInt:&greenValue];
    float greenPercentageValue = (float) greenValue / 254;

    NSRange blueRange = NSMakeRange(4, 2);
    NSString *blueComponent = [hexString substringWithRange:blueRange];
    unsigned int blueValue = 0;
    NSScanner *blueScanner = [NSScanner scannerWithString:blueComponent];
    [blueScanner scanHexInt:&blueValue];
    float bluePercentageValue = (float) blueValue / 254;

    return [UIColor colorWithRed:redPercentageValue green:greenPercentageValue blue:bluePercentageValue alpha:alpha];
}

- (NSString *)hexColor {
    const CGFloat *components = CGColorGetComponents(self.CGColor);

    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];

    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
                                      lroundf(r * 255),
                                      lroundf(g * 255),
                                      lroundf(b * 255)];
}

@end
