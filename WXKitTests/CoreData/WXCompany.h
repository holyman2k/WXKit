//
//  WXCompany.h
//  WXKit
//
//  Created by Charlie Wu on 4/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WXAccount;

@interface WXCompany : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *account;
@end

@interface WXCompany (CoreDataGeneratedAccessors)

- (void)addAccountObject:(WXAccount *)value;
- (void)removeAccountObject:(WXAccount *)value;
- (void)addAccount:(NSSet *)values;
- (void)removeAccount:(NSSet *)values;

@end
