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

@end

@implementation WXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}


- (IBAction)start:(id)sender {

    NSLog(@"starting");
    [self.activityIndicator startAnimating];

    [[[[[WXOperationKit kit]
     joinTask:^id(NSDictionary *previousResults) {
         sleep(2);
         return @(10);
     } withName:@"start"]
    joinTask:^id(NSDictionary *previousResults) {
        sleep(3);
        return @(15);
    } withName:@"alsoStart"]
    thenDoTask:^id(NSDictionary *previousResults) {
        NSNumber *start = previousResults[@"start"];
        NSNumber *alsoStart = previousResults[@"alsoStart"];
        NSInteger value = start.integerValue + alsoStart.integerValue;
        NSLog(@"value %@", @(value));
        return @(value);
    } withName:@"ended"] startOnCompletion:^{
        NSLog(@"done");
        [self.activityIndicator stopAnimating];
    }];



}

@end
