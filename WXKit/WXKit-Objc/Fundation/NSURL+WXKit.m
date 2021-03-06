//
//  NSURL+WXKit.m
//  WXKit
//
//  Created by Charlie Wu on 4/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

@implementation NSURL (WXKit)

+ (instancetype)applicationDocumentsDirectory {
    return [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
}

+ (instancetype)applicationLibraryDirectory {
    return [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;
}

+ (instancetype)applicationTemporaryDirectory {
    return [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
}

@end
