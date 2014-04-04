//
//  WXManagedObject.m
//  WXKit
//
//  Created by Charlie Wu on 4/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WXAccount.h"
#import "WXCompany.h"

@interface WXManagedObject : XCTestCase
@property (strong, nonatomic) NSManagedObjectContext *context;
@end

@implementation WXManagedObject

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.context = [NSManagedObjectContext createAtUrl:[WXTestDefaults persistenceStoreUrl] modelName:@"WXKit" mergePolice:NSOverwriteMergePolicyType andOptions:nil];
    XCTAssertNotNil(self.context, @"setup context");
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.context = nil;
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtURL:[WXTestDefaults persistenceStoreFolderUrl] error:&error];
    XCTAssertNil(error, @"delete persistence store");
    [super tearDown];
}

- (void)testEntityName
{
    XCTAssertEqualObjects([WXAccount entityName], @"WXAccount", @"entity name match");
    XCTAssertNotEqualObjects([WXAccount entityName], @"WXCompany", @"entity name match");

    XCTAssertEqualObjects([WXCompany entityName], @"WXCompany", @"entity name match");
    XCTAssertNotEqualObjects([WXCompany entityName], @"WXAccount", @"entity name match");
}

- (void)testCreateInContext
{
    NSError *error;
    WXAccount *account = [WXAccount createInContext:self.context];
    account.company = [WXCompany createInContext:self.context];

    [self.context save:&error];
    XCTAssertNotNil(error, @"account need compay");
    account.username = @"hello";

    error = nil;
    [self.context save:&error];

    XCTAssertNil(error, @"save context");

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"WXAccount"];
    NSArray *accounts = [self.context executeFetchRequest:request error:&error];

    XCTAssertNil(error, @"fetch account");

    XCTAssertEqualObjects([accounts.firstObject username], account.username, @"created object match");
    XCTAssertEqualObjects([accounts.firstObject company], account.company, @"created object match");
}

- (void)testFetchRequest
{
    NSError *error;
    XCTAssertEqual([self.context countForFetchRequest:WXAccount.fetchRequest error:&error], 0, @"no accounts");

    WXAccount *account = [WXAccount createInContext:self.context];
    account.company = [WXCompany createInContext:self.context];
    account.username = @"hello";
    [self.context save:&error];
    XCTAssertNil(error, @"saved without error");

    NSArray *accounts = [self.context executeFetchRequest:WXAccount.fetchRequest error:&error];

    XCTAssertNotNil(accounts, "fetch 1 account");
    XCTAssertEqual(accounts.count, 1, "fetch 1 account");

    XCTAssertEqualObjects([accounts.firstObject username], account.username, @"match entity value");
    XCTAssertEqualObjects([accounts.firstObject company], account.company, @"match entity value");

    XCTAssertNotEqualObjects([accounts.firstObject username], @"no name", @"match entity value");
    XCTAssertNotEqualObjects([accounts.firstObject company], @"no name", @"match entity value");
}

- (void)testFetchRequestWithPredicate
{
    NSError *error;

    WXAccount *account1 = [WXAccount createInContext:self.context];
    account1.company = [WXCompany createInContext:self.context];
    account1.username = @"account 1";

    WXAccount *account2 = [WXAccount createInContext:self.context];
    account2.company = [WXCompany createInContext:self.context];
    account2.username = @"account 2";

    [self.context save:&error];

    XCTAssertNil(error, @"saved without error");

    NSFetchRequest *request = [WXAccount fetchRequestWithPredicate:[NSPredicate predicateWithFormat:@"username = %@", account1.username]];
    NSArray *accounts = [self.context executeFetchRequest:request error:&error];

    XCTAssertNotNil(accounts, "fetch 1 account");
    XCTAssertEqual(accounts.count, 1, "fetch 1 account");

    XCTAssertEqualObjects([accounts.firstObject username], account1.username, @"match entity value");
    XCTAssertEqualObjects([accounts.firstObject company], account1.company, @"match entity value");

    XCTAssertNotEqualObjects([accounts.firstObject username], @"no name", @"match entity value");
    XCTAssertNotEqualObjects([accounts.firstObject company], @"no name", @"match entity value");


    request = [WXAccount fetchRequestWithPredicate:[NSPredicate predicateWithFormat:@"username = %@", account2.username]];
    accounts = [self.context executeFetchRequest:request error:&error];

    XCTAssertNotNil(accounts, "fetch 1 account");
    XCTAssertEqual(accounts.count, 1, "fetch 1 account");

    XCTAssertEqualObjects([accounts.firstObject username], account2.username, @"match entity value");
    XCTAssertEqualObjects([accounts.firstObject company], account2.company, @"match entity value");

    XCTAssertNotEqualObjects([accounts.firstObject username], @"no name", @"match entity value");
    XCTAssertNotEqualObjects([accounts.firstObject company], @"no name", @"match entity value");
}

- (void)testFetchRequestWithPredicateWithSortDescriptor
{
    NSError *error;

    WXAccount *account1 = [WXAccount createInContext:self.context];
    account1.company = [WXCompany createInContext:self.context];
    account1.username = @"account 1";

    WXAccount *account2 = [WXAccount createInContext:self.context];
    account2.company = [WXCompany createInContext:self.context];
    account2.username = @"account 2";

    WXAccount *account3 = [WXAccount createInContext:self.context];
    account3.company = [WXCompany createInContext:self.context];
    account3.username = @"account 3";

    [self.context save:&error];

    XCTAssertNil(error, @"saved without error");

    NSFetchRequest *request = [WXAccount fetchRequestWithPredicate:[NSPredicate predicateWithFormat:@"username = %@", account1.username] andSortDescripts:nil];
    NSArray *accounts = [self.context executeFetchRequest:request error:&error];

    XCTAssertNotNil(accounts, "fetch 1 account");
    XCTAssertEqual(accounts.count, 1, "fetch 1 account");

    XCTAssertEqualObjects([accounts.firstObject username], account1.username, @"match entity value");
    XCTAssertEqualObjects([accounts.firstObject company], account1.company, @"match entity value");

    XCTAssertNotEqualObjects([accounts.firstObject username], @"no name", @"match entity value");
    XCTAssertNotEqualObjects([accounts.firstObject company], @"no name", @"match entity value");


    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"username" ascending:YES]];

    request = [WXAccount fetchRequestWithPredicate:[NSPredicate predicateWithFormat:@"username MATCHES '^account [0-9]'"] andSortDescripts:sortDescriptors];
    accounts = [self.context executeFetchRequest:request error:&error];

    XCTAssertNotNil(accounts, "fetch accounts");
    XCTAssertEqual(accounts.count, 3, "fetch 3 account");

    XCTAssertEqualObjects([accounts.firstObject username], account1.username, @"match entity value");
    XCTAssertEqualObjects([accounts.firstObject company], account1.company, @"match entity value");

    XCTAssertEqualObjects([accounts.lastObject username], account3.username, @"match entity value");
    XCTAssertEqualObjects([accounts.lastObject company], account3.company, @"match entity value");

    XCTAssertNotEqualObjects([accounts.firstObject username], @"no name", @"match entity value");
    XCTAssertNotEqualObjects([accounts.firstObject company], @"no name", @"match entity value");
}

- (void)testAllInstance
{
    NSError *error;
    XCTAssertEqual([self.context countForFetchRequest:WXAccount.fetchRequest error:&error], 0, @"no accounts");

    WXAccount *account = [WXAccount createInContext:self.context];
    account.company = [WXCompany createInContext:self.context];
    account.username = @"hello";
    [self.context save:&error];
    XCTAssertNil(error, @"saved without error");

    NSArray *accounts = [WXAccount allInstancesInContext:self.context];

    XCTAssertNotNil(accounts, "fetch 1 account");
    XCTAssertEqual(accounts.count, 1, "fetch 1 account");

    XCTAssertEqualObjects([accounts.firstObject username], account.username, @"match entity value");
    XCTAssertEqualObjects([accounts.firstObject company], account.company, @"match entity value");

    XCTAssertNotEqualObjects([accounts.firstObject username], @"no name", @"match entity value");
    XCTAssertNotEqualObjects([accounts.firstObject company], @"no name", @"match entity value");
}

- (void)testAllInstanceWithPredicate
{
    NSError *error;

    WXAccount *account1 = [WXAccount createInContext:self.context];
    account1.company = [WXCompany createInContext:self.context];
    account1.username = @"account 1";

    WXAccount *account2 = [WXAccount createInContext:self.context];
    account2.company = [WXCompany createInContext:self.context];
    account2.username = @"account 2";

    [self.context save:&error];

    XCTAssertNil(error, @"saved without error");

    NSArray *accounts = [WXAccount allInstancesWithPredicate:[NSPredicate predicateWithFormat:@"username = %@", account1.username] inContext:self.context];

    XCTAssertNotNil(accounts, "fetch 1 account");
    XCTAssertEqual(accounts.count, 1, "fetch 1 account");

    XCTAssertEqualObjects([accounts.firstObject username], account1.username, @"match entity value");
    XCTAssertEqualObjects([accounts.firstObject company], account1.company, @"match entity value");

    XCTAssertNotEqualObjects([accounts.firstObject username], @"no name", @"match entity value");
    XCTAssertNotEqualObjects([accounts.firstObject company], @"no name", @"match entity value");

    accounts = [WXAccount allInstancesWithPredicate:[NSPredicate predicateWithFormat:@"username = %@", account2.username] inContext:self.context];

    XCTAssertNotNil(accounts, "fetch 1 account");
    XCTAssertEqual(accounts.count, 1, "fetch 1 account");

    XCTAssertEqualObjects([accounts.firstObject username], account2.username, @"match entity value");
    XCTAssertEqualObjects([accounts.firstObject company], account2.company, @"match entity value");

    XCTAssertNotEqualObjects([accounts.firstObject username], @"no name", @"match entity value");
    XCTAssertNotEqualObjects([accounts.firstObject company], @"no name", @"match entity value");
}

- (void)testAllInstancetWithPredicateWithSortDescriptor
{
    NSError *error;

    WXAccount *account1 = [WXAccount createInContext:self.context];
    account1.company = [WXCompany createInContext:self.context];
    account1.username = @"account 1";

    WXAccount *account2 = [WXAccount createInContext:self.context];
    account2.company = [WXCompany createInContext:self.context];
    account2.username = @"account 2";

    WXAccount *account3 = [WXAccount createInContext:self.context];
    account3.company = [WXCompany createInContext:self.context];
    account3.username = @"account 3";

    [self.context save:&error];

    XCTAssertNil(error, @"saved without error");

    NSArray *accounts = [WXAccount allInstancesWithPredicate:[NSPredicate predicateWithFormat:@"username = %@", account1.username] andSortDescripts:nil inContext:self.context];

    XCTAssertNotNil(accounts, "fetch 1 account");
    XCTAssertEqual(accounts.count, 1, "fetch 1 account");

    XCTAssertEqualObjects([accounts.firstObject username], account1.username, @"match entity value");
    XCTAssertEqualObjects([accounts.firstObject company], account1.company, @"match entity value");

    XCTAssertNotEqualObjects([accounts.firstObject username], @"no name", @"match entity value");
    XCTAssertNotEqualObjects([accounts.firstObject company], @"no name", @"match entity value");


    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"username" ascending:YES]];

    accounts = [WXAccount allInstancesWithPredicate:[NSPredicate predicateWithFormat:@"username MATCHES '^account [0-9]'"] andSortDescripts:sortDescriptors inContext:self.context];

    XCTAssertNotNil(accounts, "fetch accounts");
    XCTAssertEqual(accounts.count, 3, "fetch 3 account");

    XCTAssertEqualObjects([accounts.firstObject username], account1.username, @"match entity value");
    XCTAssertEqualObjects([accounts.firstObject company], account1.company, @"match entity value");

    XCTAssertEqualObjects([accounts.lastObject username], account3.username, @"match entity value");
    XCTAssertEqualObjects([accounts.lastObject company], account3.company, @"match entity value");

    XCTAssertNotEqualObjects([accounts.firstObject username], @"no name", @"match entity value");
    XCTAssertNotEqualObjects([accounts.firstObject company], @"no name", @"match entity value");
}

@end
