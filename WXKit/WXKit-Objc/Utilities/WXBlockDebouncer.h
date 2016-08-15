//
//  WXMethodThrottler.h
//  Documents
//
//  Created by Charlie Wu on 17/02/2015.
//  Copyright (c) 2015 Charlie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXBlockDebouncer : NSObject

- (instancetype)initWithThrottleInSeconds:(float)throttle;

- (void)performBlockAndWait:(VoidBlock)block;

- (void)tearDown;

@end
