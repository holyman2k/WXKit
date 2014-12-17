//
//  NSURL+WXKit.h
//  WXKit
//
//  Created by Charlie Wu on 4/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (WXKit)

+ (instancetype)applicationDocumentsDirectory;

+ (instancetype)applicationLibraryDirectory;

+ (instancetype)applicationTemporaryDirectory;

@end
