//
//  NSManagedObject+WXKit.m
//  Defects
//
//  Created by Charlie Wu on 21/03/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import "NSManagedObject+WXKit.h"

@implementation NSManagedObject (WXKit)

+ (NSString *)entityName
{
    return NSStringFromClass(self);
}

+ (instancetype)createInContext:(NSManagedObjectContext *)context
{
    __block id instance;

    [context performBlockRegardConcurrentTypeAndWait:^{
        instance  = [NSEntityDescription insertNewObjectForEntityForName:self.entityName inManagedObjectContext:context];
    }];

    return instance;
}

+ (NSArray *)allInstancesInContext:(NSManagedObjectContext *)context
{
    return [self allInstancesWithPredicate:nil andSortDescripts:nil inContext:context];
}

+ (NSArray *)allInstancesWithPredicate:(NSPredicate *)predicate
                             inContext:(NSManagedObjectContext *)context
{
    return [self allInstancesWithPredicate:predicate andSortDescripts:nil inContext:context];
}

+ (NSArray *)allInstancesWithPredicate:(NSPredicate *)predicate
                     andSortDescripts:(NSArray *)sortDescriptors
                            inContext:(NSManagedObjectContext *)context
{
    __block NSArray *instances;

    [context performBlockRegardConcurrentTypeAndWait:^{
        NSFetchRequest *request = [self fetchRequest];
        request.predicate = predicate;
        request.sortDescriptors = sortDescriptors ?  sortDescriptors : @[];
        instances = [context executeFetchRequest:request error:nil];
    }];

    return instances;
}

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
@end
