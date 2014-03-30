//
//  NSManagedObject+WXKit.h
//  Defects
//
//  Created by Charlie Wu on 21/03/2014.
//  Copyright (c) 2014 WebFM Pty Ltd. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (WXKit)

- (void)deleteInContext:(NSManagedObjectContext *)context;

- (instancetype)instanceInContext:(NSManagedObjectContext *)context;

+ (instancetype)createInContext:(NSManagedObjectContext *)context;

+ (NSString *)entityName;

@end
