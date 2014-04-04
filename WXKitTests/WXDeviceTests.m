//
//  WXDeviceTests.m
//  WXKit
//
//  Created by Charlie Wu on 4/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface WXDeviceTests : XCTestCase

@end

@implementation WXDeviceTests

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

- (void)testModel
{
    NSString *model = UIDevice.currentDeviceModel;
    XCTAssertNotNil(model, @"have device model");
}

- (void)testSystemVersion
{
    CGFloat version = UIDevice.currentDeviceSystemVersion;
    XCTAssert(version > 6, @"version greater then 6");
}

@end
