//
//  NSArray+WXKit.m
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import "NSArray+WXKit.h"

@implementation NSArray (WXKit)

- (id)objectOrNilAtIndex:(NSUInteger)index
{
    if (self.count > index) {
        return self[index];
    }
    return nil;
}

- (instancetype)reverse
{
    return self.reverseObjectEnumerator.allObjects;
}

- (id)firstObjectPassTest:(BOOL(^)(id obj))block
{
    NSUInteger index = [self indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        BOOL match = block(obj);
        *stop = match;
        return match;
    }];

    return [self objectOrNilAtIndex:index];
}
@end
