//
//  WXWaitWhileTest.m
//  WXKit
//
//  Created by Charlie Wu on 6/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface WXWaitWhileTest : XCTestCase

@end

@implementation WXWaitWhileTest

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

- (void)testWaitWhile
{
    __block BOOL queueCompleted = NO;
    __block BOOL queueDidWait = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        queueDidWait = YES;
        queueCompleted = YES;
    });

    wait_while(queueCompleted, 1.0);
    XCTAssert(queueCompleted, @"did wait");
    XCTAssert(queueDidWait, @"did wait");
}

- (void)testWaitWhile2
{
    __block BOOL queueCompleted = NO;
    __block BOOL queueDidRun = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:1];
        queueDidRun = YES;
        queueCompleted = YES;
    });

    wait_while(queueCompleted, 2.0);
    XCTAssert(queueDidRun, @"did wait");
    XCTAssert(queueCompleted, @"did wait");
}

- (void)testWaitWhileForever
{
    __block BOOL queueCompleted = NO;
    __block BOOL queueDidWait = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:1];
        queueDidWait = YES;
        queueCompleted = YES;
    });

    wait_while(queueCompleted, CGFLOAT_MAX);
    XCTAssert(queueCompleted, @"did wait");
    XCTAssert(queueDidWait, @"did wait");
}

- (void)testWaitWhileFail
{
    __block BOOL queueCompleted = NO;
    __block BOOL queueDidRun = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        queueDidRun = YES;
        queueCompleted = YES;
    });

    wait_while(queueCompleted, 1.0);
    XCTAssertFalse(queueDidRun, @"did wait");
    XCTAssertFalse(queueCompleted, @"did wait");
}

@end
