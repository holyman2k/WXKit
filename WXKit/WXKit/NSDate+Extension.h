//
//  NSDate+Extension.h
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;

+ (NSDate *)dateFromJsonString:(NSString *)json;

- (NSString *)jsonString;

- (NSString *)dateStringShort;

- (NSString *)dateStringLong;

- (NSString *)dateTimeString;

- (NSString *)dateToString:(NSString *)format;


@end
