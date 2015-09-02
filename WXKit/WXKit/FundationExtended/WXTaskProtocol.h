//
//  WXOperationProtocol.h
//  WXKit
//
//  Created by Charlie Wu on 2/09/2015.
//  Copyright (c) 2015 Charlie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXTuple.h"

typedef id (^WXTaskBlockWithObject)(WXTuple *values);

typedef id (^WXTaskBlock)(void);

@protocol WXTask <NSObject>

+ (instancetype)createTask:(WXTaskBlock)taskBlock;
+ (instancetype)createTaskWithObject:(WXTaskBlockWithObject)taskBlock;

@property (nonatomic, readonly) id result;

- (void)addDependency:(id<WXTask>)task;

@end
