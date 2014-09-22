//
//  WXTableViewController.m
//  WXKit
//
//  Created by Charlie Wu on 5/05/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXViewController.h"
#import "WXButton.h"
#import "WXBarButtonItem.h"

@interface WXViewController ()

@end

@implementation WXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect frame = CGRectMake(self.view.center.x - 40, self.view.center.y - 22, 80, 44);

    WXButton *button = [[WXButton alloc] initWithTitle:@"Action" andFrame:frame andAction:^(id sender) {

        NSLog(@"hello");
        self.view.tintColor = [UIColor grayColor];
    }];

    [self.view addSubview:button];

    WXBarButtonItem *barButton = [[WXBarButtonItem alloc] initWithTitle:@"bar action" style:UIBarButtonItemStyleBordered actionBlock:^(id sender) {
        NSLog(@"hello from bar action");
    }];

    self.navigationItem.rightBarButtonItem = barButton;
}

@end
