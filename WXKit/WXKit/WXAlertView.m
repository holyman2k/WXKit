//
//  WXAlertView.m
//  WXKit
//
//  Created by Charlie Wu on 29/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXAlertView.h"

@interface WXAlertView()

@property (strong, nonatomic) NSMutableDictionary *actionMap;

@end

@implementation WXAlertView

+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                       buttonTitle:(NSString *)buttonTitle
                      buttonAction:(WXAlertViewBlock)block;
{
    WXAlertView *alertView = [[WXAlertView alloc] initWithTitle:title message:message buttonTitle:buttonTitle buttonAction:block];
    return alertView;
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                  buttonTitle:(NSString *)buttonTitle
                 buttonAction:(WXAlertViewBlock)block;
{
    if (self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:buttonTitle otherButtonTitles:nil]) {
        self.actionMap[@0] = block;

        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(applicationDidEnterBackground:)
                                                   name:UIApplicationDidEnterBackgroundNotification
                                                 object:nil];

    }
    return self;
}

- (NSMutableDictionary *)actionMap
{
    if (!_actionMap) _actionMap = [NSMutableDictionary new];
    return _actionMap;
}

- (void)addButtonTitle:(NSString *)title actionBlock:(WXAlertViewBlock)block
{
    self.actionMap[@(self.numberOfButtons)] = block;
    [self addButtonWithTitle:title];
}

- (void)show
{
    if ([NSThread isMainThread]) {
        [super show];
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [super show];
        });
    }
}

- (void)applicationDidEnterBackground:(id)sender
{
    [self dismissWithClickedButtonIndex:self.cancelButtonIndex animated:NO];
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
}

#pragma mark - delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    WXAlertViewBlock block = self.actionMap[@(buttonIndex)];
    block();
}

@end
