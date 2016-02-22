//
//  WXTuple.m
//  WXKit
//
//  Created by Charlie Wu on 2/09/2015.
//  Copyright (c) 2015 Charlie Wu. All rights reserved.
//

#import "WXTuple.h"

@interface WXTuple()

@property (nonatomic, strong) NSArray *array;

@end

@implementation WXTuple

+ (instancetype)tupleWithArray:(NSArray *)array {
    return [[self alloc] initWithArray:array];
}

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
