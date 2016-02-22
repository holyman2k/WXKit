//
//  Blocks.h
//  Defects
//
//  Created by Charlie Wu on 1/05/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#ifndef Defects_Blocks_h
#define Defects_Blocks_h

typedef void (^VoidBlock)(void);

typedef void (^ActionBlock)(id sender);

typedef void (^ErrorBlock)(NSError *error);

#endif
