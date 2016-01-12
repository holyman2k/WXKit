//
//  WXAlertView.h
//  WXKit
//
//  Created by Charlie Wu on 29/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^WXAlertViewBlock)(void);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@interface WXAlertView : UIAlertView

+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                       buttonTitle:(NSString *)buttonTitle
                      buttonAction:(WXAlertViewBlock)block;

+ (instancetype)showAlertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                       buttonTitle:(NSString *)buttonTitle
                      buttonAction:(WXAlertViewBlock)block;


- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                  buttonTitle:(NSString *)cancelButtonTitle
                 buttonAction:(WXAlertViewBlock)block;

- (void)addButtonTitle:(NSString *)title actionBlock:(WXAlertViewBlock)block;

@end

@class WXAlertPickerView;

typedef void (^WXAlertPickerViewBlock)(WXAlertPickerView *alertView, NSUInteger selectedIndex);

@interface WXAlertPickerView : UIAlertView

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                 otherButtonTitles:(NSArray *)otherButtonTitles
                     buttonActions:(WXAlertPickerViewBlock)block;
#pragma clang diagnostic pop
@end
