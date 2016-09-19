//
//  NSManagedObject+WXKit.h
//  Defects
//
//  Created by Charlie Wu on 21/03/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (WXKit)

/*!
 * @brief entity name
 * @return string value of entity name
 */
+ (NSString *)entityName;

/*!
 * @brief create new instance in context
 */
+ (instancetype)createInContext:(NSManagedObjectContext *)context;

/*!
 * @brief create new instance in context
 * @param context managed object context
 * @param block a block with self as param for initalization.  Thread safe.
 */
+ (instancetype)createInContext:(NSManagedObjectContext *)context withBuilderBlock:(void(^)(id me))block;

#ifndef __AVAILABILITY_INTERNAL__IPHONE_10_0

/*!
 * @brief create basic fetch request
 * @return NSFetchRequest for this Entity Class
 */
+ (NSFetchRequest *)fetchRequest;

#endif

/*!
 * @brief create basic fetch request with predicate
 * @param predicate     predicate for filtering
 * @return NSFetchRequest for this Entity Class
 */
+ (NSFetchRequest *)fetchRequestWithPredicate:(NSPredicate *)predicate;

/*!
 * @brief create basic fetch request with predicate
 * @param predicate         predicate for filtering
 * @param sortDescriptors   list of NSSortDescriptors, can be nil
 * @return NSFetchRequest for this Entity Class
 */
+ (NSFetchRequest *)fetchRequestWithPredicate:(NSPredicate *)predicate andSortDescriptors:(NSArray *)sortDescriptors;

/*!
 * @brief fetch all instances from context
 * @return all entities from context
 */
+ (NSArray *)allInstancesInContext:(NSManagedObjectContext *)context;

/*!
 * @brief fetch all instances match predicate from context
 * @return all entities from context match predicate
 */
+ (NSArray *)allInstancesWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;

/*!
 * @brief fetch all instances match predicate from context and sort by sort descriptors
 * @param predicate predicate or compond predicte
 * @return all entities from context match predicated sorted by sort descriptors
 */
+ (NSArray *)allInstancesWithPredicate:(NSPredicate *)predicate andSortDescriptors:(NSArray *)sortDescriptors inContext:(NSManagedObjectContext *)context;

/*!
 * @brief return a dictionary with Id Key Path value as the key
 * @param keyPath property name to be used as the dictionary key
 * @param predicate predicate or compond predicte
 * @return all entities from context match predicated sorted by sort descriptors
 */
+ (NSMutableDictionary *)dictionaryWithIdKeyPath:(NSString *)keyPath andPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;

/*!
 * @brief delete entity from context
 */
- (void)deleteInContext:(NSManagedObjectContext *)context;

/*!
 * @brief fetch the same entity from context
 * @discussion if current entity belong to context return value will be the same as this instance
 */
- (instancetype)instanceInContext:(NSManagedObjectContext *)context;


/*!
 * @brief if the defect will be deleted on next save or has already been deleted
 */
- (BOOL)isDeletedOrNilContext;
@end
