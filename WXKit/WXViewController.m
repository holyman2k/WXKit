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
#import "WXProgressButton.h"

@interface WXViewController ()

@property (weak, nonatomic) IBOutlet WXProgressButton *progresssButton;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;

@end

@implementation WXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    CGRect frame = CGRectMake(self.view.center.x - 40, self.view.center.y - 22, 80, 44);
//
//    WXButton *button = [[WXButton alloc] initWithTitle:@"Action" andFrame:frame andAction:^(id sender) {
//
//        NSLog(@"hello");
//        self.view.tintColor = [UIColor grayColor];
//    }];
//
//    [self.view addSubview:button];
//
//    WXBarButtonItem *barButton = [[WXBarButtonItem alloc] initWithTitle:@"bar action" style:UIBarButtonItemStyleBordered actionBlock:^(id sender) {
//        NSLog(@"hello from bar action");
//    }];
//
//    self.navigationItem.rightBarButtonItem = barButton;

    self.progressSlider.hidden = YES;
    __weak typeof(self) weakSelf = self;
    [self.progresssButton.startButton setAction:^(id sender) {
        weakSelf.progressSlider.hidden = NO;
        weakSelf.progressSlider.value = 0;
        [weakSelf.progresssButton setStarted:YES];
        weakSelf.progresssButton.cancelButtonHidden = YES;
        weakSelf.progresssButton.progress = 0;
    }];

    [self.progresssButton.cancelButton setAction:^(id sender) {
        weakSelf.progressSlider.hidden = YES;
        [weakSelf.progresssButton setStarted:NO];
    }];

    WXProgressButton *progressButton = [[WXProgressButton alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    progressButton.startButtonTitle = @"Start";
    progressButton.cancelButtonHidden = NO;
    progressButton.lineWidth = 10;
    progressButton.showTrackingCircle = YES;
    progressButton.cancelButtonHidden = YES;
    progressButton.trackingCircleSizeRatio = 2;
    progressButton.cancelButtonRatio = 1;
    progressButton.cancelButton.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);

    CGPoint center = self.view.center;
    center.y += 150;

    progressButton.center = center;

    [self.view addSubview:progressButton];

    __weak typeof(progressButton) weakProgressButton = progressButton;
    [progressButton.startButton setAction:^(id sender) {
        weakSelf.progressSlider.hidden = NO;
        weakSelf.progressSlider.value = 0;
        weakProgressButton.progress = 0;
        weakProgressButton.cancelButtonHidden = YES;
        [weakProgressButton setStarted:YES];
    }];

    [progressButton.cancelButton setAction:^(id sender) {
        weakSelf.progressSlider.hidden = YES;
        [weakProgressButton setStarted:NO];
    }];
}

- (IBAction)progressSliderDidChange:(UISlider *)sender {
    [self.view.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if ([view isMemberOfClass:[WXProgressButton class]]) {
            WXProgressButton *progressButton = (WXProgressButton *)view;
            [progressButton setProgress:sender.value];
            if (sender.value == 1) {
                progressButton.cancelButtonHidden = NO;
            }
        }
    }];

}


@end
