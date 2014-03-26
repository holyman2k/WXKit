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
        //        // Replace this implementation with code to handle the error appropriately.
        //        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        //        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //        abort();


        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);

        NSArray * conflictListArray = (NSArray*)[[error userInfo] objectForKey:@"conflictList"];
        NSLog(@"conflict array: %@",conflictListArray);
        NSError * conflictFixError = nil;

        if ([conflictListArray count] > 0) {

            NSMergePolicy *mergePolicy = [[NSMergePolicy alloc] initWithMergeType:NSOverwriteMergePolicyType];

            if (![mergePolicy resolveConflicts:conflictListArray error:&conflictFixError]) {
                NSLog(@"Unresolved conflict error %@, %@", conflictFixError, [conflictFixError userInfo]);
                NSLog(@"abort");
                abort();
            }
        }
    }
}

@end
