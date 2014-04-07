//
//  Macros.h
//  WXKit
//
//  Created by Charlie Wu on 7/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#ifndef WXKit_Macros_h
#define WXKit_Macros_h


#define is_object_equal(x,y) ((x && [x isEqual:y]) || (!x && !y))

/*!
 * @brief assign y to x if x is not equal y
 * @param x value to be overwritten
 * @param y value to be assigned to x
 */
#define assign_if_not_equal(x,y) if (!is_object_equal(x,y)) x = y

/*!
 * @brief suspend queue till value is true, will not block main thread
 * @param value     value that is waited to be true
 */
#define wait_while(condition, timeout)\
NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:timeout];\
while (!condition && [loopUntil timeIntervalSinceNow] > 0) {\
[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:loopUntil];\
}


#endif