//
//  WXIsObjectEqualTests.m
//  WXKit
//
//  Created by Charlie Wu on 7/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface WXIsObjectEqualTests : XCTestCase

@end

@implementation WXIsObjectEqualTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testObjectEqualString
{
    NSString *str1 = @"hello";
    NSString *str2 = @"hello";
    NSString *str3 = @"test";

    XCTAssert(is_object_equal(str1, str2), @"object equal");

    XCTAssertFalse(is_object_equal(str1, str3), @"object not equal");
    XCTAssertFalse(is_object_equal(str2, str3), @"object not equal");
}

- (void)testObjectEqualNumber
{
    NSNumber *num1 = @1;
    NSNumber *num2 = @1;
    NSNumber *num3 = @3;

    XCTAssert(is_object_equal(num1, num2), @"object equal");

    XCTAssertFalse(is_object_equal(num1, num3), @"object not equal");
    XCTAssertFalse(is_object_equal(num2, num3), @"object not equal");
}

- (void)testObjectEqualDate
{
    NSDate *date1 = [NSDate dateFromString:@"12-04-2014" withFormat:@"dd-MM-yyyy"];
    NSDate *date2 = [NSDate dateFromString:@"12-04-2014" withFormat:@"dd-MM-yyyy"];
    NSDate *date3 = [NSDate dateFromString:@"12-05-2014" withFormat:@"dd-MM-yyyy"];

    XCTAssert(is_object_equal(date1, date2), @"object equal");

    XCTAssertFalse(is_object_equal(date1, date3), @"object not equal");
    XCTAssertFalse(is_object_equal(date2, date3), @"object not equal");
}

- (void)testObjectEqualMix
{
    NSDate *date1 = [NSDate dateFromString:@"12-04-2014" withFormat:@"dd-MM-yyyy"];
    NSNumber *num1 = @1;
    NSString *str1 = @"hello";

    XCTAssertFalse(is_object_equal(date1, num1), @"object not equal");
    XCTAssertFalse(is_object_equal(date1, str1), @"object not equal");
    XCTAssertFalse(is_object_equal(num1, str1), @"object not equal");
}
@end
