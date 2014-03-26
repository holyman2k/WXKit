//
//  NSManagedObjectContext+WXKit.m
//  Defects
//
//  Created by Charlie Wu on 21/03/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import "NSManagedObjectContext+WXKit.h"

@implementation NSManagedObjectContext (WXKit)

- (void)saveContext
{
    NSError *error;
    [self save:&error];
    if (error)CLS_LOG(@"save context failed %@", error);
}

@end
