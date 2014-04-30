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
    [self.navigationController setToolbarHidden:NO animated:NO];

    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(barButtonHandler:)];
    self.toolbarItems = @[barButton];
//    WXAlertView *alertView = [WXAlertView alertViewWithTitle:@"Color" message:@"Change Color" buttonTitle:@"Cancel" buttonAction:nil];
//
//    [alertView addButtonTitle:@"Red" actionBlock:^{
//        self.view.backgroundColor = [UIColor colorWithRed:0.857 green:0.267 blue:0.164 alpha:1.000];
//    }];
//
//    [alertView addButtonTitle:@"Blue" actionBlock:^{
//        self.view.backgroundColor = [UIColor colorWithRed:0.255 green:0.564 blue:0.857 alpha:1.000];
//    }];
//
//    [alertView addButtonTitle:@"Green" actionBlock:^{
//        self.view.backgroundColor = [UIColor colorWithRed:0.418 green:0.879 blue:0.187 alpha:1.000];
//    }];
//
//    [alertView show];

//    [WXAlertPickerView showAlertWithTitle:@"Color"
//                                  message:@"Change Background Color"
//                        cancelButtonTitle:@"Cancel"
//                        otherButtonTitles:@[@"Red", @"Blue", @"Green"]
//                            buttonActions:^(WXAlertPickerView *alertView, NSUInteger selectedIndex) {
//                                switch (selectedIndex) {
//                                    case 1:
//                                        self.view.backgroundColor = [UIColor colorWithRed:0.857 green:0.267 blue:0.164 alpha:1.000];
//                                        break;
//                                    case 2:
//                                        self.view.backgroundColor = [UIColor colorWithRed:0.255 green:0.564 blue:0.857 alpha:1.000];
//                                        break;
//                                    case 3:
//                                        self.view.backgroundColor = [UIColor colorWithRed:0.418 green:0.879 blue:0.187 alpha:1.000];
//                                        break;
//                                    default:
//                                        break;
//                                }
//                            }];


}

- (void)barButtonHandler:(UIBarButtonItem *)sender
{
    WXActionSheet *actionSheet = [[WXActionSheet alloc] initWithTitle:@"Background Color"];

    [actionSheet addButtonWithTitle:@"Red" andAction:^{
        self.view.backgroundColor = [UIColor colorWithRed:0.857 green:0.267 blue:0.164 alpha:1.000];
    }];

    [actionSheet addButtonWithTitle:@"Blue" andAction:^{
        self.view.backgroundColor = [UIColor colorWithRed:0.152 green:0.482 blue:0.857 alpha:1.000];
    }];

    [actionSheet addButtonWithTitle:@"Green" andAction:^{
        self.view.backgroundColor = [UIColor colorWithRed:0.372 green:0.857 blue:0.451 alpha:1.000];
    }];

    [actionSheet addDesctructiveButtonWithTitle:@"Restore" andAction:^{
        self.view.backgroundColor = [UIColor whiteColor];
    }];

    [actionSheet addCancelButtonWithTitle:@"Cancel" andAction:nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
}


@end
