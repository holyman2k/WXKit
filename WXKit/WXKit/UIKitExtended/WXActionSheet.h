//
//  WXActionSheet.h
//  WXKit
//
//  Created by Charlie Wu on 30/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^WXActionSheetBlock)(void);

@protocol WXCommonActionSheet <NSObject>

- (instancetype)initWithTitle:(NSString *)title;

- (instancetype)addButtonWithTitle:(NSString *)title andAction:(WXActionSheetBlock)action;

- (instancetype)addCancelButtonWithTitle:(NSString *)title andAction:(WXActionSheetBlock)action;

- (instancetype)addDesctructiveButtonWithTitle:(NSString *)title andAction:(WXActionSheetBlock)action;

- (void)showFromRect:(CGRect)rect inView:(UIView *)view andViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)showFromBarButtonItem:(UIBarButtonItem *)barButtonItem inViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)dismissActionSheetInViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

@interface WXActionSheetFactory : NSObject

+ (id<WXCommonActionSheet>)actionSheetWithTitle:(NSString *)title;

@end

@interface WXActionSheet : UIActionSheet <WXCommonActionSheet>

@end


@interface WXActionSheetController : UIAlertController <WXCommonActionSheet>

@end
