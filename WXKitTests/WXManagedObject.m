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

- (void)testCreate
{
    WXAccount *account = [WXAccount createInContext:self.context];
    account.username = @"hello";
    account.company = [WXCompany createInContext:self.context];

    NSError *error;

    [self.context save:&error];

    XCTAssertNil(error, @"save context");

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"WXAccount"];
    NSArray *accounts = [self.context executeFetchRequest:request error:&error];

    XCTAssertNil(error, @"fetch account");

    XCTAssertEqualObjects([accounts.firstObject username], account.username, @"created object match");
    XCTAssertEqualObjects([accounts.firstObject company], account.company, @"created object match");
}

@end
