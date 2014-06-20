//
//  WXDate.m
//  WXKit
//
//  Created by Charlie Wu on 24/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+WXKit.h"

@interface WXDate : XCTestCase

@end

@implementation WXDate

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testDateJSON
{
    NSTimeInterval timestamp = 1387846784;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];   // Dec 24 2013, 11:59:44 am
    
    XCTAssertEqualObjects(date.jsonString, @"2013-12-24T11:59:44Z", @"equal json date");
    XCTAssertNotEqualObjects(date.jsonString, @"2012-12-24T11:59:44Z", @"not equal json date");
    
    NSDate *dateFromJSON = [NSDate dateFromJsonString:@"2013-12-24T11:59:44Z"];
    XCTAssertEqualObjects(dateFromJSON, date, "convert json back to date");
    XCTAssertNotEqualObjects(dateFromJSON, [NSDate dateWithTimeIntervalSince1970:timestamp + 1], "convert json back to date");
}

- (void)testDateToStringLong
{
    NSTimeInterval timestamp = 1387846784;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];   // Dec 24 2013, 11:59:44 am
    
    XCTAssertEqualObjects(date.dateStringLong, @"Dec 24, 2013", @"long date string");
    XCTAssertNotEqualObjects(date.dateStringLong, @"Dec 23, 2013", @"not equal short date");
}

- (void)testDateToStringShort
{
    NSTimeInterval timestamp = 1387846784;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];   // Dec 24 2013, 11:59:44 am]
    
    XCTAssertEqualObjects(date.dateStringShort, @"Dec 24", @"short date string");
    XCTAssertNotEqualObjects(date.dateStringLong, @"Dec 23", @"not equal short date");
}


- (void)testDateTimeTostring
{
    NSTimeInterval timestamp = 1387846784;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];   // Dec 24 2013, 11:59:44 am]
    
    XCTAssertEqualObjects(date.dateTimeString, @"Dec 24, 2013 11:59 AM", @"datetime string");
    XCTAssertNotEqualObjects(date.dateStringLong, @"Dec 23, 2013 11:59 AM", @"not equal datetimeß date");
}


- (void)testDateFormat
{
    NSTimeInterval timestamp = 1387846784;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];   // Dec 24 2013, 11:59:44 am]
    
    NSLog(@"%@", [date dateStringWithFormat:@"e 'day of week' dd.MM.yy hh:mm:ss a"]);
    
    XCTAssertEqualObjects([date dateStringWithFormat:@"dd.MM.yy"], @"24.12.13", @"to string");
    XCTAssertEqualObjects([date dateStringWithFormat:@"dd.MM.yy hh:mm:ss"], @"24.12.13 11:59:44", @"to string");
    XCTAssertEqualObjects([date dateStringWithFormat:@"dd.MM.yy hh:mm:ss a"], @"24.12.13 11:59:44 AM", @"to string");
    XCTAssertEqualObjects([date dateStringWithFormat:@"EEEE 'of' dd.MM.yy hh:mm:ss a"], @"Tuesday of 24.12.13 11:59:44 AM", @"to string");
    XCTAssertEqualObjects([date dateStringWithFormat:@"e 'day of week' dd.MM.yy hh:mm:ss a"], @"3 day of week 24.12.13 11:59:44 AM", @"to string");
    XCTAssertEqualObjects([date dateStringWithFormat:@"e 'day of week' dd.MM.yy hh:mm:ss a"], @"3 day of week 24.12.13 11:59:44 AM", @"to string");
    XCTAssertNotEqualObjects([date dateStringWithFormat:@"dd.MM.yy"], @"Dec 23, 2013 11:59 AM", @"not equal datetime date");
}

- (void)testDateFromString
{
    NSTimeInterval timestamp = 1387846784;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];   // Dec 24 2013, 11:59:44 am]
    
    NSDate *dateFromString = [NSDate dateFromString:@"2013.12.24 11:59:44" withFormat:@"yyyy.MM.dd hh:mm:ss"];
    
    XCTAssertEqualObjects(date, dateFromString, @"date compare");
    XCTAssertNotEqualObjects([NSDate dateWithTimeIntervalSince1970:1385846784], dateFromString, @"not equal datetimeß date");
}

- (void)testDateByRemoveTime
{
    NSDate *datetime = [NSDate dateFromString:@"2014.5.12 10:30:00 AM" withFormat:@"yyyy.MM.dd hh:mm:ss a"];
    NSDate *dateWithoutTime = [NSDate dateFromString:@"2014.5.12" withFormat:@"yyyy.MM.dd"];
    NSDate *dateWithoutTimeFull = [NSDate dateFromString:@"2014.5.12 00:00:00 AM" withFormat:@"yyyy.MM.dd hh:mm:ss a"];
    NSDate *dateWithoutTimeOffset = [NSDate dateFromString:@"2014.5.12 00:00:01 AM" withFormat:@"yyyy.MM.dd hh:mm:ss a"];
    NSDate *dateWithoutTimeOffset2 = [NSDate dateFromString:@"2014.5.11 11:59:59 AM" withFormat:@"yyyy.MM.dd hh:mm:ss a"];

    NSDate *date = [datetime dateByRemoveTime];

    XCTAssertEqualObjects(date, dateWithoutTime, @"equal date");
    XCTAssertEqualObjects(date, dateWithoutTimeFull, @"equal date");
    XCTAssertNotEqualObjects(date, dateWithoutTimeOffset, @"equal date");
    XCTAssertNotEqualObjects(date, dateWithoutTimeOffset2, @"equal date");

}

@end
