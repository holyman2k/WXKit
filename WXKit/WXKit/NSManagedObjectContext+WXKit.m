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
    NSAssert(![[self class] respondsToSelector:@selector(modelName)], @"%@  must implement +modelName", NSStringFromClass(self));
    NSString *modelName = [[self class] performSelector:@selector(modelName)];
    NSAssert(modelName, @"must have valid model name");

    return [self createAtUrl:url modelName:modelName mergePolice:mergePoliceType andOptions:options];
}

+ (instancetype)createAtUrl:(NSURL *)url modelName:(NSString *)modelName mergePolice:(NSMergePolicyType)mergePoliceType andOptions:(NSDictionary *)options
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
        abort();
    }

    // Create Managed Object Context
    NSMergePolicy *mergePolice = [[NSMergePolicy alloc] initWithMergeType:mergePoliceType];
    id context = [[self alloc] init];
    [context setPersistentStoreCoordinator:persistentStoreCoordinator];
    [context setMergePolicy: mergePolice];

    return context;
}

+ (BOOL)storeNeedsMigrationAtURL:(NSURL *)sourceStoreUrl modelName:(NSString *)modelName
{
    BOOL compatibile = NO;
    NSError *error = nil;

    // Load model
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSAssert(modelURL != nil, @"could not find model name %@", modelName);
    NSManagedObjectModel *destinationModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:nil URL:sourceStoreUrl error:&error];

    if (sourceMetadata != nil) {
        compatibile = [destinationModel isConfiguration:nil compatibleWithStoreMetadata:sourceMetadata];
    } else {
        NSLog(@"source meta data missing");
    }

    return !compatibile;
}

+ (NSString *)modelName
{
    return nil;
}
@end
