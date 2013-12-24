//
//  WXNSStringTest.m
//  WXKit
//
//  Created by Charlie Wu on 24/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Extension.h"

@interface WXNSStringTest : XCTestCase

@end

@implementation WXNSStringTest

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

- (void)testTrim
{
    XCTAssertEqualObjects(@"hello", @" hello".trim, @"trim font white space");
    XCTAssertEqualObjects(@"hello", @"hello  ".trim, @"trim back white space");
    XCTAssertEqualObjects(@"hello", @" hello ".trim, @"trim both side white space");
    XCTAssertEqualObjects(@"hello", @"\thello\t".trim, @"trim tabs");
    XCTAssertEqualObjects(@"hello", @"hello".trim, @"trim does nothing and should equal");
    XCTAssertNotEqualObjects(@"hello", @"helloa".trim, @"is not equal");
    XCTAssertNotEqualObjects(@"hello", @"test ".trim, @"is not equal");
    XCTAssertNotEqualObjects(@"hello", @"hell o".trim, @"does not remove middle white space");
}

- (void)testEmpty
{
    XCTAssertFalse([NSString isEmptyOrNil:@"hello"], @"is not empty");
    XCTAssertTrue([NSString isEmptyOrNil:@""], @"is empty");
    XCTAssertTrue([NSString isEmptyOrNil:nil], @"is empty");
}

- (void)testWhitespaceEmpty
{
    XCTAssertTrue([NSString isEmptyOrNilOrOnlyWhiteSpace:@" "], @"is empty");
    XCTAssertTrue([NSString isEmptyOrNilOrOnlyWhiteSpace:@""], @"is empty");
    XCTAssertTrue([NSString isEmptyOrNilOrOnlyWhiteSpace:@" \t"], @"is empty");
    
    XCTAssertFalse([NSString isEmptyOrNilOrOnlyWhiteSpace:@"a a"], @"is empty");
    XCTAssertFalse([NSString isEmptyOrNilOrOnlyWhiteSpace:@"h"], @"is empty");
    XCTAssertFalse([NSString isEmptyOrNilOrOnlyWhiteSpace:@"hello"], @"is empty");
}

- (void)testHeight
{
    NSString *string = @"this is a fairly long wrong and should wrap within 100 point width";
    UIFont *font = [UIFont systemFontOfSize:17];
    
    XCTAssertTrue([string heightForFont:font andWidth:400] > 21, @"more then one line");
    XCTAssertTrue([string heightForFont:font andWidth:500] < 25, @"fit one line");
}


- (void)testWidth
{
    NSString *string = @"this is a fairly long wrong and should wrap within 100 point width";
    UIFont *font = [UIFont systemFontOfSize:17];
    
    XCTAssertTrue([string widthForFont:font] > 490, @"width for one line");
}
@end
