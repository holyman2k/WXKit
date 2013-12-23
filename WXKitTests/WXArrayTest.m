//
//  WXArrayTest.m
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+Extension.h"

@interface WXArrayTest : XCTestCase

@end

@implementation WXArrayTest

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

- (void)testObjectAtIndexOrNil
{
    NSArray *array = @[@"1", @"2", @"3"];
    
    id obj0 = [array objectOrNilAtIndex:0];
    
    XCTAssertEqual(@"1", obj0, @"true");
}

@end
