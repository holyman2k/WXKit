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
     id instance = [NSEntityDescription insertNewObjectForEntityForName:self.entityName inManagedObjectContext:context];

    return instance;
}

+ (NSArray *)allInstancesInContext:(NSManagedObjectContext *)context
{
    return [self allInstancesWithPredicate:nil andSortDescriptors:nil inContext:context];
}

+ (NSArray *)allInstancesWithPredicate:(NSPredicate *)predicate
                             inContext:(NSManagedObjectContext *)context
{
    return [self allInstancesWithPredicate:predicate andSortDescriptors:nil inContext:context];
}

+ (NSArray *)allInstancesWithPredicate:(NSPredicate *)predicate
                     andSortDescriptors:(NSArray *)sortDescriptors
                            inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [self fetchRequestWithPredicate:predicate andSortDescriptors:sortDescriptors];
    NSArray *instances = [context executeFetchRequest:request error:nil];

    return instances;
}

+ (NSFetchRequest *)fetchRequest
{
    return [self fetchRequestWithPredicate:nil andSortDescriptors:nil];
}

+ (NSFetchRequest *)fetchRequestWithPredicate:(NSPredicate *)predicate
{
    return [self fetchRequestWithPredicate:predicate andSortDescriptors:@[]];
}

+ (NSFetchRequest *)fetchRequestWithPredicate:(NSPredicate *)predicate andSortDescriptors:(NSArray *)sortDescriptors
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[self entityName]];
    request.predicate = predicate;
    request.sortDescriptors = sortDescriptors;
    return request;

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
