//
//  WXArrayTest.m
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+WXKit.h"

@interface WXArrayTests : XCTestCase

@end

@implementation WXArrayTests

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

- (void)testObjectAtIndexOrNilPass
{
    NSArray *array = @[@"1", @"2", @"3"];
    
    XCTAssertEqual(@"1", [array objectOrNilAtIndex:0], @"object at index 0");
    XCTAssertEqual(@"3", [array objectOrNilAtIndex:2], @"object at index 2");
}

- (void)testObjectAtIndexOrNilFail
{
    
    NSArray *array = @[@"1", @"2", @"3"];
    XCTAssertNil([array objectOrNilAtIndex:3], @"object at index 3 is nil");
    XCTAssertNil([array objectOrNilAtIndex:-1], @"object at index 3 is nil");
}

- (void)testObjectAtIndexOrNilArrayNil
{
    NSArray *arrayNil = nil;
    
    XCTAssertNil([arrayNil objectOrNilAtIndex:2], @"object at nil array is nil");
}

- (void)testReverse
{
    NSArray *array = @[@"1", @"2", @"3"];
    
    NSArray *reverseArray = array.reverse;
    
    XCTAssertEqual(@"3", [reverseArray objectOrNilAtIndex:0], @"object at index 0 when reversed is 3");
    XCTAssertEqual(@"2", [reverseArray objectOrNilAtIndex:1], @"object at index 1 when reversed is 2");
    XCTAssertEqual(@"1", [reverseArray objectOrNilAtIndex:2], @"object at index 2 when reversed is 1");
}

@end
