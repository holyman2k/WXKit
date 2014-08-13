//
//  WXActionSheet.m
//  WXKit
//
//  Created by Charlie Wu on 30/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXActionSheet.h"

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

#pragma mark - delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WXActionSheetDismissNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    WXActionSheetBlock block = self.actionMap[@(buttonIndex)];
    if (block) block();
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


@end
