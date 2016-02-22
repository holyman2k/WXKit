//
//  WXTextInput.h
//  WXKit
//
//  Created by Charlie Wu on 5/05/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface WXTextInput : UIView

@property (nonatomic) IBInspectable NSString *text;
@property (nonatomic) IBInspectable NSString *labelText;
@property (nonatomic) IBInspectable NSString *validationMessage;

@end
