//
//  WXBackgroundOperation.m
//  WXKit
//
//  Created by Charlie Wu on 2/09/2015.
//  Copyright (c) 2015 Charlie Wu. All rights reserved.
//

#import "WXBackgroundTask.h"

@interface WXBackgroundTask() {
    BOOL finished;
    BOOL executing;
}

@property (nonatomic, strong) WXTaskBlock taskBlock;
@property (nonatomic, strong) WXTaskBlockWithObject taskBlockWithResults;
@property (nonatomic, strong) id result;
@end

@implementation WXBackgroundTask

+ (instancetype)createTask:(WXTaskBlock)taskBlock {

    WXBackgroundTask *task = [[self alloc] init];
    task.taskBlock = taskBlock;
    return task;
}

+ (instancetype)createTaskWithObject:(WXTaskBlockWithObject)taskBlock {

    WXBackgroundTask *task = [[self alloc] init];
    task.taskBlockWithResults = taskBlock;
    return task;
}

- (id)init {
    self = [super init];
    if (self) {
        finished = NO;
        executing = NO;
    }
    return self;
}

- (void)start {
    if ([self isCancelled]) {
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (self.taskBlock) {
            self.result = self.taskBlock();
        } else if (self.taskBlockWithResults) {
            NSMutableArray *dependencyResults = [NSMutableArray array];
            [self.dependencies enumerateObjectsUsingBlock:^(id<WXTask> operation, NSUInteger idx, BOOL *stop) {
                [dependencyResults addObject:operation.result != nil ? operation.result : [NSNull null]];
            }];
            WXTuple *tuple = [WXTuple tupleWithArray:dependencyResults];
            self.result = self.taskBlockWithResults(tuple);
        }

        [self willChangeValueForKey:@"isExecuting"];
        executing = NO;
        [self didChangeValueForKey:@"isExecuting"];

        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
    });

}

-(BOOL)isConcurrent {
    return YES;
}

-(BOOL)isAsynchronous {
    return YES;
}

-(BOOL)isExecuting {
    return executing;
}

-(BOOL)isFinished {
    return finished;
}

//- (void)dealloc {
//    NSLog(@"dealloc background task");
//}

@end
