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
    NSError *error = nil;
    if ([self hasChanges] && ![self save:&error]) {
        NSArray * conflictListArray = (NSArray*)[[error userInfo] objectForKey:@"conflictList"];
        NSError * conflictFixError = nil;
        if ([conflictListArray count] > 0) {
            NSMergePolicy *mergePolicy = [[NSMergePolicy alloc] initWithMergeType:NSRollbackMergePolicyType];

            if (![mergePolicy resolveConflicts:conflictListArray error:&conflictFixError]) {
                NSLog(@"Unresolved conflict error %@, %@", conflictFixError, [conflictFixError userInfo]);
                NSLog(@"abort");
                abort();
            }
        }
    }
}

@end
