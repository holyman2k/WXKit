//
//  NSObject+WXKit.m
//  WXKit
//
//  Created by Charlie Wu on 14/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "NSObject+WXKit.h"

@implementation NSObject (WXKit)

+ (id)initWithBuilderBlock:(void(^)(id))block;
{
    id instance = [[self alloc] init];
    block(instance);
    return instance;
}
@end
