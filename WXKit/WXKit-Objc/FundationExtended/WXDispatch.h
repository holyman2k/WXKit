//
//  WXDispatch.h
//  Defects
//
//  Created by Charlie Wu on 28/9/16.
//  Copyright © 2016 WebFM Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXBlocks.h"

@interface WXDispatch : NSObject

+ (void)queueBlock:(VoidBlock)backgroundBlock onCompletion:(VoidBlock)mainBlock;

@end
