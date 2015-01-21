//
//  NSMutableArray+Extension.m
//  Defects
//
//  Created by Charlie Wu on 20/01/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import "NSMutableArray+WXKit.h"

@implementation NSMutableArray (WXKit)

- (id)pop
{
    id object = self.lastObject;
    [self removeObject:object];
    return object;
}

- (void)push:(id)object
{
    [self addObject:object];
}

- (id)peek
{
    return self.lastObject;
}

- (void)empty
{
    [self removeAllObjects];
}

- (BOOL)addObjectIfNotNil:(id)object {
    if (object) {
        [self addObject:object];
        return YES;
    }
    return nil;
}

@end
