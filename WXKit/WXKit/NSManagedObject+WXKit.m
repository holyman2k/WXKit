//
//  NSManagedObject+WXKit.m
//  Defects
//
//  Created by Charlie Wu on 21/03/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import "NSManagedObject+WXKit.h"

@implementation NSManagedObject (WXKit)

- (void)deleteInContext:(NSManagedObjectContext *)context
{
    id instaceInContext = self.managedObjectContext != context ? [self instanceInContext:context] : self;
    if (context.concurrencyType == NSPrivateQueueConcurrencyType) {
        [context performBlockAndWait:^{
            [context deleteObject:instaceInContext];
        }];
    } else {
        [context deleteObject:instaceInContext];
    }

}

- (instancetype)instanceInContext:(NSManagedObjectContext *)context
{
    NSError *error;
    id object = [context existingObjectWithID:self.objectID error:&error];
    if (!error){
        return object;
    }
    return nil;
}

+ (instancetype)createInContext:(NSManagedObjectContext *)context
{
    NSString *class = [NSString stringWithFormat:@"%@", [self class]];
    id instance = [NSEntityDescription insertNewObjectForEntityForName:class inManagedObjectContext:context];
    return instance;

}
@end
