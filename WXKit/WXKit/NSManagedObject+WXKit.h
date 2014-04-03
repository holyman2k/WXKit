//
//  NSManagedObject+WXKit.h
//  Defects
//
//  Created by Charlie Wu on 21/03/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (WXKit)

+ (NSString *)entityName;

+ (NSFetchRequest *)fetchRequest;

+ (instancetype)createInContext:(NSManagedObjectContext *)context;

+ (NSArray *)allInstancesInContext:(NSManagedObjectContext *)context;

+ (NSArray *)allInstancesWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;

+ (NSArray *)allInstancesWithPredicate:(NSPredicate *)predicate andSortDescripts:(NSArray *)sortDescriptors inContext:(NSManagedObjectContext *)context;

- (void)deleteInContext:(NSManagedObjectContext *)context;

- (instancetype)instanceInContext:(NSManagedObjectContext *)context;

@end
