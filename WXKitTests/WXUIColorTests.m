//
//  WXUIColor.m
//  WXKit
//
//  Created by Charlie Wu on 28/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+WXKit.h"

@interface WXUIColor : XCTestCase

@end

@implementation WXUIColor

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testHexColor
{
    UIColor *color = [UIColor colorWithHexString:@"337982" withAlpha:1];
    
//    UIColor *baseColor = [UIColor colorWithRed:0.2 green:0.475 blue:0.51 alpha:1.0];
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    XCTAssertEqualWithAccuracy(0.2, red, .002, @"red equal");
    XCTAssertEqualWithAccuracy(0.475, green, .002, @"green equal");
    XCTAssertEqualWithAccuracy(0.51, blue, .002, @"blue equal");
    XCTAssertEqualWithAccuracy(1, alpha, .002, @"alpha equal");

}

@end
