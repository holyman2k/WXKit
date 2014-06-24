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

#define WXLocalizedString(x) NSLocalizedString(x, x)
#endif
