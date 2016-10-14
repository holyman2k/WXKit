//
//  WXDispatch.m
//  Defects
//
//  Created by Charlie Wu on 28/9/16.
//  Copyright © 2016 WebFM Pty Ltd. All rights reserved.
//

#import "WXDispatch.h"

@implementation WXDispatch

+ (void)queueBlock:(VoidBlock)backgroundBlock onCompletion:(VoidBlock)mainBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        backgroundBlock();
        dispatch_async(dispatch_get_main_queue(), ^{
            mainBlock();
        });
    });
}

@end
