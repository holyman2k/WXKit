//
//  WXMethodThrottler.m
//  Documents
//
//  Created by Charlie Wu on 17/02/2015.
//  Copyright (c) 2015 Charlie Wu. All rights reserved.
//

#import "WXBlockDebouncer.h"
#import "WXBlocks.h"

@interface WXBlockDebouncer()

@property (nonatomic) float throttle;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) BOOL canUpdate;

@end

@implementation WXBlockDebouncer

- (instancetype)initWithThrottleInSeconds:(float)throttle {

    if (self = [self init]) {
        _canUpdate = YES;
        _throttle = throttle;

        // setup debouncing
        {
            VoidBlock block = ^(){
                _timer = [NSTimer scheduledTimerWithTimeInterval:throttle target:self selector:@selector(enableInvokation) userInfo:nil repeats:YES];
            };

            if ([NSThread isMainThread]) {
                block();
            } else {
                dispatch_async(dispatch_get_main_queue(), block);
            }
        }
    }
    return self;
}

- (void)performBlockAndWait:(void(^)())block {

    if (!self.canUpdate) return;

    if (block) block();
    self.canUpdate = NO;
}

- (void)enableInvokation {
    if (!self.canUpdate) self.canUpdate = YES;
}

- (void)tearDown {
    [_timer invalidate];
    _timer = nil;
}

@end
