//
//  WXManagedObjectContextTests.m
//  WXKit
//
//  Created by Charlie Wu on 4/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
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

    NSManagedObjectContext *context = [NSManagedObjectContext createAtUrl:url
                                                                modelName:@"WXKit"
                                                              mergePolicy:NSMergeByPropertyObjectTrumpMergePolicyType
                                                               andOptions:nil];

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

- (void)testCreateContextFailed
{
    BOOL hasException = NO;
    NSURL *url = [WXTestDefaults persistenceStoreUrl];
    NSManagedObjectContext *context;
    @try {
         context = [NSManagedObjectContext createAtUrl:url modelName:@"a" mergePolicy:NSMergeByPropertyObjectTrumpMergePolicyType andOptions:nil];
    }
    @catch (NSException *exception) {
        XCTAssertNotNil(exception, @"failed");
        hasException = YES;
    }
    @finally {

    }

    XCTAssert(hasException, @"tested exception");
    XCTAssertNil(context, @"context not nil");
}

- (void)testPrivateContextSingleQueue
{
    NSManagedObjectContext *context = [NSManagedObjectContext createAtUrl:nil
                                                                modelName:@"WXKit"
                                                              mergePolicy:NSMergeByPropertyObjectTrumpMergePolicyType
                                                               andOptions:nil];

    __block BOOL queueCompleted = NO;
    NSUInteger runCount = 100;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSUInteger i = 0; i < runCount; i++) {
            __block NSError *error;
            __block BOOL saveResult = NO;

            id observer;
            NSManagedObjectContext *privateContext = [context privateContextWithObserver:&observer];

            WXAccount *account = [WXAccount createInContext:privateContext];
            account.username = @"test user name";
            WXCompany *company = [WXCompany createInContext:privateContext];
            account.company = company;
            [company addAccountObject:account];
            saveResult = [privateContext save:&error];

            [context removeObserver:observer];
            NSLog(@"queue completed %lu for context: %@", i + 1, privateContext);


            XCTAssert(saveResult, @"saved");
            XCTAssertNil(error, @"test");
            XCTAssertEqual([WXAccount allInstancesInContext:context].count, i+1, @"1 account");
            XCTAssertEqual([WXCompany allInstancesInContext:context].count, i+1, @"1 company");
            XCTAssertNotEqual([WXAccount allInstancesInContext:context].count, i+2, @"1 account");
            XCTAssertNotEqual([WXCompany allInstancesInContext:context].count, i+3, @"1 company");
        }

        queueCompleted = YES;
    });

    wait_while(queueCompleted, 10);

    XCTAssertEqual([WXAccount allInstancesInContext:context].count, runCount, @"1 account");
    XCTAssertEqual([WXCompany allInstancesInContext:context].count, runCount, @"1 company");
    XCTAssertNotEqual([WXAccount allInstancesInContext:context].count, runCount+1, @"1 account");
    XCTAssertNotEqual([WXCompany allInstancesInContext:context].count, runCount+3, @"1 company");
}

- (void)testPrivateContextMultipleQueue
{
    NSManagedObjectContext *context = [NSManagedObjectContext createAtUrl:nil
                                                                modelName:@"WXKit"
                                                              mergePolicy:NSMergeByPropertyObjectTrumpMergePolicyType
                                                               andOptions:nil];

    NSUInteger runCount = 100;
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    __block int completion = 0;
    for (NSUInteger i = 0; i < runCount; i++) {
        __block NSError *error;
        __block BOOL saveResult = NO;

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"start queue %lu", (unsigned long)i);
            id observer;
            NSManagedObjectContext *privateContext = [context privateContextWithObserver:&observer];

            WXAccount *account = [WXAccount createInContext:privateContext];
            account.username = @"test user name";
            WXCompany *company = [WXCompany createInContext:privateContext];
            account.company = company;
            [company addAccountObject:account];
            NSLog(@"save private context");
            saveResult = [privateContext save:&error];

            NSLog(@"start remove observer");
            [context removeObserver:observer];
            NSLog(@"queue completed %lu for context: %@", i, privateContext);

            XCTAssert(saveResult, @"saved");
            XCTAssertNil(error, @"test");
            completion ++;
        });
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (completion != runCount) {
            sleep(1);
        }
        [expectation fulfill];
    });

    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        XCTAssertEqual([WXAccount allInstancesInContext:context].count, runCount, @"1 account");
        XCTAssertEqual([WXCompany allInstancesInContext:context].count, runCount, @"1 company");
        XCTAssertNotEqual([WXAccount allInstancesInContext:context].count, runCount+1, @"1 account");
        XCTAssertNotEqual([WXCompany allInstancesInContext:context].count, runCount+3, @"1 company");
    }];
}

- (void)testPerformBlockMainThread
{
    NSManagedObjectContext *context = [NSManagedObjectContext createAtUrl:nil
                                                                modelName:@"WXKit"
                                                              mergePolicy:NSMergeByPropertyObjectTrumpMergePolicyType
                                                               andOptions:nil];

    __block NSError *error;
    __block BOOL saveResult = NO;

    [context safelyPerformBlockAndWait:^{
        WXAccount *account = [WXAccount createInContext:context];
        account.username = @"test user name";
        WXCompany *company = [WXCompany createInContext:context];
        account.company = company;
        [company addAccountObject:account];
        saveResult = [context save:&error];

    }];

    XCTAssertNil(error, @"test");
    XCTAssert(saveResult, @"save successfully");
    
}

- (void)testSafelyPerformBlockBackgroundThread
{
    NSManagedObjectContext *context = [NSManagedObjectContext createAtUrl:nil
                                                                modelName:@"WXKit"
                                                              mergePolicy:NSMergeByPropertyObjectTrumpMergePolicyType
                                                               andOptions:nil];
    __block BOOL queueCompleted = NO;
    __block NSError *error;
    __block BOOL saveResult = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [context safelyPerformBlockAndWait:^{
            WXAccount *account = [WXAccount createInContext:context];
            account.username = @"test user name";
            WXCompany *company = [WXCompany createInContext:context];
            account.company = company;
            [company addAccountObject:account];
            saveResult = [context save:&error];
        }];
        queueCompleted = YES;
    });

    wait_while(queueCompleted, 10);

    XCTAssert(saveResult, @"saved");
    XCTAssertNil(error, @"test");
    XCTAssertEqual([WXAccount allInstancesInContext:context].count, 1, @"1 account");
    XCTAssertEqual([WXCompany allInstancesInContext:context].count, 1, @"1 company");
    XCTAssertNotEqual([WXAccount allInstancesInContext:context].count, 2, @"1 account");
    XCTAssertNotEqual([WXCompany allInstancesInContext:context].count, 3, @"1 company");
}

- (void)testSafelyPerformBlockMainThread
{
    NSManagedObjectContext *context = [NSManagedObjectContext createAtUrl:nil
                                                                modelName:@"WXKit"
                                                              mergePolicy:NSMergeByPropertyObjectTrumpMergePolicyType
                                                               andOptions:nil];

    __block BOOL saveResult = NO;
    __block NSError *error;
    [context safelyPerformBlockAndWait:^{
        WXAccount *account = [WXAccount createInContext:context];
        account.username = @"test user name";
        WXCompany *company = [WXCompany createInContext:context];
        account.company = company;
        [company addAccountObject:account];
        saveResult = [context save:&error];
    }];


    XCTAssert(saveResult, @"saved");
    XCTAssertNil(error, @"test");
    XCTAssertEqual([WXAccount allInstancesInContext:context].count, 1, @"1 account");
    XCTAssertEqual([WXCompany allInstancesInContext:context].count, 1, @"1 company");
    XCTAssertNotEqual([WXAccount allInstancesInContext:context].count, 2, @"1 account");
    XCTAssertNotEqual([WXCompany allInstancesInContext:context].count, 3, @"1 company");
}

- (void)testSafelyPerformBlockMainThreadMainContext
{
    NSManagedObjectContext *context = [NSManagedObjectContext createAtUrl:nil
                                                                modelName:@"WXKit"
                                                              mergePolicy:NSMergeByPropertyObjectTrumpMergePolicyType
                                                               andOptions:nil];

    NSManagedObjectContext *mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];

    mainContext.persistentStoreCoordinator = context.persistentStoreCoordinator;

    [[NSNotificationCenter defaultCenter] addObserverForName:NSManagedObjectContextDidSaveNotification
                                                      object:mainContext
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      if (note.object != context) {
                                                          [context mergeChangesFromContextDidSaveNotification:note];
                                                      }
                                                  }];

    __block BOOL saveResult = NO;
    __block NSError *error;
    [mainContext safelyPerformBlockAndWait:^{
        WXAccount *account = [WXAccount createInContext:mainContext];
        account.username = @"test user name";
        WXCompany *company = [WXCompany createInContext:mainContext];
        account.company = company;
        [company addAccountObject:account];
        saveResult = [mainContext save:&error];
    }];


    XCTAssert(saveResult, @"saved");
    XCTAssertNil(error, @"test");
    XCTAssertEqual([WXAccount allInstancesInContext:context].count, 1, @"1 account");
    XCTAssertEqual([WXCompany allInstancesInContext:context].count, 1, @"1 company");
    XCTAssertNotEqual([WXAccount allInstancesInContext:context].count, 2, @"1 account");
    XCTAssertNotEqual([WXCompany allInstancesInContext:context].count, 3, @"1 company");
}

- (void)testSafelyPerformBlockBackgroundThreadMainContext
{
    NSManagedObjectContext *context = [NSManagedObjectContext createAtUrl:nil
                                                                modelName:@"WXKit"
                                                              mergePolicy:NSMergeByPropertyObjectTrumpMergePolicyType
                                                               andOptions:nil];

    NSManagedObjectContext *mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];

    mainContext.persistentStoreCoordinator = context.persistentStoreCoordinator;

    [[NSNotificationCenter defaultCenter] addObserverForName:NSManagedObjectContextDidSaveNotification
                                                      object:mainContext
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      if (note.object != context) {
                                                          [context mergeChangesFromContextDidSaveNotification:note];
                                                      }
                                                  }];

    __block BOOL saveResult = NO;
    __block NSError *error;
    __block BOOL queueCompleted = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [mainContext safelyPerformBlockAndWait:^{
            WXAccount *account = [WXAccount createInContext:mainContext];
            account.username = @"test user name";
            WXCompany *company = [WXCompany createInContext:mainContext];
            account.company = company;
            [company addAccountObject:account];
            saveResult = [mainContext save:&error];
        }];
        queueCompleted = YES;

    });
    wait_while(queueCompleted, 10);

    XCTAssert(saveResult, @"saved");
    XCTAssertNil(error, @"test");
    XCTAssertEqual([WXAccount allInstancesInContext:context].count, 1, @"1 account");
    XCTAssertEqual([WXCompany allInstancesInContext:context].count, 1, @"1 company");
    XCTAssertNotEqual([WXAccount allInstancesInContext:context].count, 2, @"1 account");
    XCTAssertNotEqual([WXCompany allInstancesInContext:context].count, 3, @"1 company");
}

- (void)testSafelyPerformBlockMainThreadPrivateContext
{
    NSManagedObjectContext *context = [NSManagedObjectContext createAtUrl:nil
                                                                modelName:@"WXKit"
                                                              mergePolicy:NSMergeByPropertyObjectTrumpMergePolicyType
                                                               andOptions:nil];

    NSManagedObjectContext *mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];

    mainContext.persistentStoreCoordinator = context.persistentStoreCoordinator;

    [[NSNotificationCenter defaultCenter] addObserverForName:NSManagedObjectContextDidSaveNotification
                                                      object:mainContext
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      if (note.object != context) {
                                                          [context mergeChangesFromContextDidSaveNotification:note];
                                                      }
                                                  }];

    __block BOOL saveResult = NO;
    __block NSError *error;
    [mainContext safelyPerformBlockAndWait:^{
        WXAccount *account = [WXAccount createInContext:mainContext];
        account.username = @"test user name";
        WXCompany *company = [WXCompany createInContext:mainContext];
        account.company = company;
        [company addAccountObject:account];
        saveResult = [mainContext save:&error];
    }];


    XCTAssert(saveResult, @"saved");
    XCTAssertNil(error, @"test");
    XCTAssertEqual([WXAccount allInstancesInContext:context].count, 1, @"1 account");
    XCTAssertEqual([WXCompany allInstancesInContext:context].count, 1, @"1 company");
    XCTAssertNotEqual([WXAccount allInstancesInContext:context].count, 2, @"1 account");
    XCTAssertNotEqual([WXCompany allInstancesInContext:context].count, 3, @"1 company");
}

- (void)testSafelyPerformBlockBackgroundThreadPrivateContext
{
    NSManagedObjectContext *context = [NSManagedObjectContext createAtUrl:nil
                                                                modelName:@"WXKit"
                                                              mergePolicy:NSMergeByPropertyObjectTrumpMergePolicyType
                                                               andOptions:nil];

    NSManagedObjectContext *mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];

    mainContext.persistentStoreCoordinator = context.persistentStoreCoordinator;

    [[NSNotificationCenter defaultCenter] addObserverForName:NSManagedObjectContextDidSaveNotification
                                                      object:mainContext
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      if (note.object != context) {
                                                          [context mergeChangesFromContextDidSaveNotification:note];
                                                      }
                                                  }];

    __block BOOL saveResult = NO;
    __block NSError *error;
    __block BOOL queueCompleted = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [mainContext safelyPerformBlockAndWait:^{
            WXAccount *account = [WXAccount createInContext:mainContext];
            account.username = @"test user name";
            WXCompany *company = [WXCompany createInContext:mainContext];
            account.company = company;
            [company addAccountObject:account];
            saveResult = [mainContext save:&error];
        }];
        queueCompleted = YES;

    });
    wait_while(queueCompleted, 10);

    XCTAssert(saveResult, @"saved");
    XCTAssertNil(error, @"test");
    XCTAssertEqual([WXAccount allInstancesInContext:context].count, 1, @"1 account");
    XCTAssertEqual([WXCompany allInstancesInContext:context].count, 1, @"1 company");
    XCTAssertNotEqual([WXAccount allInstancesInContext:context].count, 2, @"1 account");
    XCTAssertNotEqual([WXCompany allInstancesInContext:context].count, 3, @"1 company");
}
@end
