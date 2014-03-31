//
//  NSManagedObject+WXKit.m
//  Defects
//
//  Created by Charlie Wu on 21/03/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import "NSManagedObject+WXKit.h"

@implementation NSManagedObject (WXKit)

+ (NSFetchRequest *)fetchRequest
{
    return [[NSFetchRequest alloc] initWithEntityName:[self entityName]];
}

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
    if (self.managedObjectContext == context) return self;
    NSError *error;
    id object = [context existingObjectWithID:self.objectID error:&error];
    if (!error){
        return object;
    }
    return nil;
}

+ (instancetype)createInContext:(NSManagedObjectContext *)context
{
    __block id instance;

    void(^block)() = ^{
        instance  = [NSEntityDescription insertNewObjectForEntityForName:self.entityName inManagedObjectContext:context];
    };

    if (context.concurrencyType != NSPrivateQueueConcurrencyType) {
        block();
    } else {
        [context performBlockAndWait:block];
    }

    return instance;

}

+ (NSString *)entityName
{
    return NSStringFromClass(self);
}
@end
