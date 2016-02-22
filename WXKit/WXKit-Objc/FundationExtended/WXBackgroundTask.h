//
//  WXBackgroundOperation.h
//  WXKit
//
//  Created by Charlie Wu on 2/09/2015.
//  Copyright (c) 2015 Charlie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXTaskProtocol.h"


/*!
 * @brief an operation that runs on the main thread that works with WXOperationKit
 */
@interface WXBackgroundTask : NSOperation <WXTask>

+ (instancetype)createTask:(WXTaskBlock)taskBlock;

+ (instancetype)createTaskWithObject:(WXTaskBlockWithObject)taskBlock;

@end
