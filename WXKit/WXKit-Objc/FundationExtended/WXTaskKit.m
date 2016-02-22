//
//  WXProgressKit.m
//  WXKit
//
//  Created by Charlie Wu on 1/09/2015.
//  Copyright (c) 2015 Charlie Wu. All rights reserved.
//

#import "WXTaskKit.h"
#import "WXTask.h"
#import "WXBackgroundTask.h"

/*
 * WXOperationKit
 */

@interface WXTaskKit()

@property (nonatomic, strong) NSMutableArray *operations;

@end

@implementation WXTaskKit

+ (instancetype)create {
    return [self new];
}

- (instancetype)init {
    if (self = [super init]) {
        _operations = [NSMutableArray array];
    }
    return self;
}

- (id<WXTask>)setDependencies:(NSArray *)tasks toTask:(WXTaskBlockWithObject)taskBlock isBackground:(BOOL)background {
    id task = background ? [WXBackgroundTask createTaskWithObject:taskBlock] : [WXTask createTaskWithObject:taskBlock];
    [tasks enumerateObjectsUsingBlock:^(id<WXTask> obj, NSUInteger idx, BOOL *stop) {
        [task addDependency:obj];
    }];
    [self.operations addObject:task];
    return task;
}

- (id<WXTask>)doTask:(WXTaskBlock)taskBlock {
    id task = [WXTask createTask:taskBlock];
    [self.operations addObject:task];
    return task;
}

- (id<WXTask>)waitForTasks:(NSArray *)tasks thenDoTask:(WXTaskBlockWithObject)task {
    return [self setDependencies:tasks toTask:task isBackground:NO];
}

- (id<WXTask>)doBackgroundTask:(WXTaskBlock)taskBlock {

    id task = [WXBackgroundTask createTask:taskBlock];
    [self.operations addObject:task];
    return task;
}

- (id<WXTask>)waitForTasks:(NSArray *)tasks thenDoBackgroundTask:(WXTaskBlockWithObject)task {
    return [self setDependencies:tasks toTask:task isBackground:YES];
}

- (id<WXTask>)queueTask:(WXTaskBlockWithObject)taskBlock {
    id task = [WXTask createTaskWithObject:taskBlock];
    [task addDependency:self.operations.lastObject];
    [self.operations addObject:task];
    return task;
}

- (id<WXTask>)queueBackgroundTask:(WXTaskBlockWithObject)taskBlock {

    id task = [WXBackgroundTask createTaskWithObject:taskBlock];
    [task addDependency:self.operations.lastObject];
    [self.operations addObject:task];
    return task;
}

- (void)startOnCompletion:(VoidBlock)completion {

    NSOperationQueue *operationQueue = [NSOperationQueue mainQueue];

    NSMutableArray *operations = [self.operations mutableCopy];

    id completionTask = [WXTask createTask:^id() {
        if (completion) completion();
        return nil;
    }];
    [operations enumerateObjectsUsingBlock:^(id<WXTask> obj, NSUInteger idx, BOOL *stop) {
        [completionTask addDependency:obj];
    }];

    [operations addObject:completionTask];
    [operationQueue addOperations:operations waitUntilFinished:NO];
    [self.operations empty];
}

//- (void)dealloc {
//    NSLog(@"dealloc runner");
//}
@end
