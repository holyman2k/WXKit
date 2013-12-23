//
//  NSArray+Extension.m
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

- (id)objectOrNilAtIndex:(NSUInteger)index
{
    if (self.count > index) {
        return self[index];
    }
    return nil;
}

- (NSArray *)reverse
{
//    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:self.count];
//    
//    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [array addObject:obj];
//    }];
//    return array.copy;
    return self.reverseObjectEnumerator.allObjects;
}
@end
