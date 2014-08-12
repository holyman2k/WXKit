//
//  XCTestCase+WXKit.h
//  Defects
//
//  Created by Charlie Wu on 30/04/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCTestCase (WXKit)

/*!
 * @brief keep runloop going; start asynchronise task and wait for completeAsynchronousTask or safelyCompleteAsynchronousTask
 * @discussion call this method in the end of your dispatch block
 */
- (void)waitForAsynchronousTask;

/*!
 * @brief stop runloop; asychronise task completed
 * @discussion this method need to be called on the main thread
 * @see - (void)safelyCompleteAsynchronousTask for thread safe version of this method
 */
- (void)completeAsynchronousTask;

/*!
 * @brief same as completeAsynchronousTask but thread safe
 * @discussion call this method after the dispatch call to wait for async block to finish
 */
- (void)safelyCompleteAsynchronousTask;

@end
