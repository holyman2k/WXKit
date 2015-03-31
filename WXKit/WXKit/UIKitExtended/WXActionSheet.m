//
//  WXActionSheet.m
//  WXKit
//
//  Created by Charlie Wu on 30/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXActionSheet.h"
#import "UIDevice+WXKit.h"

@implementation WXActionSheetFactory : NSObject

+ (id<WXCommonActionSheet>)actionSheetWithTitle:(NSString *)title {

    if ([UIDevice currentDeviceSystemVersion] < 8) {
        return [[WXActionSheet alloc] initWithTitle:title];
    } else {
        return [[WXActionSheetController alloc] initWithTitle:title];
    }
}

@end

@interface WXActionSheet() <UIActionSheetDelegate>

@property (strong, nonatomic) NSMutableDictionary *actionMap;

@end

@implementation WXActionSheet

NSString * const WXActionSheetDismissNotification = @"WXActionSheetDismissNotification";

+ (void)dismissAll
{
    [[NSNotificationCenter defaultCenter] postNotificationName:WXActionSheetDismissNotification object:nil];
}

- (NSMutableDictionary *)actionMap
{
    if (!_actionMap) _actionMap = [NSMutableDictionary new];
    return _actionMap;
}

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [self initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil]) {

    };

    return self;
}

- (instancetype)addButtonWithTitle:(NSString *)title andAction:(WXActionSheetBlock)action
{
    NSParameterAssert(title);
    self.actionMap[@(self.numberOfButtons)] = action ? action : ^(void){};
    [self addButtonWithTitle:title];
    return self;
}

- (instancetype)addCancelButtonWithTitle:(NSString *)title andAction:(WXActionSheetBlock)action
{
    NSParameterAssert(title);
    self.cancelButtonIndex = self.numberOfButtons;
    [self addButtonWithTitle:title andAction:action];
    self.actionMap[@(self.cancelButtonIndex)] = action && title ? action : ^(void){};
    return self;

}

- (instancetype)addDesctructiveButtonWithTitle:(NSString *)title andAction:(WXActionSheetBlock)action
{
    NSParameterAssert(title);
    self.destructiveButtonIndex = self.numberOfButtons;
    [self addButtonWithTitle:title];
    self.actionMap[@(self.destructiveButtonIndex)] = action && title ? action : ^(void){};
    return self;
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view andViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self showFromRect:rect inView:view animated:YES];
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)barButtonItem inViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self showFromBarButtonItem:barButtonItem animated:YES];
}

- (void)dismissActionSheetInViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self dismissWithClickedButtonIndex:-1 animated:animated];
}

#pragma mark - delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WXActionSheetDismissNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    WXActionSheetBlock block = self.actionMap[@(buttonIndex)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (block) block();
    });

    self.actionMap = nil;
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    // Only ever show one action sheet at a time
    [self.class dismissAll];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callDismissBlock:) name:WXActionSheetDismissNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callDismissBlock:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callDismissBlock:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)callDismissBlock:(NSNotification *)n { [self dismissWithClickedButtonIndex:self.cancelButtonIndex animated:YES]; }

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.actionMap = nil;
}

@end

@implementation WXActionSheetController

- (instancetype)initWithTitle:(NSString *)title {

    if (self = [super init]) {
        [self setTitle:title];
    }

    return self;
}

- (instancetype)addButtonWithTitle:(NSString *)title andAction:(WXActionSheetBlock)action {

    [self addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *alertAction) {
        if (action) action();
    }]];

    return self;
}

- (instancetype)addCancelButtonWithTitle:(NSString *)title andAction:(WXActionSheetBlock)action {

    [self addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *alertAction) {
        if (action) action();
    }]];
    return self;
}

- (instancetype)addDesctructiveButtonWithTitle:(NSString *)title andAction:(WXActionSheetBlock)action {

    [self addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:^(UIAlertAction *alertAction) {
        if (action) action();
    }]];
    return self;
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view andViewController:(UIViewController *)viewController animated:(BOOL)animated {

    self.modalPresentationStyle = UIModalPresentationPopover;
    self.popoverPresentationController.sourceView = view;
    self.popoverPresentationController.sourceRect = rect;

    [viewController presentViewController:self animated:YES completion:nil];
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)barButtonItem inViewController:(UIViewController *)viewController animated:(BOOL)animated {

    self.modalPresentationStyle = UIModalPresentationPopover;
    self.popoverPresentationController.barButtonItem = barButtonItem;

    [viewController presentViewController:self animated:YES completion:nil];
}

- (void)dismissActionSheetInViewController:(UIViewController *)viewController animated:(BOOL)animated {

    [viewController.presentedViewController dismissViewControllerAnimated:animated completion:nil];

}
@end
