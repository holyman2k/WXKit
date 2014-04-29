//
//  WXAlertView.h
//  WXKit
//
//  Created by Charlie Wu on 29/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^WXAlertViewBlock)(void);

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
