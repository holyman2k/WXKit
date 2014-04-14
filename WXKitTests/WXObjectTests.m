//
//  WXObjectTests.m
//  WXKit
//
//  Created by Charlie Wu on 14/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WXUser.h"

@interface WXObjectTests : XCTestCase

@end

@implementation WXObjectTests

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

- (void)testCreate
{
    WXUser *account = [WXUser initWithBuilderBlock:^(id this) {
        WXUser *me = this;
        me.username = @"hello";
        me.accountId = @1;
        me.password = @"user+password-random";
    }];

    XCTAssertEqualObjects(account.username, @"hello", @"match property");
    XCTAssertEqualObjects(account.password, @"user+password-random", @"match property");
    XCTAssertEqualObjects(account.accountId, @1, @"match property");
}

@end
