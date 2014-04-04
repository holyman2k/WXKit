//
//  WXMutableStringTests.m
//  WXKit
//
//  Created by Charlie Wu on 4/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface WXMutableStringTests : XCTestCase

@end

@implementation WXMutableStringTests

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

- (void)testMutableStringTrim
{
    NSMutableString *string;
    string = @" hello ".mutableCopy;
    [string trimSelf];

    XCTAssertEqualObjects(@"hello", string, @"equal after trim");

    string = @" hello".mutableCopy;
    [string trimSelf];
    XCTAssertEqualObjects(@"hello", string, @"equal after trim");

    string = @"hello ".mutableCopy;
    [string trimSelf];
    XCTAssertEqualObjects(@"hello", string, @"equal after trim");

    string = @"hel  lo".mutableCopy;
    [string trimSelf];
    XCTAssertNotEqualObjects(@"hello", string, @"equal after trim");
}
@end
