//
//  NSDate+WXKit.m
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

@implementation NSDate (WXKit)

+ (instancetype)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat dateFromString:string];
}

+ (instancetype)dateFromJsonString:(NSString *)json {
    static NSDateFormatter *dateFormat;
    static dispatch_once_t dateFormatOnceToken;
    dispatch_once(&dateFormatOnceToken, ^{
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"];
    });
    return [dateFormat dateFromString:json];
}

- (NSString *)jsonDateTimeString {
    static NSDateFormatter *dateFormat;
    static dispatch_once_t dateFormatOnceToken;
    dispatch_once(&dateFormatOnceToken, ^{
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"];
    });
    return [dateFormat stringFromDate:self];
}

- (NSString *)jsonDateString {
    static NSDateFormatter *dateFormat;
    static dispatch_once_t dateFormatOnceToken;
    dispatch_once(&dateFormatOnceToken, ^{
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy'-'MM'-'dd"];
    });
    return [dateFormat stringFromDate:self];
}


- (NSString *)dateStringShort {
    static NSDateFormatter *dateFormat;
    static dispatch_once_t dateFormatOnceToken;
    dispatch_once(&dateFormatOnceToken, ^{
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMM d"];
    });
    return [dateFormat stringFromDate:self];
}

- (NSString *)dateStringLong {
    static NSDateFormatter *dateFormat;
    static dispatch_once_t dateFormatOnceToken;
    dispatch_once(&dateFormatOnceToken, ^{
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMM dd, yyyy"];
    });
    return [dateFormat stringFromDate:self];
}

- (NSString *)dateTimeString {
    static NSDateFormatter *dateFormat;
    static dispatch_once_t dateFormatOnceToken;
    dispatch_once(&dateFormatOnceToken, ^{
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMM dd, yyyy h:mm a"];
    });
    return [dateFormat stringFromDate:self];
}

- (NSString *)dateStringWithFormat:(NSString *)format {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:self];
}

- (instancetype)dateWithoutTime {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSCalendarUnit unit = [UIDevice currentDeviceSystemVersion] < 8 ? NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit : NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:unit fromDate:self];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
#pragma clang diagnostic pop
}

- (instancetype)startOfTheDay {
    return [self dateWithoutTime];
}
@end
