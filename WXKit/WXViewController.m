//
//  WXViewController.m
//  WXKit
//
//  Created by Charlie Wu on 29/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXViewController.h"

@interface WXViewController ()

@end

@implementation WXViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    WXAlertView *alertView = [[WXAlertView alloc] initWithTitle:@"Color" message:@"Change Color" buttonTitle:@"Red" buttonAction:^{
        self.view.backgroundColor = [UIColor colorWithRed:0.857 green:0.267 blue:0.164 alpha:1.000];
    }];

    [alertView addButtonTitle:@"Blue" actionBlock:^{
        self.view.backgroundColor = [UIColor colorWithRed:0.255 green:0.564 blue:0.857 alpha:1.000];
    }];

    [alertView addButtonTitle:@"Green" actionBlock:^{
        self.view.backgroundColor = [UIColor colorWithRed:0.418 green:0.879 blue:0.187 alpha:1.000];
    }];

    [alertView show];
}



@end
