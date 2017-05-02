//
//  NSManagedObject+WXKit.m
//  Defects
//
//  Created by Charlie Wu on 21/03/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import "NSManagedObject+WXKit.h"
#import "NSManagedObjectContext+WXKit.h"
#import <Foundation/Foundation.h>

@implementation NSManagedObject (WXKit)

+ (NSString *)entityName
{
    return NSStringFromClass(self);
}

+ (instancetype)createInContext:(NSManagedObjectContext *)context
{
    __block id instance;
    [context performBlockAndWait:^{
        instance = [NSEntityDescription insertNewObjectForEntityForName:self.entityName inManagedObjectContext:context];
    }];
    return instance;
}

+ (instancetype)createInContext:(NSManagedObjectContext *)context withBuilderBlock:(void(^)(id me))block;
{
    __block id instance = [self createInContext:context];
    [context performBlockAndWait:^{
        block(instance);
    }];
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
    __block NSArray *instances;
    [context performBlockAndWait:^{
        NSFetchRequest *request = [self fetchRequestWithPredicate:predicate andSortDescriptors:sortDescriptors];
        instances = [context executeFetchRequest:request error:nil];
    }];
    return instances;
}

//+ (NSFetchRequest *)fetchRequest
//{
//    return [self fetchRequestWithPredicate:nil andSortDescriptors:nil];
//}

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

+ (NSMutableDictionary *)dictionaryWithIdKeyPath:(NSString *)keyPath andPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context
{
    NSArray *list = [self allInstancesWithPredicate:predicate inContext:context];

    __block NSMutableDictionary *dictionary;
    [context performBlockAndWait:^{
        dictionary = [NSMutableDictionary dictionaryWithObjects:list forKeys:[list valueForKey:keyPath]];
    }];
    return dictionary;
}

- (void)deleteInContext:(NSManagedObjectContext *)context
{
    id instaceInContext = self.managedObjectContext != context ? [self instanceInContext:context] : self; 
    if (instaceInContext == nil) return;
    
    [context performBlockAndWait:^{
        [context deleteObject:instaceInContext];
    }];
}

- (instancetype)instanceInContext:(NSManagedObjectContext *)context
{
    if (self.managedObjectContext == context) return self;
    __block NSError *error;
    __block id instance;
    [context performBlockAndWait:^{
        instance = [context existingObjectWithID:self.objectID error:&error];
    }];
    if (!error) return instance;
    return nil;
}

- (BOOL)isDeletedOrNilContext
{
    return self.isDeleted || self.managedObjectContext == nil;
}
@end
