//
//  WXViewController.m
//  WXKit
//
//  Created by Charlie Wu on 29/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXViewController.h"
#import "WXTextInput.h"

@interface WXViewController ()
@property (weak, nonatomic) IBOutlet WXTextInput *username;
@property (weak, nonatomic) IBOutlet WXTextInput *password;

@end

@implementation WXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.username.labelText = @"Username";
    self.password.labelText = @"Password";


}




@end
