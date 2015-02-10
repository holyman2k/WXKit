//
//  WXMacroTests.m
//  WXKit
//
//  Created by Charlie Wu on 11/02/2015.
//  Copyright (c) 2015 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface WXMacroTests : XCTestCase

@end

@implementation WXMacroTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNotEqual {
    // This is an example of a functional test case.
    NSString *a = nil;
    NSString *b = @"hell";

    XCTAssertFalse(is_object_equal_and_not_nil(a, b));
}

- (void)testNotEqual2 {
    // This is an example of a functional test case.
    NSString *a = nil;
    NSString *b = @"hell";

    XCTAssertFalse(is_object_equal_and_not_nil(b, a));
}

- (void)testNotEqualNotNull {
    // This is an example of a functional test case.
    NSString *a = @"hello";
    NSString *b = @"helli";

    XCTAssertFalse(is_object_equal_and_not_nil(b, a));
}

- (void)testNotEqualNull {
    // This is an example of a functional test case.
    NSString *a = nil;
    NSString *b = nil;

    XCTAssertFalse(is_object_equal_and_not_nil(b, a));
}

- (void)testNotEqualType {
    // This is an example of a functional test case.
    NSString *a = @"hello";
    NSNumber *b = @4;

    XCTAssertFalse(is_object_equal_and_not_nil(b, a));
}

- (void)testNotEqualType2 {
    // This is an example of a functional test case.
    NSString *a = @"hello";
    NSNumber *b = @4;

    XCTAssertFalse(is_object_equal_and_not_nil(a, b));
}

- (void)testEqual {
    // This is an example of a functional test case.
    NSString *a = @"hello";
    NSString *b = @"hello";

    XCTAssertTrue(is_object_equal_and_not_nil(a, b));
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
