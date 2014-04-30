//
//  NSObject+WXKit.m
//  WXKit
//
//  Created by Charlie Wu on 14/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "NSObject+WXKit.h"

@implementation NSObject (WXKit)

+ (id)initWithBuilderBlock:(void(^)(id))block;
{
    id instance = [[self alloc] init];
    block(instance);
    return instance;
}

/*!
 * @brief keep runloop going; start asynchronise task and wait for completeAsynchronousTask or safelyCompleteAsynchronousTask
 */
- (void)waitForAsynchronousTask
{
    CFRunLoopRun();
}

/*!
 * @brief stop runloop; asychronise task completed
 */
- (void)completeAsynchronousTask
{
    CFRunLoopStop(CFRunLoopGetCurrent());
}


/*!
 * @brief same as completeAsynchronousTask but thread safe
 */
- (void)safelyCompleteAsynchronousTask
{
    if ([NSThread isMainThread]) {
        [self completeAsynchronousTask];
    } else {
        [self performSelectorOnMainThread:@selector(completeAsynchronousTask)
                               withObject:nil
                            waitUntilDone:YES];
    }
}
@end
