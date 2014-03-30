//
//  NSManagedObjectContext+WXKit.m
//  Defects
//
//  Created by Charlie Wu on 21/03/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import "NSManagedObjectContext+WXKit.h"

@implementation NSManagedObjectContext (WXKit)

+ (instancetype)createAtUrl:(NSURL *)url mergePolice:(NSMergePolicyType)mergePoliceType andOptions:(NSDictionary *)options
{
    // Load Model name
    BOOL hasModelNameMethod = [[self class] respondsToSelector:@selector(modelName)];
    NSAssert(!hasModelNameMethod, @"%@  must implement +modelName", NSStringFromClass(self));
    NSString *modelName = [[self class] performSelector:@selector(modelName)];

    // Load Managed Object Model
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSAssert(modelURL != nil, @"could not find model name %@", modelName);
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

    // Create Persistence Store Coordinator
    NSString *storeType = url ? NSInMemoryStoreType : NSSQLiteStoreType;
    NSError *error = nil;
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];

    // Add Persisence Store
    if (![persistentStoreCoordinator addPersistentStoreWithType:storeType configuration:nil URL:url options:options error:&error]) {
        if ([error code] == NSMigrationMissingSourceModelError) {
            NSLog(@"Migration failed try to deleting url  %@", url.path);
        } else {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        abort();
    }

    // Create Managed Object Context
    NSMergePolicy *mergePolice = [[NSMergePolicy alloc] initWithMergeType:mergePoliceType];
    id context = [[self alloc] init];
    [context setPersistentStoreCoordinator:persistentStoreCoordinator];
    [context setMergePolicy: mergePolice];

    return context;
}

@end
