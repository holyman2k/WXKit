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

@end
