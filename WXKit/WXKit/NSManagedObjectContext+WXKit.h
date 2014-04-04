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
 * @param mergePoliceType   merge policy type
 * @param options           persistence store options
 * @return managed object context
 * @discussion to use method, sub class NSManagedObjectContext and implement method - (NSString *)modelName
 */
+ (instancetype)createAtUrl:(NSURL *)url mergePolice:(NSMergePolicyType)mergePolicyType andOptions:(NSDictionary *)options;

/*!
 * @brief create managed context
 * @param url               url storing the persistence store
 * @param modelName         managed Object Model filename
 * @param mergePoliceType   merge policy type
 * @param options           persistence store options
 * @return managed object context
 */
+ (instancetype)createAtUrl:(NSURL *)url modelName:(NSString *)modelName mergePolice:(NSMergePolicyType)mergePolicyType andOptions:(NSDictionary *)options;

/*!
 * @brief check if managed object context persistence store require migration
 * @param sourceStoreUrl    source persistence store url
 * @param modelName         managed object context name
 */
+ (BOOL)storeNeedsMigrationAtURL:(NSURL *)sourceStoreUrl modelName:(NSString *)modelName;

@end
