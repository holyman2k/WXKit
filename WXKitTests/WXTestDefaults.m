//
//  WXTestDefaults.m
//  WXKit
//
//  Created by Charlie Wu on 4/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXTestDefaults.h"

@implementation WXTestDefaults

+ (NSURL *)persistenceStoreFolderUrl
{
    NSURL *url = [NSURL.applicationDocumentsDirectory URLByAppendingPathComponent:@"database"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:url.path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:url.path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return url;
}

+ (NSURL *)persistenceStoreUrl
{
    return [[self persistenceStoreFolderUrl] URLByAppendingPathComponent:@"persistentStore"];
}

@end
