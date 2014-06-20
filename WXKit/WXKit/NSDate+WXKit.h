//
//  NSDate+WXKit.h
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WXKit)

+ (instancetype)dateFromString:(NSString *)string withFormat:(NSString *)format;

+ (instancetype)dateFromJsonString:(NSString *)json;

- (NSString *)jsonString;

- (NSString *)dateStringShort;

- (NSString *)dateStringLong;

- (NSString *)dateTimeString;

- (NSString *)dateStringWithFormat:(NSString *)format;

- (instancetype)dateByWithoutTime;

@end
