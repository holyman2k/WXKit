//
//  NSObject+WXKit.h
//  WXKit
//
//  Created by Charlie Wu on 14/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WXKit)

+ (instancetype)initWithBuilderBlock:(void(^)(id me))block;


- (void)waitForAsynchronousTask;

- (void)completeAsynchronousTask;

- (void)safelyCompleteAsynchronousTask;

@end
