//
//  WXProgressKit.h
//  WXKit
//
//  Created by Charlie Wu on 1/09/2015.
//  Copyright (c) 2015 Charlie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXTaskProtocol.h"

@interface WXTaskKit : NSObject

+ (instancetype)create;

/*!
 * @brief add a task to schedule that run on the main thred
 * @param task - a block to run for the task
 */
- (id<WXTask>)doTask:(WXTaskBlock)taskBlock;

- (id<WXTask>)waitForTasks:(NSArray *)tasks thenDoTask:(WXTaskBlockWithObject)taskBlock;

- (id<WXTask>)doBackgroundTask:(WXTaskBlock)taskBlock;

- (id<WXTask>)waitForTasks:(NSArray *)tasks thenDoBackgroundTask:(WXTaskBlockWithObject)taskBlock;

- (id<WXTask>)queueTask:(WXTaskBlockWithObject)taskBlock;

- (id<WXTask>)queueBackgroundTask:(WXTaskBlockWithObject)taskBlock;

- (void)startOnCompletion:(VoidBlock)completion;

@end
