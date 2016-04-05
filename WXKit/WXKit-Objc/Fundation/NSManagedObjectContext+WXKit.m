//
//  NSManagedObjectContext+WXKit.m
//  Defects
//
//  Created by Charlie Wu on 21/03/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import "NSManagedObjectContext+WXKit.h"
#import "UIDevice+WXKit.h"

@implementation NSManagedObjectContext (WXKit)

+ (instancetype)createAtUrl:(NSURL *)url mergePolicy:(NSMergePolicyType)mergePolicyType andOptions:(NSDictionary *)options
{
    // Load Model name
    NSAssert(![[self class] respondsToSelector:@selector(modelName)], @"%@  must implement +modelName", NSStringFromClass(self));
    NSString *modelName = [[self class] performSelector:@selector(modelName)];
    NSAssert(modelName, @"must have valid model name");

    return [self createAtUrl:url modelName:modelName mergePolicy:mergePolicyType andOptions:options];
}

+ (instancetype)createAtUrl:(NSURL *)url modelName:(NSString *)modelName mergePolicy:(NSMergePolicyType)mergePolicyType andOptions:(NSDictionary *)options
{
    // Load Managed Object Model
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSAssert(modelURL != nil, @"could not find model name %@", modelName);
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

    // Create Persistence Store Coordinator
    NSString *storeType = url ? NSSQLiteStoreType : NSInMemoryStoreType;
    NSError *error = nil;
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];

    // Add Persisence Store
    if (![persistentStoreCoordinator addPersistentStoreWithType:storeType configuration:nil URL:url options:options error:&error]) {
        if ([error code] == NSMigrationMissingSourceModelError) {
            NSLog(@"Migration failed try to deleting url  %@", url.path);
        } else {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
#if DEBUG
        [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
#endif
        /*
         Replace this implementation with code to handle the error appropriately.

         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.


         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.

         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]

         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}

         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.

         */
        abort();
    }

    // Create Managed Object Context
    NSMergePolicy *mergePolice = [[NSMergePolicy alloc] initWithMergeType:mergePolicyType];
    id context = [[self alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [context setPersistentStoreCoordinator:persistentStoreCoordinator];
    [context setMergePolicy: mergePolice];

    return context;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
+ (BOOL)storeNeedsMigrationAtURL:(NSURL *)sourceStoreUrl modelName:(NSString *)modelName
{
    BOOL compatibile = NO;
    NSError *error = nil;

    // Load model
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSAssert(modelURL != nil, @"could not find model name %@", modelName);
    NSManagedObjectModel *destinationModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

    NSDictionary *sourceMetadata;
    if ([UIDevice currentDeviceSystemVersion] < 9) {
        sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:sourceStoreUrl error:&error];
    } else {
        sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:sourceStoreUrl options:nil error:&error];
    }

    if (sourceMetadata != nil) {
        compatibile = [destinationModel isConfiguration:nil compatibleWithStoreMetadata:sourceMetadata];
    } else {
        NSLog(@"source meta data missing");
    }

    return !compatibile;
}
#pragma clang diagnostic pop

+ (NSString *)modelName
{
    return nil;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)safelyPerformBlockAndWait:(void (^)())block
{
    if (self.concurrencyType == NSConfinementConcurrencyType) {
        if ([NSThread isMainThread]) {
            block();
        } else {
            dispatch_sync(dispatch_get_main_queue(), block);
        }
    } else {
        [self performBlockAndWait:block];
    }
}
#pragma clang diagnostic pop

- (instancetype)privateContextWithObserver:(__autoreleasing id *)observer
{
    NSAssert(![NSThread isMainThread], @"must not be in main thread");
    NSManagedObjectContext *privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    privateContext.persistentStoreCoordinator = self.persistentStoreCoordinator;

    *observer = [[NSNotificationCenter defaultCenter] addObserverForName:NSManagedObjectContextDidSaveNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      NSManagedObjectContext *moc = self;
                                                      if (note.object != moc) {
                                                          [moc mergeChangesFromContextDidSaveNotification:note];
                                                      }
                                                  }];
    return privateContext;
}

- (void)removeObserver:(id)observer
{
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
}

@end
