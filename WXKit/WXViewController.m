//
//  WXTableViewController.m
//  WXKit
//
//  Created by Charlie Wu on 5/05/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXViewController.h"
#import "WXOperationKit.h"

@interface WXViewController ()
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation WXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}


- (IBAction)start:(id)sender {

    NSLog(@"starting");

    WXOperationKit *taskKit = [WXOperationKit kit];

    [taskKit doTask:^id(WXTuple *results) {
        NSLog(@"1");
        [self.activityIndicator startAnimating];
        self.label.text = @"started";
        return @(6);
    }];

    [taskKit doTask:^id(WXTuple *results) {
        NSLog(@"1.1");
        self.label.textColor = self.view.tintColor;
        return @(5);
    }];

    [taskKit doBackgroundTask:^id(WXTuple *value) {
        NSLog(@"1.2");
        sleep(2);
        return @(10);
    }];

    [taskKit thenDoTask:^id(WXTuple *results) {
        NSLog(@"2");
        self.label.textColor = self.view.tintColor;
        return nil;
    }];

    [taskKit doBackgroundTask:^id(WXTuple *results) {
        NSLog(@"2.1");
        sleep(1);
        return nil;
    }];

    [taskKit thenDoBackgroundTask:^id(WXTuple *results) {
        NSLog(@"3");
        NSInteger value = [results.first integerValue] + [results.second integerValue] + [results.thrid integerValue] + [results.fourth integerValue];

        NSLog(@"value %@", @(value));

        self.navigationItem.rightBarButtonItem.tintColor = self.view.tintColor;
        self.navigationItem.rightBarButtonItem.enabled = YES;

        return @(value);
    }];

    [taskKit doTask:^id(WXTuple *value) {

        NSLog(@"3.1");
        self.label.text = @"Stage 2";
        return nil;
    }];

    [taskKit thenDoTask:^id(WXTuple *value) {
        NSLog(@"end");
        self.label.text = @"ended";
        self.label.textColor = [UIColor darkGrayColor];
        return nil;
    }];

    [taskKit startOnCompletion:^{
        [self.activityIndicator stopAnimating];
    }];
}




@end
