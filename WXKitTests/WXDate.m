//
//  WXDate.m
//  WXKit
//
//  Created by Charlie Wu on 24/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+Extension.h"

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
    
    XCTAssertEqualObjects([date dateToString:@"dd.MM.yy"], @"24.12.13", @"to string");
    XCTAssertNotEqualObjects([date dateToString:@"dd.MM.yy"], @"Dec 23, 2013 11:59 AM", @"not equal datetimeß date");
}

@end
