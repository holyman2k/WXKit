//
//  NSManagedObjectContext+WXKit.h
//  Defects
//
//  Created by Charlie Wu on 21/03/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (WXKit)

+ (instancetype)createAtUrl:(NSURL *)url modelName:(NSString *)modelName mergePolice:(NSMergePolicyType)mergePoliceType andOptions:(NSDictionary *)options;

+ (BOOL)storeNeedsMigrationAtURL:(NSURL *)sourceStoreUrl modelName:(NSString *)modelName;

@end
