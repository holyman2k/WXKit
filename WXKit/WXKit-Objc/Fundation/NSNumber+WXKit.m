//
//  NSNumber+WXKit.m
//  WXKit
//
//  Created by Charlie Wu on 13/08/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "NSNumber+WXKit.h"

@implementation NSNumber (WXKit)

- (instancetype)addNumber:(NSNumber *)number {
    return @(self.doubleValue + number.doubleValue);
}

- (instancetype)multiplyNumber:(NSNumber *)number {
    return @(self.doubleValue * number.doubleValue);
}

- (instancetype)divideNumber:(NSNumber *)number {
    return @(self.doubleValue / number.doubleValue);
}

- (instancetype)dividedByNumber:(NSNumber *)number {
    return @(number.doubleValue / self.doubleValue);
}

@end
