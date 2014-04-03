//
//  WXManagedObjectContextTests.m
//  WXKit
//
//  Created by Charlie Wu on 4/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSManagedObjectContext+WXKit.h"
#import "WXAccount.h"
#import "WXCompany.h"

@interface WXManagedObjectContextTests : XCTestCase

@end

@implementation WXManagedObjectContextTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreateContext
{
    NSURL *url = [WXTestDefaults persistenceStoreUrl];

    NSManagedObjectContext *context = [NSManagedObjectContext createAtUrl:url modelName:@"WXKit" mergePolice:NSMergeByPropertyObjectTrumpMergePolicyType andOptions:nil];

    WXAccount *account = [WXAccount createInContext:context];
    account.username = @"test user name";
    WXCompany *company = [WXCompany createInContext:context];
    account.company = company;
    [company addAccountObject:account];

    NSError *error;
    [context save:&error];
    XCTAssertNotNil(context, @"context not nil");
    XCTAssertNil(error, @"no save error");

    [[NSFileManager defaultManager] removeItemAtURL:[WXTestDefaults persistenceStoreUrl] error:nil];
}

@end
