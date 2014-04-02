//
//  WXKit.h
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#ifndef WXKit_WXKit_h
#define WXKit_WXKit_h

#define IsEqual(x,y) ((x && [x isEqual:y]) || (!x && !y))
#define equalOrAssign(x,y) if (!IsEqual(x,y)) x = y

#import "NSString+WXKit.h"
#import "NSMutableString+WXKit.h"
#import "NSDate+WXKit.h"
#import "UIDevice+WXKit.h"
#import "UILabel+WXKit.h"
#import "NSArray+WXKit.h"
#import "NSMutableArray+WXKit.h"
#import "UIColor+WXKit.h"
#import "UIImage+WXKit.h"
#import "UIImageView+WXKit.h"
#import "NSManagedObject+WXKit.h"
#import "NSManagedObjectContext+WXKit.h"
#endif
