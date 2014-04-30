//
//  XCTestCase+WXKit.h
//  Defects
//
//  Created by Charlie Wu on 30/04/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCTestCase (WXKit)

- (void)waitForAsynchronousTask;

- (void)completeAsynchronousTask;

- (void)safelyCompleteAsynchronousTask;

@end
