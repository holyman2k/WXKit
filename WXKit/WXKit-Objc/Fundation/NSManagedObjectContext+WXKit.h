//
//  NSManagedObjectContext+WXKit.h
//  Defects
//
//  Created by Charlie Wu on 21/03/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (WXKit)

/*!
 * @brief create managed context, recommend to pass in light weight migration for option
 * @param url               url storing the persistence store
 * @param mergePolicyType   merge policy type
 * @param options           persistence store options
 * @return managed object context
 * @discussion to use method, sub class NSManagedObjectContext and implement method - (NSString *)modelName
 */
+ (instancetype)createAtUrl:(NSURL *)url mergePolicy:(NSMergePolicyType)mergePolicyType andOptions:(NSDictionary *)options;

/*!
 * @brief create managed context
 * @param url               url storing the persistence store
 * @param modelName         managed Object Model filename
 * @param mergePolicyType   merge policy type
 * @param options           persistence store options
 * @return managed object context
 */
+ (instancetype)createAtUrl:(NSURL *)url modelName:(NSString *)modelName mergePolicy:(NSMergePolicyType)mergePolicyType andOptions:(NSDictionary *)options;

/*!
 * @brief check if managed object context persistence store require migration
 * @param sourceStoreUrl    source persistence store url
 * @param modelName         managed object context name
 */
+ (BOOL)storeNeedsMigrationAtURL:(NSURL *)sourceStoreUrl modelName:(NSString *)modelName;

/*!
 * @brief create a private context
 * @param observer pass in an auto releasing id to keep track of the observer
 * @code
 * id observer;
 * NSManagedObjectContext *privateContext = [mainContext privateContextWithObserver:&observer];
 * .. use private context
 * [privateContext save:&error];
 * [mainContext removeObserver:observer];
 * @endcode
 */
- (instancetype)privateContextWithObserver:(__autoreleasing id *)observer;

/*!
 * @brief called from main context to remove private context merge observer
 */
- (void)removeObserver:(id)observer;

@end
