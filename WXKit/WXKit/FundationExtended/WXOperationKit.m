//
//  WXProgressKit.m
//  WXKit
//
//  Created by Charlie Wu on 1/09/2015.
//  Copyright (c) 2015 Charlie Wu. All rights reserved.
//

#import "WXOperationKit.h"

@class WXOperation;


/*
 * WXOperation
 */

@interface WXOperation : NSOperation {
    BOOL finished;
    BOOL executing;
    BOOL background;
}

@property (nonatomic, strong) TaskBlock taskBlock;

@property (nonatomic, strong) id result;

@end

@implementation WXOperation

+ (WXOperation *)operationOnQueue:(dispatch_queue_t)queue withName:(NSString *)name andTask:(TaskBlock)task {

    WXOperation *operation = [WXOperation new];
    operation.taskBlock = task;
    operation.name = name;
    return operation;
}

+ (WXOperation *)operationOnMainQueueWithName:(NSString *)name andTask:(TaskBlock)task {

    WXOperation *operation = [WXOperation operationOnQueue:dispatch_get_main_queue() withName:name andTask:task];
    return operation;
}

+ (WXOperation *)operationOnBackgrounQueueWithName:(NSString *)name andTask:(TaskBlock)task {

    WXOperation *operation = [WXOperation operationOnQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)  withName:name andTask:task];
    operation->background = YES;
    return operation;
}

- (id)init {
    self = [super init];
    if (self) {
        background = NO;
        finished = NO;
        executing = NO;
    }
    return self;
}

- (void)start {
    if ([self isCancelled]) {
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];

    NSMutableDictionary *resultsMap = [NSMutableDictionary dictionary];
    [self.dependencies enumerateObjectsUsingBlock:^(WXOperation *operation, NSUInteger idx, BOOL *stop) {
        if (operation.result != nil) {
            resultsMap[operation.name] = operation.result;
        }
    }];

    VoidBlock completion = ^{
        [self willChangeValueForKey:@"isExecuting"];
        executing = NO;
        [self didChangeValueForKey:@"isExecuting"];

        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
    };

    if (background) {
        self.result = self.taskBlock(resultsMap);
        completion();
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.result = self.taskBlock(resultsMap);
            completion();
        });
    }
}

-(BOOL)isConcurrent {
    return background;
}

-(BOOL)isAsynchronous {
    return background;
}

-(BOOL)isExecuting {
    return executing;
}

-(BOOL)isFinished {
    return finished;
}

@end


/*
 * WXOperationKit
 */

@interface WXOperationKit()

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property (nonatomic, strong) NSMutableArray *operations;

@property (nonatomic, strong) NSMutableArray *operationGroup;

@end

@implementation WXOperationKit

+ (instancetype)kit {
    return [self new];
}

- (instancetype)init {
    if (self = [super init]) {
        _operations = [NSMutableArray array];
        _operationGroup = [NSMutableArray array];
    }
    return self;
}

- (WXOperationKit *)joinTask:(TaskBlock)task withName:(NSString *)name {

    WXOperation *operation = [self.operations push:[WXOperation operationOnBackgrounQueueWithName:name andTask:task]];
    [self.operationGroup push:operation];
    return self;
}
- (WXOperationKit *)thenDoTask:(TaskBlock)task withName:(NSString *)name {

    WXOperation *operation = [self.operations push:[WXOperation operationOnBackgrounQueueWithName:name andTask:task]];

    [self.operationGroup enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [operation addDependency:obj];
    }];

    self.operationGroup = [NSMutableArray array];
    [self.operationGroup push:operation];
    return self;
}

- (void)startOnCompletion:(VoidBlock)completion {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        self.operationQueue = [[NSOperationQueue alloc] init];

        [self.operationQueue addOperations:self.operations waitUntilFinished:YES];

        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) completion();
        });
    });


}


@end
