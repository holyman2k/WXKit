//
//  WXURLTests.m
//  WXKit
//
//  Created by Charlie Wu on 4/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface WXURLTests : XCTestCase

@end

@implementation WXURLTests

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

- (void)testDocumentDir
{
    NSURL *url = [NSURL applicationDocumentsDirectory];
    XCTAssertNotNil(url, @"have dir");

    NSArray *components = url.pathComponents;

    XCTAssertEqualObjects(components.lastObject, @"Documents", @"last component is document");
}

- (void)testLibraryDir
{
    NSURL *url = [NSURL applicationLibraryDirectory];
    XCTAssertNotNil(url, @"have dir");

    NSArray *components = url.pathComponents;

    XCTAssertEqualObjects(components.lastObject, @"Library", @"last component is library");
}

@end
