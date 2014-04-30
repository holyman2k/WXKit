//
//  WXUnitTests.m
//  WXKit
//
//  Created by Charlie Wu on 30/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface WXUnitTests : XCTestCase

@end

@implementation WXUnitTests

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


- (void)testWaitBlock
{
    __block BOOL queueTaskCompleted = NO;

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        queueTaskCompleted = YES;
        [self completeAsynchronousTask];
    }];
    [self waitForAsynchronousTask];

    XCTAssertTrue(queueTaskCompleted, @"task completed");
    XCTAssertFalse(!queueTaskCompleted, @"task completed");
}

- (void)testWait
{
    __block BOOL queueTaskCompleted = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        queueTaskCompleted = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self completeAsynchronousTask];
        });
    });
    [self waitForAsynchronousTask];

    XCTAssertTrue(queueTaskCompleted, @"task completed");
    XCTAssertFalse(!queueTaskCompleted, @"task completed");
}

- (void)testWaitMainQueue
{
    __block BOOL queueTaskCompleted = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        queueTaskCompleted = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self completeAsynchronousTask];
        });
    });
    [self waitForAsynchronousTask];

    XCTAssertTrue(queueTaskCompleted, @"task completed");
    XCTAssertFalse(!queueTaskCompleted, @"task completed");
}

- (void)testSafeWait
{
    __block BOOL queueTaskCompleted = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        queueTaskCompleted = YES;
        [self safelyCompleteAsynchronousTask];
    });
    [self waitForAsynchronousTask];

    XCTAssertTrue(queueTaskCompleted, @"task completed");
    XCTAssertFalse(!queueTaskCompleted, @"task completed");
}

- (void)testSafeWaitBlock
{
    __block BOOL queueTaskCompleted = NO;

    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        queueTaskCompleted = YES;
        [self safelyCompleteAsynchronousTask];
    }];
    [self waitForAsynchronousTask];

    XCTAssertTrue(queueTaskCompleted, @"task completed");
    XCTAssertFalse(!queueTaskCompleted, @"task completed");
}

@end
