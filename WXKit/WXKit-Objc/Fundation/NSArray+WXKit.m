//
//  NSArray+WXKit.m
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import "NSArray+WXKit.h"

@implementation NSArray (WXKit)

- (id)objectOrNilAtIndex:(NSUInteger)index  {
    if (self.count > index) {
        return self[index];
    }
    return nil;
}

- (instancetype)reverse  {
    return self.reverseObjectEnumerator.allObjects;
}

- (id)firstObjectPassTest:(BOOL(^)(id obj))block  {
    NSUInteger index = [self indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        BOOL match = block(obj);
        *stop = match;
        return match;
    }];

    return [self objectOrNilAtIndex:index];
}

- (instancetype)arrayByRemovingObject:(id)object {
    if ([self containsObject:object]) {
        NSMutableArray *array = [self mutableCopy];
        [array removeObject:object];
        return [[self class] arrayWithArray:array];
    }
    return self;
}

- (NSDictionary *)dictionaryWithKeyPath:(NSString *)keyPath {
    return [NSDictionary dictionaryWithObjects:self forKeys:[self valueForKey:keyPath]];
}

- (NSMutableDictionary *)mutableDictionaryWithKeyPath:(NSString *)keyPath {
    return [NSMutableDictionary dictionaryWithObjects:self forKeys:[self valueForKey:keyPath]];
}

@end
