//
//  WXTableViewController.m
//  WXKit
//
//  Created by Charlie Wu on 5/05/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXViewController.h"
#import "WXTaskKit.h"

@interface WXViewController ()
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) WXTaskKit *taskKit;
@end

@implementation WXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (IBAction)start:(id)sender {

    NSLog(@"starting");
    [self runner2];

}

- (void)runner2 {
    WXTaskKit *taskKit = [WXTaskKit create];
    [taskKit doTask:^id{
        NSLog(@"1");
        return nil;
    }];

    [taskKit doTask:^id{
        NSLog(@"2");
        return nil;
    }];

    [taskKit doTask:^id{
        NSLog(@"3");
        return nil;
    }];
    [taskKit doTask:^id{
        NSLog(@"4");
        return nil;
    }];

    [taskKit startOnCompletion:nil];
    NSLog(@"next");
}

- (void)runner1 {

    WXTaskKit *taskKit = [WXTaskKit create];
    __block NSNumber *value;
    __block NSString *text;
    id task1 = [taskKit doTask:^id{
        [self.activityIndicator startAnimating];
        return nil;
    }];

    id task2 = [taskKit doTask:^id{
        self.label.text = @"started";
        return nil;
    }];


    id task3 = [taskKit waitForTasks:@[task1, task2] thenDoBackgroundTask:^id(WXTuple *results) {
        sleep(2);
        return @(10);
    }];


    id task4 = [taskKit doBackgroundTask:^id{
        sleep(1);
        return @(15);
    }];

    id task4_1 = [taskKit doBackgroundTask:^id{
        sleep(1);
        return @"hello world";
    }];

    id task5 = [taskKit waitForTasks:@[task3, task4, task4_1] thenDoBackgroundTask:^id(WXTuple *results) {
        sleep(2);
        value = @([results.first integerValue] + [results.second integerValue]);
        text = results.thrid;
        return nil;
    }];

    [taskKit waitForTasks:@[task5] thenDoTask:^id(WXTuple *results) {
        [self.activityIndicator stopAnimating];
        return nil;
    }];

    id task7 = [taskKit waitForTasks:@[task5] thenDoTask:^id(WXTuple *results) {
        self.label.text = @"done";
        return nil;
    }];

    [taskKit waitForTasks:@[task7] thenDoTask:^id(WXTuple *values) {
        sleep(1);
        return nil;
    }];

    [taskKit startOnCompletion:^{
        self.label.text = [NSString stringWithFormat:@"value is %@-%@", value, text];
        NSLog(@"tasks done with value %@ and text %@", value, text);
    }];
}

@end
