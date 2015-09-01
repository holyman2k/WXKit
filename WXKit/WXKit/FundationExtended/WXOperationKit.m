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
 * WXTuple
 */

@interface WXTuple()

@property (nonatomic, strong) NSArray *array;

@end

@implementation WXTuple

- (instancetype)initWithArray:(NSArray *)array {
    if (self = [super init]) {
        _array = array;
    }
    return self;
}

- (id)objectOrNilAtIndex:(NSUInteger)index
{
    if (self.array.count > index) {
        id obj = self.array[index];
        if ([obj isEqual:[NSNull null]]) {
            return nil;
        } else {
            return obj;
        }
    }
    return nil;
}

- (id)first {
    return [self objectOrNilAtIndex:0];
}

- (id)second {
    return [self objectOrNilAtIndex:1];
}

- (id)thrid {
    return [self objectOrNilAtIndex:2];
}

- (id)fourth {
    return [self objectOrNilAtIndex:3];
}

- (id)fifth {
    return [self objectOrNilAtIndex:4];
}

- (id)sixth {
    return [self objectOrNilAtIndex:5];
}

- (id)seventh {
    return [self objectOrNilAtIndex:6];
}

- (id)eighth {
    return [self objectOrNilAtIndex:7];
}

- (id)ninth {
    return [self objectOrNilAtIndex:8];
}

- (id)tenth {
    return [self objectOrNilAtIndex:9];
}

- (id)valueAtIndex:(NSUInteger)index {
    return [self objectOrNilAtIndex:index];
}

@end

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

@property (nonatomic) NSUInteger count;

@end

@implementation WXOperation

+ (WXOperation *)operationOnMainQueueWithTask:(TaskBlock)task {

    WXOperation *operation = [WXOperation new];
    operation->background = NO;
    operation.taskBlock = task;
    return operation;
}

+ (WXOperation *)operationOnBackgrounQueueWithTask:(TaskBlock)task {

    WXOperation *operation = [WXOperation new];
    operation->background = YES;
    operation.taskBlock = task;
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

    NSMutableArray *results = [NSMutableArray array];
    NSArray *dependencies = [self.dependencies sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"count" ascending:YES]]];
    [dependencies enumerateObjectsUsingBlock:^(WXOperation *operation, NSUInteger idx, BOOL *stop) {
        [results addObject:operation.result != nil ? operation.result : [NSNull null]];
    }];

    WXTuple *tuple = [[WXTuple alloc] initWithArray:results];

    VoidBlock completion = ^{
        [self willChangeValueForKey:@"isExecuting"];
        executing = NO;
        [self didChangeValueForKey:@"isExecuting"];

        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
    };

    if (background) {
        self.result = self.taskBlock(tuple);
        completion();
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.result = self.taskBlock(tuple);
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

- (WXOperationKit *)doBackgroundTask:(TaskBlock)task {

    NSArray *lastDependencies = [self.operations.lastObject dependencies];

    WXOperation *operation = [self.operations push:[WXOperation operationOnBackgrounQueueWithTask:task]];
    operation.count = self.operations.count;

    [lastDependencies enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [operation addDependency:obj];
    }];
    
    [self.operationGroup push:operation];
    return self;
}

- (WXOperationKit *)thenDoBackgroundTask:(TaskBlock)task {

    WXOperation *operation = [self.operations push:[WXOperation operationOnBackgrounQueueWithTask:task]];
    operation.count = self.operations.count;

    [self.operationGroup enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [operation addDependency:obj];
    }];

    self.operationGroup = [NSMutableArray array];
    [self.operationGroup push:operation];
    return self;
}


- (WXOperationKit *)doTask:(TaskBlock)task {

    NSArray *lastDependencies = [self.operations.lastObject dependencies];

    WXOperation *operation = [self.operations push:[WXOperation operationOnMainQueueWithTask:task]];
    operation.count = self.operations.count;

    [lastDependencies enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [operation addDependency:obj];
    }];

    [self.operationGroup push:operation];
    return self;
}

- (WXOperationKit *)thenDoTask:(TaskBlock)task{

    WXOperation *operation = [self.operations push:[WXOperation operationOnMainQueueWithTask:task]];
    operation.count = self.operations.count;

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
            self.operations = [NSMutableArray array];
            self.operationGroup = [NSMutableArray array];
        });
    });


}


@end
